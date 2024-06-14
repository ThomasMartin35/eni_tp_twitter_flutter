import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:twitter/auth/user-storage.dart';
import 'package:twitter/helpers/app-validator.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() {
  runApp(const Login());
}

class Login extends StatelessWidget {
  const Login({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Color(0xffcb8f8f),
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
        });
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  // Clé pour le formulaire
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController(text: "isaac@gmail.com");

  // Un controller pour le password
  var passwordController = TextEditingController(text: "123456");

  // Lorsqu'on clique sur le bouton Submit du formulaire
  void onClickSubmit(BuildContext context) async {
    // Vérifier la validité du formulaire
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Préparer la requête avec l'email/password dans le body de la requête
    // Appeler l'API
    final headers = {"Content-Type": "application/json"};
    var body = convert.json.encode(
        {'email': emailController.text, 'password': passwordController.text});
    var response = await http.post(Uri.parse("http://127.0.0.1:3000/auth"),
        headers: headers, body: body);

    // Récupérer la réponse de l'API
    var responseJson = convert.jsonDecode(response.body);

    // Si code différent de 200, afficher un message d'erreur
    if (responseJson['code'] != "203") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erreur"),
            content: Text("Couple Email/Mot de passe incorrect"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    // Par défaut, stocker le token en cache
    var token = responseJson['data'] as String;
    UserStorage().refreshToken(token);

    // Changer de page
    Navigator.pushNamed(context, '/accueil');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffcb8f8f),
        title: Text(
          "Connexion",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "images/background_color.jpg",
            fit: BoxFit.cover,
          ),
          Padding(
              padding: const EdgeInsets.all(70),
              child: Column(
                children: [
                  Image(
                    image: AssetImage("images/unicorn_connexion.png"),
                    width: 180,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Connecte toi petite licorne",
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: emailController,
                          validator: AppValidators.validateEmail,
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0x3fffffff),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passwordController,
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0x3fffffff),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          labelText: 'Mot de passe',
                          labelStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SwitchExample(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Mémoriser mes informations",
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Color(0xffcb8f8f)),
                            onPressed: () {
                              onClickSubmit(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text("Connexion"),
                            ))),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
