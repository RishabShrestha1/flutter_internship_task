import 'package:onlines_store/Model/product.dart';

Product sampleProduct = Product(
  id: 1,
  title: 'Sample Product',
  price: 19.99,
  image: 'https://example.com/sample_image.jpg',
  description: 'This is a sample product description.',
  category: 'Sample Category',
);

Map<String, dynamic> productJson = sampleProduct.toJson();
