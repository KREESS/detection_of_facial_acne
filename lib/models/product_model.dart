class Product {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final String brand;
  final String category;
  final String productType;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.brand,
    required this.category,
    required this.productType,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'No Name',
      imageUrl: json['image_link'] ?? 'https://via.placeholder.com/150',
      description: json['description'] ?? 'No Description',
      brand: json['brand'] ?? 'No Brand',
      category: json['category'] ?? 'No Category',
      productType: json['product_type'] ?? 'No Product Type',
    );
  }
}
