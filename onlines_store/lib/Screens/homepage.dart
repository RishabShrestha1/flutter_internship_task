import 'package:flutter/material.dart';
import 'package:onlines_store/Api/apihandle.dart';
import 'package:onlines_store/Model/product.dart';
import '../Components/cache_manager.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Online Store'),
        actions: [
          IconButton(
            onPressed: () async {
              // Load products from cache
              final cachedProducts = await CacheManager.getCachedProducts();
              // Use cached products or fetch from API if cache is empty
              final products = cachedProducts.isNotEmpty
                  ? cachedProducts
                  : await ApiHandle().fetchProducts();

              // Cache the products
              CacheManager.cacheProducts(products);

              // Update the UI with products
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
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
        future: ApiHandle().fetchProducts(),
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
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/product',
                        arguments: snapshot.data![index]);
                  },
                  child: SizedBox(
                    height: 500,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                snapshot.data![index].image!,
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.scaleDown,
                              ),
                              const SizedBox(height: 10), // 10p
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data![index].title!.length > 20
                                      ? snapshot.data![index].title!
                                          .substring(0, 20)
                                      : snapshot.data![index].title!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  snapshot.data![index].description!.length > 50
                                      ? snapshot.data![index].description!
                                          .substring(0, 50)
                                      : snapshot.data![index].description!,
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
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Text('\$${snapshot.data![index].price}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add_shopping_cart),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
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
