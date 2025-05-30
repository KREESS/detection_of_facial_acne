import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        'title': '🎉 Coming Soon: Premium Features!',
        'subtitle':
            'Nikmati fitur eksklusif seperti skin analyzer pro & rekomendasi produk personal.',
      },
      {
        'title': '🧴 Produk Baru Telah Tersedia!',
        'subtitle':
            'Lihat koleksi skincare terbaru yang baru saja kami tambahkan.',
      },
      {
        'title': '📢 Promo Akhir Pekan',
        'subtitle': 'Dapatkan diskon hingga 50% hanya sampai hari Minggu!',
      },
      {
        'title': '✨ Update Aplikasi',
        'subtitle':
            'Kami telah meningkatkan performa dan menambahkan fitur baru untuk pengalaman yang lebih baik.',
      },
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          elevation: 10,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true, // tombol back jika diperlukan
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue.shade600, Colors.blue.shade800],
              ),
            ),
          ),
          title: Text(
            'Notification',
            style: TextStyle(
              fontSize: 20, // ukuran yang proporsional
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 1.0,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black.withOpacity(0.4),
                  offset: const Offset(2, 2),
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
      ),

      body: ListView.separated(
        itemCount: notifications.length,
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notif['title'] ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  notif['subtitle'] ?? '',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
      backgroundColor: const Color(0xFFF5F7FA),
    );
  }
}
