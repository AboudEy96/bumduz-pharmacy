class Medicine {
  int id;
  String name;
  String time;
  int quantity;
  int userId; // one to many   user -> medicine[][][][]

  Medicine({required this.id, required this.name, required this.time, required this.quantity, required this.userId,});


}