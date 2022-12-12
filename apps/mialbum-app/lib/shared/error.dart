import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mialbum_app/services/firestore.dart';
import 'package:mialbum_app/services/globals.dart';
import 'package:mialbum_app/shared/papp_webview.dart';

class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage(
      {super.key,
      this.message = 'No hemos encontrado un album con este usuario'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[350],
        title: const Text(Global.title,
            style: TextStyle(color: Color(0xFF550067))),
        actions: [
          pappIconButton(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            ElevatedButton.icon(
              icon: const Icon(
                FontAwesomeIcons.newspaper,
                color: Colors.white,
                size: 20,
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(12),
                backgroundColor: Colors.purple,
              ),
              onPressed: () => FirestoreService().createNewAlbum(),
              label:
                  const Text('Crear nuevo álbum', textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
