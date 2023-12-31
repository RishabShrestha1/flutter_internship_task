import 'package:onlines_store/Model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CacheManager {
  static const String keyProducts = 'cached_products';

  static Future<void> cacheProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedProducts =
        products.map((product) => product.toJson()).toList();
    final jsonString = json.encode(encodedProducts);
    prefs.setString(keyProducts, jsonString);
  }

  static Future<List<Product>> getCachedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(keyProducts);
    if (jsonString != null) {
      final decodedData = json.decode(jsonString) as List<dynamic>;
      final cachedProducts =
          decodedData.map((item) => Product.fromJson(item)).toList();
      return cachedProducts.cast<Product>();
    }
    return [];
  }
}
