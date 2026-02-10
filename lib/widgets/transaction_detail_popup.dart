import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';
import '../styles.dart';
import '../providers/balance_provider.dart';
import 'package:provider/provider.dart';

class TransactionDetailPopup extends StatefulWidget {
  final Transactions transaction;

  const TransactionDetailPopup({super.key, required this.transaction});

  @override
  State<TransactionDetailPopup> createState() => _TransactionDetailPopupState();
}

class _TransactionDetailPopupState extends State<TransactionDetailPopup> {
  late Transactions _localTrx;
  final DateFormat _df = DateFormat('d MMMM yyyy', 'it');

  @override
  void initState() {
    super.initState();
    _localTrx = widget.transaction;
  }

  void _editField(String field) async {
    switch (field) {
      case 'name':
        String? newName = await _showTextInputDialog('Nome', _localTrx.name);
        if (newName != null) setState(() => _localTrx = _localTrx.copyWith(name: newName));
        break;
      case 'amount':
        String? newAmount = await _showTextInputDialog('Importo', _localTrx.amount.toString(), isNumber: true);
        if (newAmount != null) {
          double? val = double.tryParse(newAmount);
          if (val != null) setState(() => _localTrx = _localTrx.copyWith(amount: val));
        }
        break;
      case 'date':
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _localTrx.date,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) setState(() => _localTrx = _localTrx.copyWith(date: picked));
        break;
      case 'frequency':
        String? newFreq = await _showSelectionDialog('Periodicità', ['Settimanale', 'Mensile', 'Bimestrale', 'Annuale']);
        if (newFreq != null) setState(() => _localTrx = _localTrx.copyWith(recurringFrequency: newFreq));
        break;
      case 'start':
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _localTrx.recurringStart ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) setState(() => _localTrx = _localTrx.copyWith(recurringStart: picked));
        break;
      case 'end':
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _localTrx.recurringEnd ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) setState(() => _localTrx = _localTrx.copyWith(recurringEnd: picked));
        break;
    }
  }

  Future<String?> _showTextInputDialog(String title, String initialValue, {bool isNumber = false}) {
    TextEditingController controller = TextEditingController(text: initialValue);
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Modifica $title'),
        content: TextField(
          controller: controller,
          keyboardType: isNumber ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annulla')),
          TextButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('Salva')),
        ],
      ),
    );
  }

  Future<String?> _showSelectionDialog(String title, List<String> options) {
    return showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Seleziona $title'),
        children: options.map((opt) => SimpleDialogOption(
          onPressed: () => Navigator.pop(context, opt),
          child: Text(opt),
        )).toList(),
      ),
    );
  }

  double _calculateTotal() {
    if (!_localTrx.isRecurring || _localTrx.recurringStart == null || _localTrx.recurringEnd == null || _localTrx.recurringFrequency == null) {
      return _localTrx.amount;
    }
    int count = 0;
    DateTime current = _localTrx.recurringStart!;
    while (current.isBefore(_localTrx.recurringEnd!) || current.isAtSameMomentAs(_localTrx.recurringEnd!)) {
      count++;
      switch (_localTrx.recurringFrequency!.toLowerCase()) {
        case 'weekly':
        case 'settimanale':
          current = current.add(const Duration(days: 7));
          break;
        case 'monthly':
        case 'mensile':
          current = DateTime(current.year, current.month + 1, current.day);
          break;
        case 'bimonthly':
        case 'bimestrale':
          current = DateTime(current.year, current.month + 2, current.day);
          break;
        case 'yearly':
        case 'annuale':
          current = DateTime(current.year + 1, current.month, current.day);
          break;
        default:
          return _localTrx.amount;
      }
    }
    return _localTrx.amount * count;
  }

  @override
  Widget build(BuildContext context) {
    final s = appStyles(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.circular(28),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  _buildDataRow('Nome', _localTrx.name, () => _editField('name'), isDark),
                  _buildDataRow('Importo', '€ ${_localTrx.amount.toStringAsFixed(2)}', () => _editField('amount'), isDark),
                  _buildDataRow('Data', _df.format(_localTrx.date), () => _editField('date'), isDark),
                  
                  if (_localTrx.isRecurring) ...[
                    const SizedBox(height: 20),
                    Text(
                      _localTrx.isEntry ? 'Entrata Ricorrente' : 'Spesa Ricorrente',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _buildDataRow('Periodicità', _localTrx.recurringFrequency ?? 'Non definita', () => _editField('frequency'), isDark),
                    _buildDataRow('Dal', _localTrx.recurringStart != null ? _df.format(_localTrx.recurringStart!) : '-', () => _editField('start'), isDark),
                    _buildDataRow('Al', _localTrx.recurringEnd != null ? _df.format(_localTrx.recurringEnd!) : '-', () => _editField('end'), isDark),
                    
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Totale  ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        Text(
                          '${NumberFormat.currency(symbol: '', locale: 'it').format(_calculateTotal())}€',
                          style: TextStyle(
                            fontSize: 22, 
                            fontWeight: FontWeight.bold, 
                            color: _localTrx.isEntry ? Colors.green : Colors.red
                          ),
                        ),
                      ],
                    ),
                  ],
                  
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 239, 103, 103),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancella', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 60, 158, 163),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () {
                            Provider.of<BalanceProvider>(context, listen: false).updateTransaction(_localTrx);
                            Navigator.pop(context);
                          },
                          child: const Text('Salva', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: -10,
            child: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: const Icon(Icons.close, color: Colors.black, size: 28),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(String label, String value, VoidCallback onEdit, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withOpacity(0.05) : const Color(0xFFF5F5F7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text(value, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: onEdit,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
