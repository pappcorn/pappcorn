import 'package:flutter/material.dart';
import 'package:mialbum_app/services/auth.dart';
import 'package:mialbum_app/services/globals.dart';
import 'package:mialbum_app/services/models.dart';
import 'package:mialbum_app/shared/papp_webview.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen(
      {super.key,
      required this.title,
      required this.figures,
      required this.userName,
      required this.userEmail});

  final String title;
  final List<Figure> figures;
  final String userName;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Global.primaryFont,
        ),
        title: const Text(
          'Estadísticas',
          style: TextStyle(color: Global.primaryFont),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: Global.secondaryGradient,
        ),
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  userEmail,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Resumen de tus avances:',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Row(
                  children: [
                    Text(
                      '${getTotalCheckedFigures()}/${figures.length}',
                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Total',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  backgroundColor: const Color(0xFF2B0748),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xFFFDD501)),
                  value: (getTotalCheckedFigures() / figures.length),
                ),
                const SizedBox(height: 4),
                Text(
                  '${double.parse((getTotalCheckedFigures() / figures.length * 100).toStringAsFixed(2))}%',
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 250,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${getTotalCheckedEmblemFigures()}/${getTotalEmblemFigures()}',
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Emblemas',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${getTotalCheckedStadiumFigures()}/${getTotalStadiumFigures()}',
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Estadios',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${getTotalCheckedTeamShieldFigures()}/${getTotalTeamShieldFigures()}',
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Escudos',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${getTotalCheckedPlayerFigures()}/${getTotalPlayerFigures()}',
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Jugadores',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${getTotalCheckedMuseumFigures()}/${getTotalMuseumFigures()}',
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Museo',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${getTotalCheckedBelieversFigures()}/${getTotalBelieversFigures()}',
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Team Believers',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Row(
                    children: [
                      pappIconButton(),
                      const SizedBox(height: 8),
                      const Text(
                        'Creada por el #EquipoPappCorn',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                    size: 20,
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: () => AuthService().signOut(),
                  label: const Text(
                    'Salir de tu cuenta',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int getTotalCheckedFigures() {
    int total = 0;
    for (Figure figure in figures) {
      total += figure.checked ? 1 : 0;
    }
    return total;
  }

  int getTotalCheckedEmblemFigures() {
    int total = 0;
    for (Figure figure in figures) {
      total +=
          (figure.checked && figure.category == FigureCategory.EMBLEM) ? 1 : 0;
    }
    return total;
  }

  int getTotalEmblemFigures() {
    int total = 0;
    for (Figure figure in figures) {
      total += (figure.category == FigureCategory.EMBLEM) ? 1 : 0;
    }
    return total;
  }

  int getTotalCheckedStadiumFigures() {
    int total = 0;
    for (Figure figure in figures) {
      total +=
          (figure.checked && figure.category == FigureCategory.STADIUM) ? 1 : 0;
    }
    return total;
  }

  int getTotalStadiumFigures() {
    int total = 0;
    for (Figure figure in figures) {
      total += (figure.category == FigureCategory.STADIUM) ? 1 : 0;
    }
    return total;
  }

  int getTotalCheckedTeamShieldFigures() {
    int total = 0;
    for (Figure figure in figures) {
      total += (figure.checked && figure.type == FigureType.SHIELD) ? 1 : 0;
    }
    return total;
  }

  int getTotalTeamShieldFigures() {
    int total = 0;
    for (Figure figure in figures) {
      total += (figure.type == FigureType.SHIELD) ? 1 : 0;
    }
    return total;
  }

  int getTotalCheckedPlayerFigures() {
    int total = 0;
    for (Figure figure in figures) {
      total += (figure.checked && figure.type == FigureType.PLAYER) ? 1 : 0;
    }
    return total;
  }

  int getTotalPlayerFigures() {
    int total = 0;
    for (Figure figure in figures) {
      total += (figure.type == FigureType.PLAYER) ? 1 : 0;
    }
    return total;
  }

  int getTotalCheckedMuseumFigures() {
    int total = 0;
    for (Figure figure in figures) {
      total += (figure.checked && figure.category == FigureCategory.FIFA_MUSEUM)
          ? 1
          : 0;
    }
    return total;
  }

  int getTotalMuseumFigures() {
    int total = 0;
    for (Figure figure in figures) {
      total += (figure.category == FigureCategory.FIFA_MUSEUM) ? 1 : 0;
    }
    return total;
  }

  int getTotalCheckedBelieversFigures() {
    int total = 0;
    for (Figure figure in figures) {
      total +=
          (figure.checked && figure.category == FigureCategory.TEAM_BELIEVERS)
              ? 1
              : 0;
    }
    return total;
  }

  int getTotalBelieversFigures() {
    int total = 0;
    for (Figure figure in figures) {
      total += (figure.category == FigureCategory.TEAM_BELIEVERS) ? 1 : 0;
    }
    return total;
  }
}
