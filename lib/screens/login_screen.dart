import 'package:flutter/material.dart';
import 'package:login/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Background(
            child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 250,
          ),
          CardContainer(
              child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Login',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: 30,
              ),
              _Form()
            ],
          )),
          const SizedBox( height: 50, ),
          const Text('Crear Una Nueva Cuenta', style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold ),)
        ],
      ),
    )));
  }
}

class _Form extends StatelessWidget {
  const _Form({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2
                  )
                ),
                hintText: 'Correo Electronico',
                labelText: 'Correo',
                labelStyle: TextStyle(
                  color: Colors.grey
                ),
                prefixIcon: Icon( Icons.alternate_email_sharp, color: Colors.deepPurple, )
              ),
            )
          ],
        )
      ),
    );
  }
}