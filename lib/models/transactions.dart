class Transactions {
  final int? id;
  final String name;
  final double amount;
  final String category;
  final List<String> tags;
  final bool isEntry; // true=Entrata, false=Uscita
  final DateTime date;
  final String? note;

  // Ricorrenza
  final bool isRecurring;
  final String? recurringFrequency; // 'daily', 'weekly', 'monthly', etc.
  final DateTime? recurringStart;
  final DateTime? recurringEnd;
  final int? recurringCount; // se usi un numero fisso di ripetizioni

  Transactions({
    this.id,
    required this.name,
    required this.amount,
    required this.category,
    required this.tags,
    required this.isEntry,
    required this.date,
    this.note,
    this.isRecurring = false,
    this.recurringFrequency,
    this.recurringStart,
    this.recurringEnd,
    this.recurringCount,
  });

  String get status{
    final now =DateTime.now();
    if(date.isAfter(DateTime(now.year, now.month, now.day, 23, 59, 59))){
      return isEntry ? 'In Arrivo' : 'Da Pagare';
    } else {
      return isEntry ? 'Ricevuto' : 'Pagato';
    }
       
  }

  // Conversioni per il DB
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'category': category,
      'tags': tags.join(','), // salva come stringa separata da virgole
      'isEntry': isEntry ? 1 : 0,
      'date': date.toIso8601String(),
      'note': note,
      'isRecurring': isRecurring ? 1 : 0,
      'recurringFrequency': recurringFrequency,
      'recurringStart': recurringStart?.toIso8601String(),
      'recurringEnd': recurringEnd?.toIso8601String(),
      'recurringCount': recurringCount,
    };
  }

  factory Transactions.fromMap(Map<String, dynamic> map) {
    return Transactions(
      id: map['id'],
      name: map['name'],
      amount: map['amount'],
      category: map['category'],
      tags: map['tags'] != null
          ? (map['tags'] as String).split(',')
          : <String>[],
      isEntry: map['isEntry'] == 1,
      date: DateTime.parse(map['date']),
      note: map['note'],
      isRecurring: map['isRecurring'] == 1,
      recurringFrequency: map['recurringFrequency'],
      recurringStart: map['recurringStart'] != null
          ? DateTime.parse(map['recurringStart'])
          : null,
      recurringEnd: map['recurringEnd'] != null
          ? DateTime.parse(map['recurringEnd'])
          : null,
      recurringCount: map['recurringCount'],
    );
  }

  Transactions copyWith({
    int? id,
    String? name,
    double? amount,
    String? category,
    List<String>? tags,
    bool? isEntry,
    DateTime? date,
    String? note,
    bool? isRecurring,
    String? recurringFrequency,
    DateTime? recurringStart,
    DateTime? recurringEnd,
    int? recurringCount,
  }) {
    return Transactions(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      isEntry: isEntry ?? this.isEntry,
      date: date ?? this.date,
      note: note ?? this.note,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringFrequency: recurringFrequency ?? this.recurringFrequency,
      recurringStart: recurringStart ?? this.recurringStart,
      recurringEnd: recurringEnd ?? this.recurringEnd,
      recurringCount: recurringCount ?? this.recurringCount,
    );
  }
}
