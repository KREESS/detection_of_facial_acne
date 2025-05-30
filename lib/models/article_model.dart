import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;

class Article {
  final String title;
  final String imageUrl;
  final String description;

  Article({
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  static Future<List<Article>> fetchHealthlineArticles() async {
    final url = Uri.parse('https://www.healthline.com/skincare');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final document = html.parse(response.body);
      // Karena HTML-nya kompleks, kita cari elemen induk artikel
      // Contoh: cari semua div yang ada class css-w86ofi (judul) lalu ambil parentnya
      final titleElements = document.querySelectorAll(
        'a[data-testid="title-link"]',
      );

      List<Article> articles = [];

      for (var titleElement in titleElements) {
        // Judul
        final title = titleElement.text.trim();

        // Container induk, naik 2 level atau sesuai struktur asli
        final container = titleElement.parent;

        // Gambar (cari sibling atau anak di container)
        String imageUrl = '';
        if (container != null) {
          // Cari img di dalam container
          final imgElement = container.querySelector('img');
          if (imgElement != null) {
            imageUrl = imgElement.attributes['src'] ?? '';
          }
        }

        // Deskripsi, biasanya ada di <p> dengan <a data-testid="text-link">
        String description = '';
        if (container != null) {
          final descElement = container.querySelector(
            'a[data-testid="text-link"]',
          );
          if (descElement != null) {
            description = descElement.text.trim();
          }
        }

        // Pastikan setidaknya ada judul dan gambar atau deskripsi supaya valid
        if (title.isNotEmpty) {
          articles.add(
            Article(title: title, imageUrl: imageUrl, description: description),
          );
        }
      }

      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
