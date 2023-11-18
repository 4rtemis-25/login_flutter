import 'package:flutter/material.dart';
import 'package:login/screens/screens.dart';
import 'package:login/services/service.dart';
import 'package:login/widgets/product_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);

    if( productsService.isLoading ) return LoadingScreen(); 

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
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
        onPressed: (){},
      ),
    );
  }
}