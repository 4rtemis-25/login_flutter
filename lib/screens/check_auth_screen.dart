import 'package:flutter/material.dart';
import 'package:login/screens/screens.dart';
import 'package:login/services/auth_service.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.isLogged(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return Text('Espere');
            }

            if (snapshot.data == '') {
              Future.microtask(() {
                // Navigator.of(context).pushReplacementNamed('login');

                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const LoginScreen(),
                        transitionDuration: const Duration(seconds: 0)));
              });
            } else {
              Future.microtask(() {
              // Navigator.of(context).pushReplacementNamed('login');

              Navigator.pushReplacement(context, PageRouteBuilder(
                pageBuilder: ( _ , __, ___ ) => const HomeScreen(),
                transitionDuration: const Duration( seconds: 0 )
              ));

             });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
