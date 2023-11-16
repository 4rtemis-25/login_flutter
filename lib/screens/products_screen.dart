import 'package:flutter/material.dart';
import 'package:login/ui/custom_inputs.dart';
import 'package:login/widgets/widgets.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                const ProductImage(),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 40, color: Colors.white,)
                  )
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white,)
                  )
                )
              ],
            ),

            _ProductForm(),

            const SizedBox( height: 100, )

          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_outlined),
        onPressed: (){}
      ),

    );
  }
}

class _ProductForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _BuildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              SizedBox( height: 10, ),
              TextFormField(
                decoration: Custominput.authInputDecoracion(
                  hintText: 'Nombre del Producto',
                  labelText: 'Nombre:'
                ),
              ),
              SizedBox( height: 30, ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: Custominput.authInputDecoracion(
                  hintText: '\$150',
                  labelText: 'Precio:'
                ),
              ),
              SizedBox( height: 30, ),

              SwitchListTile.adaptive(
                value: true,
                title: Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: ( value ) {

                }
              ),

              SizedBox( height: 30, ),
            ],
          )
        ),
      ),
    );
  }

  BoxDecoration _BuildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.only( bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25) ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0, 5),
        blurRadius: 5
      )
    ]
  );
}