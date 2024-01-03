import 'package:flutter/material.dart';
import 'package:onlines_store/Api/apihandler.dart';
import 'package:onlines_store/Components/homepage_tile.dart';
import 'package:onlines_store/I10n/app_localization_en.dart';
import 'package:onlines_store/I10n/app_localization_np.dart';
import 'package:onlines_store/Model/mycart.dart';
import 'package:onlines_store/Model/product.dart';
import 'package:onlines_store/main.dart';
import 'package:provider/provider.dart';
import '../Components/cache_manager.dart';
import 'package:badges/badges.dart' as badges;

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

  Future<void> _refreshProducts() async {
    setState(() {
      _productsFuture = _getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    var localeNotifier = Provider.of<LocaleNotifier>(context);
    var localizations = localeNotifier.locale.languageCode == 'en'
        ? Localizations.of<AppLocalizationsEn>(context, AppLocalizationsEn)!
        : Localizations.of<AppLocalizationsNp>(context, AppLocalizationsNp)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(localizations.title),
        actions: [
          IconButton(
            onPressed: () {
              final newLocale = localeNotifier.locale.languageCode == 'en'
                  ? const Locale('np', 'Nepal')
                  : const Locale('en', 'US');

              localeNotifier.setLocale(newLocale);
            },
            icon: const Icon(Icons.translate),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/search'),
            icon: const Icon(Icons.search),
          ),
          Consumer<CartProvider>(builder: (context, cartProvider, child) {
            return badges.Badge(
              position: badges.BadgePosition.topEnd(top: 0, end: 3),
              badgeAnimation: const badges.BadgeAnimation.fade(),
              badgeContent: Text(
                '${cartProvider.cartItemCount}',
                style: const TextStyle(color: Colors.white),
              ),
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, '/cart'),
                icon: const Icon(Icons.shopping_cart),
              ),
            );
          }),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: FutureBuilder<List<Product>>(
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
      ),
    );
  }
}
