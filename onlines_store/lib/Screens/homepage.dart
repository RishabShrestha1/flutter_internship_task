import 'package:flutter/material.dart';
import 'package:onlines_store/Api/apihandle.dart';
import 'package:onlines_store/Model/product.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

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
              onPressed: () => Navigator.pushNamed(context, '/search'),
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/cart'),
              icon: const Icon(Icons.shopping_cart),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(
            children: [
              Text('Home Page'),
              FutureBuilder(
                future: ApiHandle().fetchProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Product>? data = snapshot.data;
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Column(
                            children: [
                              Image.network(data[index].image.toString()),
                              Text(data[index].title.toString()),
                              Text(data[index].price.toString()),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const CircularProgressIndicator();
                },
              )
            ],
          )),
        ));
  }
}
