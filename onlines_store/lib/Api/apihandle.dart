import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:onlines_store/Model/product.dart';
import './constant.dart';

class ApiHandle {
  ApiConstant apiConstant = ApiConstant();
  Future<List<Product>> fetchProducts() async {
    var url = apiConstant.baseurl + apiConstant.allproducts;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Product> products =
          data.map((json) => Product.fromJson(json)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
