import 'dart:convert';

import 'package:api_trial/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SuperHero superHero = SuperHero();
  bool isClicked = false;
  Future<void> getData(String data) async {
    String baseUrl =
        'https://www.superheroapi.com/api.php/3262921770495550/search/$data';
    Response response = await get(baseUrl);
    if (response.statusCode == 200) {
      setState(() {
        var decodeData = jsonDecode(response.body);
        superHero = SuperHero(
          combat: decodeData['results'][0]['powerstats']['combat'],
          power: decodeData['results'][0]['powerstats']['power'],
          durability: decodeData['results'][0]['powerstats']['durability'],
          intelligence: decodeData['results'][0]['powerstats']['intelligence'],
          speed: decodeData['results'][0]['powerstats']['speed'],
          strength: decodeData['results'][0]['powerstats']['strength'],
        );
        print('Api Data returned');
        isClicked = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          isClicked = true;
          await getData('Superman');
        },
        child: Icon(Icons.refresh),
      ),
      appBar: AppBar(
        title: Text('Api Trial'),
      ),
      body: Center(
        child: isClicked
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(superHero.combat ?? " "),
                  Text(superHero.durability ?? " "),
                  Text(superHero.intelligence ?? " "),
                  Text(superHero.power ?? " "),
                  Text(superHero.speed ?? " "),
                  Text(superHero.strength ?? " "),
                ],
              ),
      ),
    );
  }
}
