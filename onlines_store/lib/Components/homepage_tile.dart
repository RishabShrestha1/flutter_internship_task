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
      image: product.image!,
      productId: product.id!,
      productName: product.title!,
      price: product.price!,
    );

    // Show dialog box to confirm
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          title: const Text('Add to Cart'),
          content: Text('Do you want to add ${product.title} to your cart?'),
          actions: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              width: 25.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
            ),
            SizedBox(width: 10.w), // 20p
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              width: 25.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  cartProvider.addToCart(item);
                },
                child: const Text('Yes'),
              ),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
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
                  Center(
                    child: Image.network(
                      widget.product.image!,
                      height: 15.h,
                      width: Adaptive.w(20),
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                  ),
                  const SizedBox(height: 5), // 10p
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
                      maxLines: 2,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
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
