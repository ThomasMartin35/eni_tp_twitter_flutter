import 'package:flutter/material.dart';
import 'package:twitter/card.dart';
import 'package:twitter/footer.dart';
import 'package:twitter/header.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffcb8f8f),
        title: Text(
          "Unicorn-Twitter",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Header(),
          Expanded(
            child: TweetCard(),
          ),
          Footer(),
        ],
      ),
    );
  }
}
