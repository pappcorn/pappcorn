import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mialbum_app/screens/login.dart';
import 'package:mialbum_app/screens/stats.dart';
import 'package:mialbum_app/services/auth.dart';
import 'package:mialbum_app/services/firestore.dart';
import 'package:mialbum_app/services/globals.dart';
import 'package:mialbum_app/services/models.dart';
import 'package:mialbum_app/shared/error.dart';
import 'package:mialbum_app/shared/figure.dart';
import 'package:mialbum_app/shared/loader.dart';
import 'package:mialbum_app/shared/papp_webview.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({Key? key}) : super(key: key);
  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  final StreamController<Album> _clientAlbum =
      StreamController<Album>.broadcast();
  get clientAlbum$ => _clientAlbum.stream.asBroadcastStream();

  User? user = AuthService().user;

  List<Figure> _figures = [];
  String _searchKeyword = '';
  bool _showLoader = false;
  bool _albumChanged = false;

  @override
  initState() {
    super.initState();
    FirestoreService().dbAlbum.listen((album) => {
          _figures = album.figures,
          _clientAlbum.add(album),
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: clientAlbum$,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else {
          if (snapshot.hasError) {
            return const ErrorMessage();
          } else if (snapshot.hasData) {
            if (_showLoader) {
              return const LoadingScreen();
            } else {
              Album album = snapshot.data;
              if (album.owner == '') {
                FirestoreService().createNewAlbum();
              }
              List<Figure> figures = album.figures;
              List<Figure> figuresFifaEmblemGroup =
                  getFifaFigures(figures, FigureCategory.EMBLEM);
              List<Figure> figuresFifaStadiumGroup =
                  getFifaFigures(figures, FigureCategory.STADIUM);
              List<Figure> figuresFifaMuseumGroup =
                  getFifaFigures(figures, FigureCategory.FIFA_MUSEUM);
              List<Figure> figuresQat = getTeamFigures(
                  figures, FigureCategory.GROUP_A, FigurePrefix.QAT);
              List<Figure> figuresEcu = getTeamFigures(
                  figures, FigureCategory.GROUP_A, FigurePrefix.ECU);
              List<Figure> figuresSen = getTeamFigures(
                  figures, FigureCategory.GROUP_A, FigurePrefix.SEN);
              List<Figure> figuresNed = getTeamFigures(
                  figures, FigureCategory.GROUP_A, FigurePrefix.NED);
              List<Figure> figuresEng = getTeamFigures(
                  figures, FigureCategory.GROUP_B, FigurePrefix.ENG);
              List<Figure> figuresIrn = getTeamFigures(
                  figures, FigureCategory.GROUP_B, FigurePrefix.IRN);
              List<Figure> figuresUsa = getTeamFigures(
                  figures, FigureCategory.GROUP_B, FigurePrefix.USA);
              List<Figure> figuresWal = getTeamFigures(
                  figures, FigureCategory.GROUP_B, FigurePrefix.WAL);
              List<Figure> figuresArg = getTeamFigures(
                  figures, FigureCategory.GROUP_C, FigurePrefix.ARG);
              List<Figure> figuresKsa = getTeamFigures(
                  figures, FigureCategory.GROUP_C, FigurePrefix.KSA);
              List<Figure> figuresMex = getTeamFigures(
                  figures, FigureCategory.GROUP_C, FigurePrefix.MEX);
              List<Figure> figuresPol = getTeamFigures(
                  figures, FigureCategory.GROUP_C, FigurePrefix.POL);
              List<Figure> figuresFra = getTeamFigures(
                  figures, FigureCategory.GROUP_D, FigurePrefix.FRA);
              List<Figure> figuresAus = getTeamFigures(
                  figures, FigureCategory.GROUP_D, FigurePrefix.AUS);
              List<Figure> figuresDen = getTeamFigures(
                  figures, FigureCategory.GROUP_D, FigurePrefix.DEN);
              List<Figure> figuresTun = getTeamFigures(
                  figures, FigureCategory.GROUP_D, FigurePrefix.TUN);
              List<Figure> figuresEsp = getTeamFigures(
                  figures, FigureCategory.GROUP_E, FigurePrefix.ESP);
              List<Figure> figuresCrc = getTeamFigures(
                  figures, FigureCategory.GROUP_E, FigurePrefix.CRC);
              List<Figure> figuresGer = getTeamFigures(
                  figures, FigureCategory.GROUP_E, FigurePrefix.GER);
              List<Figure> figuresJpn = getTeamFigures(
                  figures, FigureCategory.GROUP_E, FigurePrefix.JPN);
              List<Figure> figuresBel = getTeamFigures(
                  figures, FigureCategory.GROUP_F, FigurePrefix.BEL);
              List<Figure> figuresCan = getTeamFigures(
                  figures, FigureCategory.GROUP_F, FigurePrefix.CAN);
              List<Figure> figuresMar = getTeamFigures(
                  figures, FigureCategory.GROUP_F, FigurePrefix.MAR);
              List<Figure> figuresCro = getTeamFigures(
                  figures, FigureCategory.GROUP_F, FigurePrefix.CRO);
              List<Figure> figuresBra = getTeamFigures(
                  figures, FigureCategory.GROUP_G, FigurePrefix.BRA);
              List<Figure> figuresSrb = getTeamFigures(
                  figures, FigureCategory.GROUP_G, FigurePrefix.SRB);
              List<Figure> figuresSui = getTeamFigures(
                  figures, FigureCategory.GROUP_G, FigurePrefix.SUI);
              List<Figure> figuresCam = getTeamFigures(
                  figures, FigureCategory.GROUP_G, FigurePrefix.CMR);
              List<Figure> figuresPor = getTeamFigures(
                  figures, FigureCategory.GROUP_H, FigurePrefix.POR);
              List<Figure> figuresGha = getTeamFigures(
                  figures, FigureCategory.GROUP_H, FigurePrefix.GHA);
              List<Figure> figuresUru = getTeamFigures(
                  figures, FigureCategory.GROUP_H, FigurePrefix.URU);
              List<Figure> figuresKor = getTeamFigures(
                  figures, FigureCategory.GROUP_H, FigurePrefix.KOR);
              List<Figure> figuresCocaCola = getCocaColaFigures(figures);
              return Scaffold(
                appBar: AppBar(
                  iconTheme: const IconThemeData(color: Global.primaryFont),
                  backgroundColor: Colors.white,
                  title: const Text(Global.title,
                      style: TextStyle(color: Global.primaryFont)),
                  actions: [
                    pappIconButton(),
                  ],
                ),
                drawer: Drawer(
                    child: StatsScreen(
                  title: album.name,
                  figures: album.figures,
                  userName: user?.displayName ?? 'Usuario anónimo',
                  userEmail:
                      user?.email ?? 'No podrás usar tu lista en otras apps',
                )),
                body: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      pinned: true,
                      automaticallyImplyLeading: false,
                      backgroundColor: Global.secondaryColor,
                      elevation: 5.0,
                      expandedHeight: 100.0,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 24, 0, 0),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              focusColor: Colors.white,
                              border: InputBorder.none,
                              counterStyle: TextStyle(color: Colors.white),
                              labelText: 'Busca tu figura por el prefijo',
                              labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 12),
                              hintText: 'FWC, ARG, BRA, ECU, ...',
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 12),
                              suffixIcon:
                                  Icon(Icons.search, color: Colors.white),
                            ),
                            onChanged: (String value) {
                              _searchKeyword = value;
                              filterFigures(_searchKeyword, album);
                            },
                          ),
                        ),
                      ),
                    ),
                    const SliverPadding(padding: EdgeInsets.all(8)),
                    figuresFifaEmblemGroup.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate: Delegate('FWC - Emblemas', 'fwc-emblem'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresFifaEmblemGroup.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresFifaEmblemGroup[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresFifaEmblemGroup.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresFifaStadiumGroup.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate: Delegate('FWC - Estadios', 'fwc-stadium'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresFifaStadiumGroup.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresFifaStadiumGroup[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresFifaStadiumGroup.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresFifaMuseumGroup.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('FWC - Museo Fifa', 'fwc-fifa-museum'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresFifaMuseumGroup.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresFifaMuseumGroup[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresFifaMuseumGroup.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresQat.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo A - Qatar', 'qat'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresQat.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresQat[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresQat.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresEcu.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo A - Ecuador', 'ecu'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresEcu.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresEcu[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresEcu.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresSen.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo A - Senegal', 'sen'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresSen.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresSen[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresSen.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresNed.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo A - Holanda', 'ned'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresNed.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresNed[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresNed.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresEng.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate: Delegate(
                                'Equipos - Grupo B - Inglaterra', 'eng'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresEng.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresEng[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresEng.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresIrn.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo B - Irán', 'irn'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresIrn.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresIrn[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresIrn.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresUsa.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate: Delegate(
                                'Equipos - Grupo B - Estados Unidos', 'usa'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresUsa.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresUsa[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresUsa.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresWal.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo B - Walles', 'wal'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresWal.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresWal[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresWal.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresArg.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate: Delegate(
                                'Equipos - Grupo C - Argentina', 'arg'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresArg.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresArg[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresArg.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresKsa.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate: Delegate(
                                'Equipos - Grupo C - Arabia Saudita', 'ksa'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresKsa.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresKsa[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresKsa.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresMex.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo C - México', 'mex'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresMex.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresMex[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresMex.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresPol.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo C - Polonia', 'pol'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresPol.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresPol[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresPol.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresFra.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo D - Francia', 'fra'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresFra.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresFra[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresFra.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresAus.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate: Delegate(
                                'Equipos - Grupo D - Australia', 'aus'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresAus.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresAus[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresAus.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresDen.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate: Delegate(
                                'Equipos - Grupo D - Dinamarca', 'den'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresDen.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresDen[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresDen.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresTun.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo D - Tunez', 'tun'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresTun.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresTun[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresTun.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresEsp.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo E - España', 'esp'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresEsp.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresEsp[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresEsp.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresCrc.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate: Delegate(
                                'Equipos - Grupo E - Costa Rica', 'crc'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresCrc.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresCrc[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresCrc.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresGer.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo E - Alemania', 'ger'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresGer.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresGer[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresGer.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresJpn.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo E - Japón', 'jpn'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresJpn.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresJpn[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresJpn.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresBel.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo F - Bélgica', 'bel'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresBel.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresBel[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresBel.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresCan.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo F - Canadá', 'can'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresCan.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresCan[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresCan.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresMar.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate: Delegate(
                                'Equipos - Grupo F - Marruecos', 'mar'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresMar.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresMar[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresMar.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresCro.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo F - Croacia', 'cro'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresCro.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresCro[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresCro.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresBra.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo G - Brasil', 'bra'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresBra.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresBra[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresBra.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresSrb.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo G - Serbia', 'srb'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresSrb.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresSrb[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresSrb.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresSui.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo G - Suiza', 'sui'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresSui.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresSui[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresSui.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresCam.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo G - Camerún', 'cmr'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresCam.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresCam[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresCam.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresPor.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo F - Portugal', 'por'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresPor.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresPor[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresPor.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresGha.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo F - Ghana', 'gha'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresGha.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresGha[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresGha.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresUru.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate:
                                Delegate('Equipos - Grupo F - Uruguay', 'uru'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresUru.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresUru[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresUru.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresKor.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate: Delegate(
                                'Equipos - Grupo F - Korea del sur', 'kor'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresKor.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresKor[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresKor.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresCocaCola.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate: Delegate('CC - Team Believers', 'cc'),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                    figuresCocaCola.isNotEmpty
                        ? SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80.0,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final figure = figuresCocaCola[index];
                                  return FigureCard(
                                    figure: figure,
                                    callBack: () => toggleFigure(figure, album),
                                  );
                                },
                                childCount: figuresCocaCola.length,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox(height: 0),
                          ),
                  ],
                ),
                bottomNavigationBar: _albumChanged
                    ? BottomAppBar(
                        child: Container(
                          margin: const EdgeInsets.all(12.0),
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              FontAwesomeIcons.floppyDisk,
                              color: Colors.white,
                              size: 16,
                            ),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(12),
                              backgroundColor: Global.primaryColor,
                            ),
                            onPressed: () => saveAlbum(album),
                            label: const Text('Guardar cambios',
                                textAlign: TextAlign.center),
                          ),
                        ),
                      )
                    : const SizedBox(height: 0),
              );
            }
          } else {
            return const LoginScreen();
          }
        }
      },
    );
  }

  Future<void> saveAlbum(album) async {
    _showLoader = true;
    Album completeAlbum = Album(
        dates: album.dates,
        managers: album.managers,
        name: album.name,
        owner: album.owner,
        key: album.key,
        figures: _figures);
    await FirestoreService().updateAlbum(completeAlbum).then((saved) => {
          _showLoader = false,
          _albumChanged = false,
          if (saved)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Global.secondaryColor,
                  content:
                      const Text('😁 ¡El album se ha guardado correctamente!'),
                  action: SnackBarAction(
                    textColor: Global.primaryColor,
                    label: '¡Vamos!',
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                ),
              ),
              filterFigures(_searchKeyword, completeAlbum),
            }
          else
            {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Global.secondaryColor,
                  content: const Text(
                      '😰 Error al guardar el album, por favor intenta nuevamente'),
                  action: SnackBarAction(
                    textColor: Colors.white,
                    label: 'OK',
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                ),
              ),
            }
        });
  }

  void toggleFigure(Figure figure, Album album) {
    _albumChanged = true;
    for (var i = 0; i < album.figures.length; i++) {
      if (album.figures[i] == figure) {
        album.figures[i].checked = !album.figures[i].checked;
        _clientAlbum.add(album);
      }
    }
  }

  void filterFigures(String keyword, Album album) {
    final filteredFigures = _figures
        .where((figure) =>
            figure.prefix.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    if (keyword == '') {
      final filteredAlbum = Album(
          dates: album.dates,
          managers: album.managers,
          name: album.name,
          owner: album.owner,
          key: album.key,
          figures: _figures);
      _clientAlbum.add(filteredAlbum);
    } else {
      final filteredAlbum = Album(
          dates: album.dates,
          managers: album.managers,
          name: album.name,
          owner: album.owner,
          key: album.key,
          figures: filteredFigures);
      _clientAlbum.add(filteredAlbum);
    }
  }

  List<Figure> getFifaFigures(List<Figure> figures, String category) {
    List<Figure> categorizedFigures = [];
    for (var i = 0; i < figures.length; i++) {
      if (figures[i].category == category &&
          figures[i].section == FigureSection.FIFA) {
        categorizedFigures.add(figures[i]);
      }
    }
    return categorizedFigures;
  }

  List<Figure> getTeamFigures(
      List<Figure> figures, String category, String prefix) {
    List<Figure> categorizedFigures = [];
    for (var i = 0; i < figures.length; i++) {
      if (figures[i].category == category && figures[i].prefix == prefix) {
        categorizedFigures.add(figures[i]);
      }
    }
    return categorizedFigures;
  }

  List<Figure> getCocaColaFigures(List<Figure> figures) {
    List<Figure> categorizedFigures = [];
    for (var i = 0; i < figures.length; i++) {
      if (figures[i].section == FigureSection.COCA_COLA) {
        categorizedFigures.add(figures[i]);
      }
    }
    return categorizedFigures;
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final String _title;
  final String _icon;

  Delegate(this._title, this._icon);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Row(
            children: [
              Image.asset(
                'assets/flag-icons/$_icon.png',
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 8),
              Text(
                _title,
                style: const TextStyle(
                  color: Global.primaryFont,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ));
  }

  @override
  double get maxExtent => 32;

  @override
  double get minExtent => 32;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
