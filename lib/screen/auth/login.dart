import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register.dart';
import 'package:fin_track/widgets/custom_textfield.dart';
import 'package:fin_track/blocs/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(controller: emailController, hintText: 'Email'),
            SizedBox(height: 10),
            CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                isPassword: true),
            SizedBox(height: 20),
            BlocBuilder<AuthBloc, User?>(
              builder: (context, user) {
                return ElevatedButton(
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .login(emailController.text, passwordController.text);
                  },
                  child: Text('Login'),
                );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Belum punya akun? Daftar'),
            ),
          ],
        ),
      ),
    );
  }
}
