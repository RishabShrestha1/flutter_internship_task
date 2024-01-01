import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onlines_store/Api/apihandler.dart';
import 'package:onlines_store/Components/searchpage_tile.dart';
import 'package:onlines_store/Model/product.dart';
import '../Components/cache_manager.dart';
// Import the search result item

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search products...',
          ),
          onSubmitted: (value) {
            _performSearch();
          },
          onChanged: (value) {
            _performSearch();
          },
        ),
      ),
      body: Container(
        child: _buildSearchResults(),
      ),
    );
  }

// create a method to perform the search and update the UI
  void _performSearch() async {
    String searchText = _searchController.text;
    if (searchText.isNotEmpty) {
      try {
        // Attempt to get cached results first
        List<Product> cachedResults = await CacheManager.getCachedProducts();
        if (cachedResults.isNotEmpty) {
          setState(() {
            _searchResults = _filterResults(cachedResults, searchText);
          });
        }

        // Fetch and cache new results
        List<Product> results = await ApiHandle().searchProducts(searchText);
        await CacheManager.cacheProducts(results);

        setState(() {
          _searchResults = _filterResults(results, searchText);
        });
      } catch (e) {
        if (kDebugMode) {
          print('Error performing search: $e');
        }
      }
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

// create a method to filter the results using the search text and built-in Dart methods
  List<Product> _filterResults(List<Product> results, String searchText) {
    return results
        .where((product) =>
            product.title?.toLowerCase().contains(searchText.toLowerCase()) ??
            false)
        .toList();
  }

// create a method to build the search results dynamically
  Widget _buildSearchResults() {
    if (_searchResults.isNotEmpty) {
      return ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          return ProductSearchResultItem(product: _searchResults[index]);
        },
      );
    } else {
      return const Center(
        child: Text('No results found.'),
      );
    }
  }
}
