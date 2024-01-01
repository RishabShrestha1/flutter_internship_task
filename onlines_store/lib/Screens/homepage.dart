import 'package:flutter/material.dart';
import 'package:onlines_store/Api/apihandler.dart';
import 'package:onlines_store/Components/homepage_tile.dart';
import 'package:onlines_store/Model/product.dart';
import '../Components/cache_manager.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<Product>> _productsFuture;
  @override
  void initState() {
    _productsFuture = _getProducts();
    super.initState();
  }

  Future<List<Product>> _getProducts() async {
    final cachedProducts = await CacheManager.getCachedProducts();

    if (cachedProducts.isNotEmpty) {
      return cachedProducts;
    } else {
      final apiProducts = await ApiHandle().fetchProducts();
      await CacheManager.cacheProducts(apiProducts);
      return apiProducts;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Online Store'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/search'),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/cart'),
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.5,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ProductWidget(product: snapshot.data![index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
