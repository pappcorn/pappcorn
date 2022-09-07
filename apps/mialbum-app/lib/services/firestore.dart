import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mialbum_app/services/models.dart';
import 'package:mialbum_app/shared/error.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String collection = FirestoreCollections.ALBUMS;

  Future<Album> getAlbum(albumId) {
    return _db
        .collection('albums')
        .doc(albumId)
        .get()
        .then((snap) => Album.fromJson(snap.data() ?? {}));
  }

  Future<Album> getFirstAlbumByOwner(ownerId) {
    return _db
        .collection('albums')
        .where('owner', isEqualTo: ownerId)
        .get()
        .then((snap) => Album.fromJson(snap.docs[0].data()));
  }

  Stream<Album> get dbAlbum {
    return _auth.userChanges().switchMap((user) {
      if (user == null) {
        return Stream<Album>.value(Album());
      } else {
        var dbAlbumStream = _db
            .collection(collection)
            .where('owner', isEqualTo: user.uid)
            .snapshots();
        return dbAlbumStream.map(
          (snap) =>
              snap.size > 0 ? Album.fromJson(snap.docs[0].data()) : Album(),
        );
      }
    });
  }

  Future<bool> updateAlbum(Album album) async {
    return await _db
        .collection(collection)
        .doc(album.key)
        .update(album.toJson())
        .then((value) => true)
        .catchError((_) => false);
  }

  Future<void> createNewAlbum() async {
    User? user = _auth.currentUser;
    final userId = user?.uid ?? '';
    final albumKey = const Uuid().v4();
    final albumRef = _db.collection(collection).doc(albumKey);
    final album = Album(
      dates: {
        "start": DateTime.now().millisecondsSinceEpoch,
        "lastUpdate": DateTime.now().millisecondsSinceEpoch,
        "end": 0,
      },
      managers: {userId: OwnerRol.ADMIN},
      name: 'New Album',
      owner: userId,
      key: albumRef.id,
      figures: newAlbumFigures(),
    );
    albumRef.set(album.toJson()).onError(
        (error, _) => ErrorMessage(message: 'error creando album $error'));
  }

  List<Figure> newAlbumFigures() {
    return [
      ...newFifaFigures(),
      ...newTeamsFigures(FigureCategory.GROUP_A, FigurePrefix.QAT),
      ...newTeamsFigures(FigureCategory.GROUP_A, FigurePrefix.ECU),
      ...newTeamsFigures(FigureCategory.GROUP_A, FigurePrefix.SEN),
      ...newTeamsFigures(FigureCategory.GROUP_A, FigurePrefix.NED),
      ...newTeamsFigures(FigureCategory.GROUP_B, FigurePrefix.ENG),
      ...newTeamsFigures(FigureCategory.GROUP_B, FigurePrefix.IRN),
      ...newTeamsFigures(FigureCategory.GROUP_B, FigurePrefix.USA),
      ...newTeamsFigures(FigureCategory.GROUP_B, FigurePrefix.WAL),
      ...newTeamsFigures(FigureCategory.GROUP_C, FigurePrefix.ARG),
      ...newTeamsFigures(FigureCategory.GROUP_C, FigurePrefix.KSA),
      ...newTeamsFigures(FigureCategory.GROUP_C, FigurePrefix.MEX),
      ...newTeamsFigures(FigureCategory.GROUP_C, FigurePrefix.POL),
      ...newTeamsFigures(FigureCategory.GROUP_D, FigurePrefix.FRA),
      ...newTeamsFigures(FigureCategory.GROUP_D, FigurePrefix.AUS),
      ...newTeamsFigures(FigureCategory.GROUP_D, FigurePrefix.DEN),
      ...newTeamsFigures(FigureCategory.GROUP_D, FigurePrefix.TUN),
      ...newTeamsFigures(FigureCategory.GROUP_E, FigurePrefix.ESP),
      ...newTeamsFigures(FigureCategory.GROUP_E, FigurePrefix.CRC),
      ...newTeamsFigures(FigureCategory.GROUP_E, FigurePrefix.GER),
      ...newTeamsFigures(FigureCategory.GROUP_E, FigurePrefix.JPN),
      ...newTeamsFigures(FigureCategory.GROUP_F, FigurePrefix.BEL),
      ...newTeamsFigures(FigureCategory.GROUP_F, FigurePrefix.CAN),
      ...newTeamsFigures(FigureCategory.GROUP_F, FigurePrefix.MAR),
      ...newTeamsFigures(FigureCategory.GROUP_F, FigurePrefix.CRO),
      ...newTeamsFigures(FigureCategory.GROUP_G, FigurePrefix.BRA),
      ...newTeamsFigures(FigureCategory.GROUP_G, FigurePrefix.SRB),
      ...newTeamsFigures(FigureCategory.GROUP_G, FigurePrefix.SUI),
      ...newTeamsFigures(FigureCategory.GROUP_G, FigurePrefix.CMR),
      ...newTeamsFigures(FigureCategory.GROUP_H, FigurePrefix.POR),
      ...newTeamsFigures(FigureCategory.GROUP_H, FigurePrefix.GHA),
      ...newTeamsFigures(FigureCategory.GROUP_H, FigurePrefix.URU),
      ...newTeamsFigures(FigureCategory.GROUP_H, FigurePrefix.KOR),
      ...newCocaColaFigures(),
    ];
  }

  List<Figure> newFifaFigures() {
    List<Figure> teamArray = [];
    for (var i = 0; i <= 29; i++) {
      teamArray.add(Figure(
        section: FigureSection.FIFA,
        checked: false,
        category: i <= 7
            ? FigureCategory.EMBLEM
            : i > 7 && i <= 18
                ? FigureCategory.STADIUM
                : FigureCategory.FIFA_MUSEUM,
        number: i,
        prefix: FigurePrefix.FWC,
      ));
    }
    return teamArray;
  }

  List<Figure> newTeamsFigures(String category, String prefix) {
    List<Figure> teamArray = [];
    for (var i = 1; i < 20; i++) {
      teamArray.add(Figure(
        section: FigureSection.TEAM,
        checked: false,
        category: category,
        type: i == 1 ? FigureType.SHIELD : FigureType.PLAYER,
        number: i,
        prefix: prefix,
      ));
    }
    return teamArray;
  }

  List<Figure> newCocaColaFigures() {
    List<Figure> teamArray = [];
    for (var i = 1; i <= 8; i++) {
      teamArray.add(Figure(
        section: FigureSection.COCA_COLA,
        checked: false,
        category: FigureCategory.TEAM_BELIEVERS,
        number: i,
        prefix: FigurePrefix.C,
      ));
    }
    return teamArray;
  }
}
