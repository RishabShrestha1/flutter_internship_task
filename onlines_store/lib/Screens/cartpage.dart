import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Model/mycart.dart';

class Mycart extends StatefulWidget {
  const Mycart({Key? key}) : super(key: key);

  @override
  State<Mycart> createState() => _MycartState();
}

class _MycartState extends State<Mycart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          List<CartItem> cartItems = cartProvider.items;

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              CartItem item = cartItems[index];
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: Adaptive.w(20),
                        height: 10.h,
                        child: Image.network(
                          item.image,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(item.productName),
                          subtitle: Text('\$${item.price}'),
                          trailing: IconButton(
                            onPressed: () {
                              removeFromCart(context, item);
                            },
                            icon: const Icon(Icons.remove_shopping_cart),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void removeFromCart(BuildContext context, CartItem item) {
    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remove from Cart'),
          content:
              Text('Do you want to remove ${item.productName} from your cart?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                // Call the removeFromCart method from CartProvider
                Provider.of<CartProvider>(context, listen: false)
                    .removeFromCart(item);
                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
