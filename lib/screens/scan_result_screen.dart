import 'package:flutter/material.dart';
// Import HomeScreen jika belum
import 'home_screen.dart'; // Pastikan path-nya benar

class ScanResultScreen extends StatelessWidget {
  final String masalah;

  const ScanResultScreen({super.key, required this.masalah});

  List<String> getRekomendasi(String masalah) {
    switch (masalah.toLowerCase()) {
      case 'berjerawat':
        return [
          'Somethinc Acne Spot Gel – Salicylic Acid, Sulfur',
          'Azarine Acne Spot Gel – Tea Tree Oil, Centella Asiatica',
          'Skintific 5X Ceramide Barrier Repair Moisturizer – Niacinamide, Ceramide',
          'The Ordinary Niacinamide 10% + Zinc 1%',
          'Acnecid Gel – Benzoyl Peroxide',
        ];
      case 'berminyak':
        return [
          'Emina Bright Stuff Face Wash – Niacinamide, Licorice',
          'The Ordinary Niacinamide 10% + Zinc 1%',
          'Innisfree Super Volcanic Clay Mask – Kaolin, Bentonite',
          'Azarine Oil-Free Brightening Moisturizer – Zinc, Aloe Vera',
        ];
      case 'dermatitis_perioral':
        return [
          'Cetaphil Gentle Skin Cleanser – Non-soap, Non-irritant',
          'CeraVe Moisturizing Cream – Ceramide, Hyaluronic Acid',
          'La Roche-Posay Toleriane Sensitive – Panthenol, Prebiotic Water',
          'Wardah Nature Daily Aloe Vera Gel – Soothing Aloe',
          'Konsultasikan ke dokter jika memburuk, hindari steroid',
        ];
      case 'kering':
        return [
          'Hada Labo Gokujyun Ultimate Moisturizing Lotion – Hyaluronic Acid',
          'CeraVe Moisturizing Cream – Ceramide, Glycerin',
          'Skintific 5X Ceramide Moisturizer – Ceramide, Centella Asiatica',
          'Vaseline Repairing Jelly – Occlusive agent untuk mengunci kelembapan',
        ];
      case 'normal':
        return [
          'Avoskin Your Skin Bae – Vitamin C, Hyaluronic Acid',
          'The Ordinary Hyaluronic Acid 2% + B5',
          'Emina Sun Protection SPF 30 – Lightweight sunscreen',
          'Wardah Perfect Bright Moisturizer – pencerah ringan + SPF',
        ];
      case 'penuaan':
        return [
          'Avoskin Miraculous Retinol Ampoule – Retinol, Peptides',
          'L’Oreal Revitalift – Pro-Retinol, Vitamin C',
          'Skintific 10% Vitamin C Serum – Ethyl Ascorbic Acid, Ferulic Acid',
          'Somethinc Level 1% Retinol – Gentle retinol untuk pemula',
        ];
      case 'vitiligo':
        return [
          'Aloe Vera Nature Republic – menenangkan kulit',
          'Viva Vitamin E Cream – melembapkan kulit sensitif',
          'Gunakan sunscreen setiap hari (Azarine Hydrasoothe SPF 45)',
          'Konsultasi ke dokter spesialis kulit untuk perawatan lanjutan',
        ];
      default:
        return ['Tidak ada rekomendasi khusus untuk masalah ini.'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final rekomendasiList = getRekomendasi(masalah);

    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: const Text(
          'Hasil Pemindaian',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.medical_information,
                      size: 60,
                      color: Colors.blue[700],
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Masalah Kulit Terdeteksi',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      masalah.replaceAll('_', ' '),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Rekomendasi Kandungan Skincare',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          rekomendasiList.map((item) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const HomeScreen(title: 'SmartSkin'),
                    ),
                  );
                },
                icon: const Icon(Icons.home),
                label: const Text(
                  'Kembali ke Beranda',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
