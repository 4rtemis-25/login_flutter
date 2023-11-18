import 'package:flutter/material.dart';
import 'package:login/models/products.dart';

class ProductFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Products products;

  ProductFormProvider( this.products );

  updateAvailability( bool value) {
    print(value);
    products.available = value;
    notifyListeners();
  }

  bool isValidForm(){
    print(products.name);
    print(products.name);
    print(products.available);
    return formKey.currentState?.validate() ?? false;
  }

}