import 'package:flutter/material.dart';
import 'package:login/providers/login_provider.dart';
import 'package:login/ui/custom_inputs.dart';
import 'package:login/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Background(
            child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
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
              const SizedBox(
                height: 30,
              ),
              ChangeNotifierProvider(
                create: ( _ ) => LoginProvider(),
                child: const _Form(), 
              )
            ],
          )),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Crear Una Nueva Cuenta',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    )));
  }
}

class _Form extends StatelessWidget {
  const _Form({super.key});

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
        children: [
          TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: Custominput.authInputDecoracion(
                hintText: 'example@example.com',
                labelText: 'Correo Electrónico',
                prefixIcon: Icons.alternate_email_outlined,
              ),
              onChanged: ( value ) => loginForm.email = value,
              validator: ( value )  {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no es un correo'; 
              },
            ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: Custominput.authInputDecoracion(
                hintText: '********',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline,
              ),
              onChanged: ( value ) => loginForm.password = value,
              validator: ( value )  {
                if ( value != null && value.length >= 6 ) return null;
                return 'La contraseña debe de tener minimo 6 caracteres'; 
              },
            ),
          const SizedBox(
            height: 30,
          ),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              onPressed: loginForm.isLoading ? null : () async {

                FocusScope.of(context).unfocus();

                if(!loginForm.isValidForm()) return;

                loginForm.isLoading = true;

                await Future.delayed(Duration(seconds: 2));

                loginForm.isLoading = false;

                Navigator.pushReplacementNamed(context, 'home');
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading
                  ? 'Ingresando...'
                  : 'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      )),
    );
  }
}
