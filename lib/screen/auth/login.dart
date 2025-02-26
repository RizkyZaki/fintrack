import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'register.dart';
import 'package:fin_track/widgets/custom_textfield.dart';
import 'package:fin_track/blocs/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo di tengah atas form
            Center(
              child: Image.asset(
                'assets/images/logo.png', // Pastikan path ini benar
                height: 100,
              ),
            ),
            SizedBox(height: 20),

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
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          Center(child: CircularProgressIndicator()),
                    );
                    try {
                      await context
                          .read<AuthBloc>()
                          .login(emailController.text, passwordController.text);
                      Navigator.of(context).pop();
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.bottomSlide,
                        title: 'Login Berhasil',
                        desc: 'Anda berhasil masuk',
                        btnOkOnPress: () {},
                      ).show();
                    } catch (e) {
                      Navigator.of(context).pop();
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.bottomSlide,
                        title: 'Login Gagal',
                        desc: 'Email atau password salah',
                        btnOkOnPress: () {},
                      ).show();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
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
