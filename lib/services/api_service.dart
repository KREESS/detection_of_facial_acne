import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

Future<List<Product>> fetchSkincareProducts() async {
  final response = await http.get(
    Uri.parse('http://makeup-api.herokuapp.com/api/v1/products.json'),
  );

  if (response.statusCode == 200) {
    List data = jsonDecode(response.body);
    print('Jumlah produk yang diterima: ${data.length}');
    return data.map((item) => Product.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}
