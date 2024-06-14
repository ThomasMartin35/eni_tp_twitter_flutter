import 'package:flutter/material.dart';

class FooterButton extends StatelessWidget {
  String label;

  FooterButton(this.label);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TextButton(
      onPressed: () {},
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.redAccent,
        ),
      ),
    ));
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          children: [
            FooterButton("Fil"),
            FooterButton("Notification"),
            FooterButton("Messages"),
            FooterButton("Moi"),
          ],
        ),
      ),
    );
  }
}
