import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:onlines_store/Model/product.dart';
import './constant.dart';

class ApiHandle {
  ApiConstant apiConstant = ApiConstant();
  //fetch all products from api and return a list of products
  Future<List<Product>> fetchProducts() async {
    var url = apiConstant.baseurl + apiConstant.allproducts;
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Product> products =
            data.map((json) => Product.fromJson(json)).toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } on Exception catch (e) {
      print(e);
      return <Product>[];
    }
  }

  searchProducts(String searchText) {
    var url = apiConstant.baseurl + apiConstant.allproducts;
    http.post(Uri.parse(url), body: {'searchText': searchText}).then((value) {
      print(value.body);
    });
  }
}
