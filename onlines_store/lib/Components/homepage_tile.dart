// product_widget.dart

import 'package:flutter/material.dart';
import 'package:onlines_store/Model/mycart.dart';
import 'package:onlines_store/Model/product.dart';
import 'package:onlines_store/Screens/productdetail.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductWidget extends StatefulWidget {
  final Product product;

  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  //add to cart method
  void _addToCart(BuildContext context, Product product) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    CartItem item = CartItem(
      productId: product.id!,
      productName: product.title!,
      price: product.price!,
    );

    // Show dialog box to confirm
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add to Cart'),
          content: Text('Do you want to add ${product.title} to your cart?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                cartProvider.addToCart(item);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(product: widget.product),
          ),
        );
      },
      child: SizedBox(
        height: 30.5.h,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    widget.product.image!,
                    height: 12.h,
                    width: double.infinity,
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(height: 20), // 10p
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.product.title!.length > 20
                          ? widget.product.title!.substring(0, 20)
                          : widget.product.title!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      widget.product.description!.length > 50
                          ? '${widget.product.description!.substring(0, 50)}......'
                          : widget.product.description!,
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Read More'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('\$${widget.product.price}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        _addToCart(context, widget.product);
                      },
                      icon: const Icon(Icons.add_shopping_cart),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
