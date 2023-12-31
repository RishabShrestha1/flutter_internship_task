import 'package:flutter/material.dart';
import 'package:onlines_store/Api/apihandler.dart';
import 'package:onlines_store/Model/product.dart';
import 'package:onlines_store/Screens/productdetail.dart';
import '../Components/cache_manager.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
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
        print('Error performing search: $e');
      }
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  List<Product> _filterResults(List<Product> results, String searchText) {
    return results
        .where((product) =>
            product.title?.toLowerCase().contains(searchText.toLowerCase()) ??
            false)
        .toList();
  }

  Widget _buildSearchResults() {
    if (_searchResults.isNotEmpty) {
      return ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductPage(product: _searchResults[index]),
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
                      _searchResults[index].image ?? '',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(_searchResults[index].title ?? ''),
                      subtitle: Text(
                        '\$${_searchResults[index].price.toString() ?? ''}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return Center(
        child: Text('No results found.'),
      );
    }
  }
}
