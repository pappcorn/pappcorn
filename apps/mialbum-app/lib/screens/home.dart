import 'package:flutter/material.dart';
import 'package:mialbum_app/screens/album.dart';
import 'package:mialbum_app/screens/login.dart';
import 'package:mialbum_app/services/auth.dart';
import 'package:mialbum_app/shared/error.dart';
import 'package:mialbum_app/shared/loader.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const Center(
            child: ErrorMessage(),
          );
        } else if (snapshot.hasData) {
          return const AlbumScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
