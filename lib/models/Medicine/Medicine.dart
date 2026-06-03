class Medicine {
  final String? id;
  final String name;
  final String dosage;
  final String time;
  final String quantity;
  final bool takenToday;

  Medicine({
    this.id,
    required this.name,
    required this.dosage,
    required this.time,
    required this.quantity,
    this.takenToday = false,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'dosage': dosage,
    'time': time,
    'quantity': quantity,
    'takenToday': takenToday,
  };

  factory Medicine.fromMap(String id, Map<String, dynamic> map) {
    return Medicine(
      id: id,
      name: map['name'],
      dosage: map['dosage'],
      time: map['time'],
      quantity: map['quantity'].toString(),
      takenToday: map['takenToday'] ?? false,
    );
  }
}