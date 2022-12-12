import 'package:flutter/material.dart';
import 'package:mialbum_app/services/globals.dart';
import 'package:mialbum_app/shared/icons.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://pappcorn.com');

IconButton pappIconButton() {
  return IconButton(
    icon: const Icon(MiAlbumIcons.pappIcon, color: Global.pappColor),
    onPressed: () => _launchUrl(),
  );
}

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}
