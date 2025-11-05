import 'package:flutter/material.dart';
import '../styles.dart';

class DatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime> onDateSelected;

  const DatePicker({Key? key, this.initialDate, required this.onDateSelected}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Data operazione:', style: TextStyle(fontWeight: FontWeight.w500)),
        TextButton(
          child: Text(
            selectedDate != null
                ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                : 'Seleziona data',
            style: const TextStyle(color: Colors.blue),
          ),
          onPressed: () async {
            final now = DateTime.now();
            final chosen = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? now,
              firstDate: DateTime(now.year - 5, 1, 1), // puoi mettere anche primo gennaio 2000
              lastDate: DateTime(now.year + 5, 12, 31),
            );
            if (chosen != null) {
              setState(() {
                selectedDate = chosen;
              });
              widget.onDateSelected(chosen); // comunica la data al parent
            }
          },
        )
      ],
    );
  }
}
