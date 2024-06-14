import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:twitter/auth/user-storage.dart';
import 'package:twitter/helpers/tweet.dart';

class CardButton extends StatelessWidget {
  String label;

  CardButton(this.label);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TextButton(
      onPressed: () {},
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ));
  }
}

class TweetCard extends StatefulWidget {
  @override
  State<TweetCard> createState() => _TweetCardState();
}

class _TweetCardState extends State<TweetCard> {
  var tweets = [];

  void onClickCallApi() async {
    // avant d'appeler une tâche asynchrone
    // afficher ecran de chargement
    var pd = ProgressDialog(context: context);
    pd.show(
        msg: "Récupération des tweets...",
        barrierColor: const Color(0x77000000),
        progressBgColor: Colors.transparent);

    // Simuler 1 seconde de lag
    await Future.delayed(const Duration(seconds: 1));

    UserStorage().token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImlzYWFjQGdtYWlsLmNvbSIsImlhdCI6MTcxODM2NTEyMCwiZXhwIjoxNzE4MzY4NzIwfQ.CRCEFQl6skxuKC-UBbBxXhwJ-NakuLyGsu_EdhJntQo";
    // Appeler une url http
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${UserStorage().token}',
    };

    var response = await http.get(
        Uri.parse("http://127.0.0.1:3000/v2/comment/all"),
        headers: headers);

    // Convertir la réponse en JSON
    var tweetsJson = convert.jsonDecode(response.body);

    if (tweetsJson['code'] != '200') {
      pd.close();
      return;
    }

    // Convertir le Json en liste de tweets
    tweets = tweetsJson["data"]
        .map((tweetJson) => Tweet.fromJson(tweetJson))
        .toList();

    // Afficher dans la console la liste de tweets
    print(tweets);

    // Fermer l'ecran de chargement
    pd.close();

    // Rafraichir l'ecran
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: FilledButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xffcb8f8f)),
              onPressed: () => onClickCallApi(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("Rafraîchir"),
              )),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: tweets.length,
              itemBuilder: (BuildContext context, int index) {
                var tweet = tweets[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child: Column(children: [
                      Container(
                        height: 120,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset(
                                "/images/unicorn_profile.png",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(tweet.author),
                                          Text("${tweet.formatDuration()}")
                                        ],
                                      ),
                                      Text(tweet.message)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                "assets/images/reply.png",
                                width: 30,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                "assets/images/retweet.png",
                                width: 30,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                "assets/images/favorite.png",
                                width: 30,
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
