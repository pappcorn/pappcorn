import 'package:flutter/material.dart';
import 'package:mialbum_app/services/globals.dart';
import 'package:mialbum_app/shared/icons.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          SizedBox(height: 250),
          SizedBox(
            width: 150,
            height: 150,
            child: CircularProgressIndicator(
              backgroundColor: Global.primaryColor,
              color: Global.secondaryColor,
              strokeWidth: 3,
            ),
          ),
          Text(
            'Guardando tus avances',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 64),
          Icon(
            MiAlbumIcons.pappIcon,
            color: Global.pappColor,
          ),
          Text(
            'Creado por el #EquipoPappCorn',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          SizedBox(height: 64),
        ]);
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[350],
        title: const Text(Global.title,
            style: TextStyle(color: Color(0xFF550067))),
        actions: [
          IconButton(
            icon: const Icon(MiAlbumIcons.pappIcon, color: Color(0xff00D9FF)),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: const Center(
        child: Loader(),
      ),
    );
  }
}
