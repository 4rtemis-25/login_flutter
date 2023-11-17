import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {

  final String? url;
   
  const ProductImage({Key? key, this.url}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _BuildBoxDecoration(),
        width: double.infinity,
        height: 450,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          child: url == null
          ? const Image(
            image: AssetImage('assets/no-image.jpg'),
            fit: BoxFit.cover,
          )
          :
          FadeInImage(
            image: NetworkImage(url!),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  BoxDecoration _BuildBoxDecoration() => BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.only( topLeft: Radius.circular(45), topRight: Radius.circular(45) ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: Offset(0, 5)
      )
    ]
  );


}