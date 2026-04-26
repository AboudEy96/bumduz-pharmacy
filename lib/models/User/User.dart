class User {
  int id;
  String name;
  String role; // [patient] [pharmacist]

 User({required this.id, required this.name,required  this.role});

  // ==== setter =====
  void setName(String name) {
    this.name = name;
  }
  void setID(int id) {
this.id = id;
  }
  //==== getter =====
String getName() {
    return this.name;
}
void getUserInfo() {
    print("($id) User: $name [$role]");
}

}