import 'package:flutter/material.dart';
import 'package:login/models/models.dart';
import 'package:login/screens/screens.dart';
import 'package:login/services/service.dart';
import 'package:login/widgets/product_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if( productsService.isLoading ) return LoadingScreen(); 

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        leading: IconButton(
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
          icon: Icon(Icons.login_outlined)
        ),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: ( BuildContext context, int index ) => GestureDetector(
          onTap: () {
            productsService.selectedProduct = productsService.products[index].copy();
            Navigator.pushNamed(context, 'products');
          },
          child: ProductCard(
            product: productsService.products[index],
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
           productsService.selectedProduct = Products(
            available: false,
            name: '',
            price: 0
          );
          Navigator.pushNamed(context, 'products', );
        },
      ),
    );
  }
}