import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Article1 {
  final String title;
  final String imageUrl;
  final String description;

  Article1({
    required this.title,
    required this.imageUrl,
    required this.description,
  });
}

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Article1> _allArticles = [
    Article1(
      title: 'What to Know About Your Skin Barrier and How to Protect It',
      imageUrl:
          'https://media.post.rvohealth.io/wp-content/uploads/2022/08/skin-barrier-732x549-thumbnail-732x549.jpg',
      description:
          'While dermatologists maintain that exfoliation is a great (and sometimes necessary) way to shed dead skin cells and reveal the fresh, radiant skin sitting below the surface, the recent popularity of cell-scrubbing cleansers, toners, grains, and serums means that many beauty enthusiasts are exfoliating a bit too much and a bit too often',
    ),
    Article1(
      title:
          'Hydrating and Moisturizing Aren’t the Same for Your Skin — Here’s Why',
      imageUrl:
          'https://media.post.rvohealth.io/wp-content/uploads/2020/09/11413-Hydrator_vs_Moisturizer_Breakdown-732x549-Thumbnail.jpg',
      description:
          'It also doesn’t hurt to use both a moisturizer and hydrator. Just hydrate by applying humectants like hyaluronic acid first, then follow up with an occlusive like plant oils to lock it in. Or, if you want to keep things simple, look for a product that does both. Face masks are a great option to get the one-two punch to hydrate and moisturize your skin with a single product. If you want a plump, hydrated complexion year-round, the answer is never just one or the other. After all, there’ll definitely be some point, like winter, where you’ll need to hydrate and moisturize — the key is knowing when.',
    ),
    Article1(
      title:
          'How to Skip the Beauty Buzzwords, Plus 12 Ingredients Derms Swear By',
      imageUrl:
          'https://media.post.rvohealth.io/wp-content/uploads/2022/08/Beauty-Buzzwords-Update-Images-732x549-thumbnail-1-732x549.jpg',
      description:
          'There’s a ton of noise in the beauty industry, with new trending ingredients constantly popping up on social media and other marketing avenues. But ingredients only scratch the surface of a product’s efficacy. Dermatologists say it’s also essential to evaluate potential side effects, skin type, and whether the ingredient is most effective when applied topically or taken orally. You can nix ingredients like synthetic fragrances, colors, and CBD oil from your regimen. Though they may enhance the smell and look of a product, items with these ingredients are more likely to cause allergic reactions.',
    ),
    Article1(
      title: 'Letter From the Editor: Getting Real About Skin Care',
      imageUrl:
          'https://media.post.rvohealth.io/wp-content/uploads/2022/09/HL-Skin_Care_Launch-Letter_from_the_Editor-732x549-Thumbnail-732x549.jpg',
      description:
          'The skin care landscape can be daunting, confusing, and at times, problematic. We may not be able to change the industry, but maybe we can help change your perspective, even just a little bit. Our experts are here to offer practical guidance and evidence-backed advice that transcends the latest social media hype and pop culture trends. If nothing else, we hope Healthline Skin Care can be a bridge to better understanding your personal skin needs — a place where you feel seen, find clarity, and have access to expert-backed solutions that work for you.',
    ),
    Article1(
      title: 'Healthline’s Evidence-Based Skin Care Ingredients Dictionary',
      imageUrl:
          'https://media.post.rvohealth.io/wp-content/uploads/2022/08/skincare-ingredient-dictionary-732x549-thumbnail-732x549.jpg',
      description:
          'Ever wanted a dictionary to help translate skin care labels? Look no further. This skimmable glossary covers common — and not-so-common — skin care ingredient staples so you can feel confident knowing what you’re putting on your skin. Is it evidence-based? Along with definitions, we’ve also included a quick guide to let you know whether each ingredient is evidence-based. We consulted Healthline’s medical review team so you can choose scientifically sound ingredients. Some are a clear yes, some only have evidence supporting topical or oral use, and others may have mixed, emerging, or limited evidence. Still, others may have historical or cultural uses that have stood the test of time.',
    ),
  ];

  List<Article1> _filteredArticles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // Simulasi loading awal 1.5 detik
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _filteredArticles = List.from(_allArticles);
        _isLoading = false;
      });
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(Duration(milliseconds: 600), () {
      final filtered =
          _allArticles.where((article) {
            final titleLower = article.title.toLowerCase();
            final descLower = article.description.toLowerCase();
            final searchLower = query.toLowerCase();
            return titleLower.contains(searchLower) ||
                descLower.contains(searchLower);
          }).toList();

      setState(() {
        _filteredArticles = filtered;
        _isLoading = false;
      });
    });
  }

  Future<void> _refreshArticles() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2)); // simulasi ambil data ulang

    setState(() {
      _filteredArticles = List.from(_allArticles);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          elevation: 10,
          backgroundColor: Colors.transparent,
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
            'Articles',
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
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search articles...',
                prefixIcon: const Icon(Icons.search, color: Colors.blue),
                filled: true,
                fillColor: Colors.blue[50],
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade200, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              style: TextStyle(color: Colors.blue[900]),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshArticles,
                child:
                    _isLoading
                        ? ListView.builder(
                          itemCount: 6, // jumlah shimmer cards
                          itemBuilder:
                              (context, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: _buildShimmerCard(),
                              ),
                        )
                        : _filteredArticles.isEmpty
                        ? Center(
                          child: Text(
                            'No articles found.',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        )
                        : ListView.builder(
                          itemCount: _filteredArticles.length,
                          itemBuilder: (context, index) {
                            final article = _filteredArticles[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        article.imageUrl,
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      article.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      article.description,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      height: 280, // sesuaikan tinggi card
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Bagian shimmer atas (gambar)
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.blue.shade100,
              highlightColor: Colors.blue.shade50,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
              ),
            ),
          ),
          // Bagian bawah hanya warna (tidak shimmer)
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 16, width: 100, color: Colors.blue.shade100),
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
    );
  }
}
