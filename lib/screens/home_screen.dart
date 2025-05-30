import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'products_screen.dart';
import 'scan_skin_screen.dart';
import 'content_screen.dart';
import '../models/product_model.dart';
import '../models/article_model.dart';
import '../services/api_service.dart';
import 'detail_product_screen.dart';
import 'notification_screen.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  int _selectedIndex = 0;
  List<Product> products = [];
  final List<Article> articles = [
    Article(
      title: 'What to Know About Your Skin Barrier and How to Protect It',
      imageUrl:
          'https://media.post.rvohealth.io/wp-content/uploads/2022/08/skin-barrier-732x549-thumbnail-732x549.jpg',
      description:
          'While dermatologists maintain that exfoliation is a great (and sometimes necessary) way to shed dead skin cells and reveal the fresh, radiant skin sitting below the surface, the recent popularity of cell-scrubbing cleansers, toners, grains, and serums means that many beauty enthusiasts are exfoliating a bit too much and a bit too often',
    ),
    Article(
      title:
          'Hydrating and Moisturizing Aren’t the Same for Your Skin — Here’s Why',
      imageUrl:
          'https://media.post.rvohealth.io/wp-content/uploads/2020/09/11413-Hydrator_vs_Moisturizer_Breakdown-732x549-Thumbnail.jpg',
      description:
          'It also doesn’t hurt to use both a moisturizer and hydrator. Just hydrate by applying humectants like hyaluronic acid first, then follow up with an occlusive like plant oils to lock it in. Or, if you want to keep things simple, look for a product that does both. Face masks are a great option to get the one-two punch to hydrate and moisturize your skin with a single product. If you want a plump, hydrated complexion year-round, the answer is never just one or the other. After all, there’ll definitely be some point, like winter, where you’ll need to hydrate and moisturize — the key is knowing when.',
    ),
    Article(
      title:
          'How to Skip the Beauty Buzzwords, Plus 12 Ingredients Derms Swear By',
      imageUrl:
          'https://media.post.rvohealth.io/wp-content/uploads/2022/08/Beauty-Buzzwords-Update-Images-732x549-thumbnail-1-732x549.jpg',
      description:
          'There’s a ton of noise in the beauty industry, with new trending ingredients constantly popping up on social media and other marketing avenues. But ingredients only scratch the surface of a product’s efficacy. Dermatologists say it’s also essential to evaluate potential side effects, skin type, and whether the ingredient is most effective when applied topically or taken orally. You can nix ingredients like synthetic fragrances, colors, and CBD oil from your regimen. Though they may enhance the smell and look of a product, items with these ingredients are more likely to cause allergic reactions.',
    ),
    Article(
      title: 'Letter From the Editor: Getting Real About Skin Care',
      imageUrl:
          'https://media.post.rvohealth.io/wp-content/uploads/2022/09/HL-Skin_Care_Launch-Letter_from_the_Editor-732x549-Thumbnail-732x549.jpg',
      description:
          'The skin care landscape can be daunting, confusing, and at times, problematic. We may not be able to change the industry, but maybe we can help change your perspective, even just a little bit. Our experts are here to offer practical guidance and evidence-backed advice that transcends the latest social media hype and pop culture trends. If nothing else, we hope Healthline Skin Care can be a bridge to better understanding your personal skin needs — a place where you feel seen, find clarity, and have access to expert-backed solutions that work for you.',
    ),
    Article(
      title: 'Healthline’s Evidence-Based Skin Care Ingredients Dictionary',
      imageUrl:
          'https://media.post.rvohealth.io/wp-content/uploads/2022/08/skincare-ingredient-dictionary-732x549-thumbnail-732x549.jpg',
      description:
          'Ever wanted a dictionary to help translate skin care labels? Look no further. This skimmable glossary covers common — and not-so-common — skin care ingredient staples so you can feel confident knowing what you’re putting on your skin. Is it evidence-based? Along with definitions, we’ve also included a quick guide to let you know whether each ingredient is evidence-based. We consulted Healthline’s medical review team so you can choose scientifically sound ingredients. Some are a clear yes, some only have evidence supporting topical or oral use, and others may have mixed, emerging, or limited evidence. Still, others may have historical or cultural uses that have stood the test of time.',
    ),
  ];

  late final List<Article> randomArticles;

  @override
  void initState() {
    super.initState();
    randomArticles = List<Article>.from(articles)..shuffle();
    randomArticles.removeRange(5, randomArticles.length);
    fetchData();
  }

  void fetchData() async {
    setState(() => isLoading = true);
    try {
      final fetchedProducts = await fetchSkincareProducts();
      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> _handleRefresh() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 10,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading:
              false, // Supaya gak ada back button default
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue.shade600, Colors.blue.shade800],
              ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
          ),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 22,
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
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductsScreen(),
                  ),
                );
              },
            ),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ),
                    );
                  },
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 15,
                      minHeight: 15,
                    ),
                    child: const Text(
                      '4',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      body: RefreshIndicator(
        onRefresh: _handleRefresh,

        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '✨ Hello, Glowing Skin!',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                  fontFamily: 'Poppins',
                  letterSpacing: 1.2,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 13),
              const Text(
                'Let your natural beauty shine through with personalized skincare made just for you.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF5E5E5E),
                  fontFamily: 'Poppins',
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 25),

              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9, // lebih simetris, kayak wrap
                padding: EdgeInsets.zero, // HILANGKAN padding default
                children: [
                  _customActionCard(Icons.search, 'Find\nProducts', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductsScreen(),
                      ),
                    );
                  }),
                  _customActionCard(Icons.face, 'Scan Skin', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ScanSkinScreen(title: 'Scan Skin'),
                      ),
                    );
                  }),
                  _customActionCard(Icons.description, 'Article', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContentScreen(),
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 25), // tambahkan ini biar pas sama wrap

              _sectionHeaderProduct('Our Products', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProductsScreen()),
                );
              }),

              const SizedBox(height: 10),

              // misalnya list produk:
              SizedBox(
                height: 170,
                child:
                    isLoading
                        ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5, // jumlah shimmer
                          itemBuilder: (context, index) {
                            return _shimmerProductCard();
                          },
                        )
                        : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => DetailProductScreen(
                                          product: product,
                                        ),
                                  ),
                                );
                              },
                              child: _horizontalProductCard(
                                product.name,
                                product.imageUrl,
                                isNetwork: true,
                              ),
                            );
                          },
                        ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Tips & Tricks for Face Care',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _tipsCard(),

              const SizedBox(height: 25),

              Text(
                'Articles',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              Column(
                children: [
                  // Bagian artikel (shimmer saat loading, artikel asli kalau tidak)
                  if (isLoading)
                    ...List.generate(5, (_) => _shimmerArticleCard())
                  else if (articles.isEmpty)
                    const Center(child: Text('No articles found'))
                  else
                    ...articles
                        .take(5)
                        .map(
                          (article) => Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: _articleCard(
                              title: article.title,
                              image: article.imageUrl,
                              description: article.description,
                            ),
                          ),
                        ),

                  const SizedBox(height: 16),

                  // Tombol View More selalu tampil (tidak tergantung loading)
                  Center(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>((
                                states,
                              ) {
                                return states.contains(MaterialState.hovered)
                                    ? Colors.white
                                    : Colors.transparent;
                              }),
                          foregroundColor: MaterialStateProperty.all(
                            Colors.black,
                          ),
                          side: MaterialStateProperty.all(
                            const BorderSide(color: Colors.black),
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              horizontal: 125,
                              vertical: 12,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ContentScreen(),
                            ),
                          );
                        },
                        child: const Text('View More'),
                      ),
                    ),
                  ),

                  const SizedBox(height: 85),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[100]!.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedItemColor: Colors.blue[800],
                unselectedItemColor: Colors.black54,
                currentIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = 0;
                  });

                  switch (index) {
                    case 1:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductsScreen(),
                        ),
                      );
                      break;
                    case 2:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ScanSkinScreen(title: 'Scan Skin'),
                        ),
                      );
                      break;
                    case 3:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContentScreen(),
                        ),
                      );
                      break;
                  }
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Find',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.face),
                    label: 'Scan',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.description),
                    label: 'Article',
                  ),
                ],
                type: BottomNavigationBarType.fixed,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _horizontalProductCard(
    String title,
    String imageSource, {
    bool isNetwork = false,
  }) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              height: 100,
              width: double.infinity,
              color: Colors.grey[200],
              child: Center(
                child:
                    isNetwork
                        ? Image.network(
                          imageSource,
                          fit: BoxFit.contain,
                          height: 90,
                          width: 140,
                          errorBuilder:
                              (context, error, stackTrace) => Container(
                                height: 90,
                                width: 140,
                                color: Colors.grey[300],
                                child: const Icon(Icons.broken_image, size: 40),
                              ),
                        )
                        : Image.asset(
                          imageSource,
                          fit: BoxFit.contain,
                          height: 90,
                          width: 140,
                        ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customActionCard(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.blue.shade800),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  // Bagian _sectionHeaderProduct
  Widget _sectionHeaderProduct(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        TextButton(onPressed: onTap, child: const Text('View More')),
      ],
    );
  }

  Widget _articleCard({
    required String title,
    required String image,
    required String description,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        // Aksi klik artikel, misal buka detail
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 60,
                    width: 60,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 30),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerProductCard() {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.blue.shade100,
        highlightColor: Colors.blue.shade50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16,
                    width: 100,
                    color: Colors.blue.shade100,
                  ),
                  const SizedBox(height: 6),
                  Container(height: 14, width: 60, color: Colors.blue.shade100),
                  const SizedBox(height: 4),
                  Container(
                    height: 14,
                    width: double.infinity,
                    color: Colors.blue.shade100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerArticleCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.blue.shade100,
        highlightColor: Colors.blue.shade50,
        child: Row(
          children: [
            // Placeholder gambar shimmer 60x60 kotak
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 10),
            // Placeholder teks judul dan deskripsi
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Judul shimmer, lebar 50-60% container
                  Container(
                    height: 14,
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 180),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Deskripsi shimmer, lebar lebih kecil
                  Container(
                    height: 12,
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 120),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Placeholder icon panah (bisa shimmer kotak kecil)
            Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tipsCard() {
    return Card(
      color: const Color(0xFFF0F8FF),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        initiallyExpanded: false,
        title: Row(
          children: const [
            Icon(Icons.tips_and_updates, color: Colors.orangeAccent),
            SizedBox(width: 8),
            Text(
              'View Helpful Tips',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
                fontSize: 16,
              ),
            ),
          ],
        ),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        children: const [
          ListTile(
            leading: Icon(Icons.check_circle, color: Colors.green),
            title: Text('Clean your face twice a day'),
          ),
          ListTile(
            leading: Icon(Icons.check_circle, color: Colors.green),
            title: Text('Exfoliate your skin weekly'),
          ),
          ListTile(
            leading: Icon(Icons.check_circle, color: Colors.green),
            title: Text('Always apply sunscreen, even on cloudy days'),
          ),
          ListTile(
            leading: Icon(Icons.check_circle, color: Colors.green),
            title: Text('Use a moisturizer that suits your skin type'),
          ),
          ListTile(
            leading: Icon(Icons.check_circle, color: Colors.green),
            title: Text('Get enough sleep to support skin regeneration'),
          ),
        ],
      ),
    );
  }
}
