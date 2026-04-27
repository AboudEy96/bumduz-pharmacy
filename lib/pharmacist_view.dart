import 'package:flutter/material.dart';

// Eczacı paneli ana ekranı
class PharmacistView extends StatefulWidget {
  const PharmacistView({super.key});

  @override
  State<PharmacistView> createState() => _PharmacistViewState();
}

class _PharmacistViewState extends State<PharmacistView> {

  // Geçici ilaç listesi (mock data)
  List<Map<String, String>> ilacListesi = [];

  // Hasta ID giriş kontrolü
  final TextEditingController hastaIdController = TextEditingController();

  // İlaç adı giriş kontrolü
  final TextEditingController ilacAdiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eczacı Paneli"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // Hasta ID input alanı
            TextField(
              controller: hastaIdController,
              decoration: const InputDecoration(
                labelText: "Hasta ID",
                border: OutlineInputBorder(),
              ),
            ),

            // İlaç adı input alanı
            TextField(
              controller: ilacAdiController,
              decoration: const InputDecoration(
                labelText: "İlaç Adı",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // İlaç ekleme butonu
            ElevatedButton(
              onPressed: () {

                // Form boş kontrolü (validation)
                if (hastaIdController.text.isEmpty ||
                    ilacAdiController.text.isEmpty) {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Lütfen tüm alanları doldurun"),
                    ),
                  );

                  return;
                }

                // Yeni ilaç listeye eklenir
                setState(() {
                  ilacListesi.add({
                    "hastaId": hastaIdController.text,
                    "ilacAdi": ilacAdiController.text,
                  });
                });

                // Kullanıcıya başarı mesajı gösterilir
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("İlaç başarıyla eklendi"),
                  ),
                );

                // Input alanları temizlenir
                hastaIdController.clear();
                ilacAdiController.clear();
              },

              child: const Text("İlaç Ekle"),
            ),

            // İlaç listesini gösteren bölüm
            Expanded(
              child: ListView.builder(
                itemCount: ilacListesi.length,
                itemBuilder: (context, index) {
                  final ilac = ilacListesi[index];

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(ilac["ilacAdi"]!),
                      subtitle: Text("Hasta ID: ${ilac["hastaId"]}"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
