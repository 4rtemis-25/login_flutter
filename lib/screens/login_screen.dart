import 'package:flutter/material.dart';
import 'package:login/widgets/background.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Background(),
    );
  }
}