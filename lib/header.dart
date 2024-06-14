import 'package:flutter/material.dart';
import 'package:twitter/app-theme.dart';

class Headerbutton extends StatelessWidget {
  String? label;
  String? imgPath;

  Headerbutton({this.label, this.imgPath}) {}

  /// Fonction qui retournera la version Text du bouton
  Widget makeTextButton() {
    return Text(this.label!,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ));
  }

  /// Fonction qui retournera la version Icon du bouton
  Widget makeIconButton() {
    return IconButton(
      onPressed: () {},
      icon: Image.asset(this.imgPath!, width: 25),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Si l'image n'est pas null, alors on affiche la version icon
    if (this.imgPath != null) {
      return makeIconButton();
    }
    // Par défaut la version texte
    return makeTextButton();
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.primaryBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Headerbutton(imgPath: "images/pencil.png"),
            Headerbutton(label: "Accueil"),
            Headerbutton(
              imgPath: "images/search.png",
            )
          ],
        ),
      ),
    );
  }
}
