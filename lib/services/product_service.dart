import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/models/products.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  
  final String _baseUrl = 'flutter-404621-default-rtdb.firebaseio.com';
  final List<Products> products = [];
  late Products selectedProduct;
  bool isLoading = true;

  ProductsService() {
    loadProducts();
  }

  Future<List<Products>> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get( url );

    final Map<String, dynamic> productsMap = json.decode( resp.body );

    productsMap.forEach((key, value) {
      final tempProduct = Products.fromRawJson( json.encode(value) );
      tempProduct.id = key;
      products.add(tempProduct);
    });
    isLoading = false;
    notifyListeners();

    return products;

  }

}