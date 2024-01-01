import 'package:flutter/material.dart';
import 'package:onlines_store/Model/product.dart';
import 'package:onlines_store/Screens/productdetail.dart';

class ProductSearchResultItem extends StatelessWidget {
  final Product product;

  const ProductSearchResultItem({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return product tile matching the search result that are clickable
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(product: product),
          ),
        );
      },
      child: Card(
        child: Row(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Image.network(
                product.image ?? '',
                fit: BoxFit.scaleDown,
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(product.title ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${product.description?.substring(0, 40)}......'),
                    Text(
                      '\$${product.price.toString()}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
