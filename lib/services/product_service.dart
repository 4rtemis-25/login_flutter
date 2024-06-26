import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:login/models/products.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  
  final String _baseUrl = 'flutter-404621-default-rtdb.firebaseio.com';
  final List<Products> products = [];
  late Products selectedProduct;
  File? newPicture;
  
  bool isLoading = true;
  bool isSaving = false;

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

  Future saveOrCreateProduct( Products product) async {

    isSaving = true;
    notifyListeners();

    if( product.id == null ) {
      await createProduct(product);
    } else {
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();

  }
  

  Future<String> updateProduct( Products product ) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final resp = await http.put(url, body: product.toRawJson());
    final decodedData = resp.body;

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct( Products product ) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.post(url, body: product.toRawJson());
    final decodedData = json.decode(resp.body);

    product.id = decodedData['name'];

    products.add(product);

    return product.id!;
  }

  void updateSelectedProductImage( String path ){
    selectedProduct.picture = path;
    newPicture = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if(newPicture == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/ds1gojhss/image/upload?upload_preset=lgqgopfi');

    final imageUpload = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', newPicture!.path);

    imageUpload.files.add(file);

    final streamedResponse = await imageUpload.send();
    final resp = await http.Response.fromStream(streamedResponse);

    if(resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('algo salió mal');
      print(resp.body);
      return null;
    }

    newPicture = null;

    final decodedData = json.decode( resp.body );
    return decodedData['secure_url'];

  }

}