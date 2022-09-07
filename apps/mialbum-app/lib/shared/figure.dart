import 'package:flutter/material.dart';
import 'package:mialbum_app/services/models.dart';

class FigureCard extends StatelessWidget {
  final Figure figure;
  final Function callBack;
  const FigureCard({Key? key, required this.figure, required this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: figure.checked ? const Color(0xFF2B0748) : Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  figure.prefix,
                  style: TextStyle(
                    color:
                        figure.checked ? Colors.white : const Color(0xFF2B0748),
                  ),
                ),
                Text(
                  figure.number.toString(),
                  style: TextStyle(
                    color:
                        figure.checked ? Colors.white : const Color(0xFF2B0748),
                  ),
                )
              ]),
          onTap: () {
            callBack();
          }),
    );
  }
}
