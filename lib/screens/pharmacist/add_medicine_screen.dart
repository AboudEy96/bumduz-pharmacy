import 'package:flutter/material.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();

}

class _AddMedicineScreenState extends State<AddMedicineScreen> {

  // Geçici ilaç listesi (mock data)
  List<Map<String, String>> ilacListesi = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();

  // İlaç kaydetme fonksiyonu (mock data ile)
  void saveMedicine() {
    final String name = nameController.text.trim();
    final String dosage = dosageController.text.trim();
    final String time = timeController.text.trim();
    final String quantity = quantityController.text.trim();
    final String userId = userIdController.text.trim();

    // Form kontrolü
    if (name.isEmpty ||
        dosage.isEmpty ||
        time.isEmpty ||
        quantity.isEmpty ||
        userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
        ),
      );
      return;
    }

    // Veriyi listeye ekle
    setState(() {
      ilacListesi.add({
        "name": name,
        "dosage": dosage,
        "time": time,
        "quantity": quantity,
        "userId": userId,
      });
    });

    // Başarı mesajı
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Medicine added successfully'),
      ),
    );

    // Alanları temizle
    nameController.clear();
    dosageController.clear();
    timeController.clear();
    quantityController.clear();
    userIdController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    dosageController.dispose();
    timeController.dispose();
    quantityController.dispose();
    userIdController.dispose();
    super.dispose();
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F7F6),
      appBar: AppBar(
        title: const Text('Add Medicine'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(
                  Icons.add_box,
                  size: 60,
                  color: Colors.teal,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Add New Medicine',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                buildTextField(
                  controller: nameController,
                  label: 'Medicine Name',
                  icon: Icons.medication,
                ),
                buildTextField(
                  controller: dosageController,
                  label: 'Dosage',
                  icon: Icons.science,
                ),
                buildTextField(
                  controller: timeController,
                  label: 'Time',
                  icon: Icons.access_time,
                ),
                buildTextField(
                  controller: quantityController,
                  label: 'Quantity',
                  icon: Icons.inventory,
                  keyboardType: TextInputType.number,
                ),
                buildTextField(
                  controller: userIdController,
                  label: 'Patient/User ID',
                  icon: Icons.person,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: saveMedicine,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Save Medicine',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

// Eklenen ilaçları göster
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ilacListesi.length,
                  itemBuilder: (context, index) {
                    final ilac = ilacListesi[index];

                    return Card(
                      child: ListTile(
                        title: Text(ilac["name"]!),
                        subtitle: Text(
                          "User: ${ilac["userId"]} | Time: ${ilac["time"]}",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
