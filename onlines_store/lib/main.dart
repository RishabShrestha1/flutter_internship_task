import 'package:flutter/material.dart';
import 'package:onlines_store/Model/sample.dart';
import 'package:onlines_store/Screens/cart.dart';
import 'package:onlines_store/Screens/homepage.dart';
import 'package:onlines_store/Screens/productdetail.dart';
import 'package:onlines_store/Screens/searchpage.dart';
import 'package:onlines_store/Theme/custom_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: mytheme,
          home: const Homepage(),
          routes: {
            '/home': (context) => const Homepage(),
            '/search': (context) => const SearchPage(),
            '/product': (context) => ProductPage(product: sampleProduct),
            '/cart': (context) => const Mycart(),
          },
        );
      },
    );
  }
}
