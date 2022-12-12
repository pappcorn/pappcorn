import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mialbum_app/services/auth.dart';
import 'package:mialbum_app/services/globals.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: Global.primaryGradient,
        ),
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 208,
              width: 145,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FutureBuilder<Object>(
                  future: SignInWithApple.isAvailable(),
                  builder: (context, snapshot) {
                    if (snapshot.data == true) {
                      return SignInWithAppleButton(
                        text: 'Iniciar sesión con Apple',
                        onPressed: () {
                          AuthService().signInWithApple();
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: const Icon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                    size: 20,
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    backgroundColor: Global.secondaryColor,
                  ),
                  onPressed: () => AuthService().googleLogin(),
                  label: const Text('Iniciar sesión con Google',
                      textAlign: TextAlign.center),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: const Icon(
                    FontAwesomeIcons.userNinja,
                    color: Colors.white,
                    size: 20,
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    backgroundColor: Global.secondaryColor,
                  ),
                  onPressed: () => AuthService().anonymousLogin(),
                  label: const Text('Continar sin registro',
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
