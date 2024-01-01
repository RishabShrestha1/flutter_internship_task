import 'package:flutter/material.dart';
import 'package:onlines_store/Model/mycart.dart';
import 'package:onlines_store/Model/product.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key, required this.product}) : super(key: key);

  final Product product;

  void _addToCart(BuildContext context, Product product) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    CartItem item = CartItem(
      image: product.image!,
      productId: product.id!,
      productName: product.title!,
      price: product.price!,
    );
    cartProvider.addToCart(item);

    // Show a snackbar or other feedback to indicate the item was added to the cart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} added to cart'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        product.image!,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.title!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Category: ${product.category}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Price: \$${product.price}',
                    style: const TextStyle(fontSize: 16, color: Colors.green),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 9.h),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _addToCart(context, product);
                      },
                      child: const Text('Add to Cart'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Buy Now'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
