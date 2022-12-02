import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(padding: const EdgeInsets.all(20.0)),
            Align(
              alignment: Alignment(0, -0.5),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                width: 250,
                height: 250,
                child: Image.asset("image/miguel.png"),
              ),),
            Padding(padding: const EdgeInsets.all(20.0)),
            Container(
                color: Colors.blueGrey.shade400,
                padding:  const EdgeInsets.all(20.0),
                child: Text('Me chamo Miguel Guedes de Oliveira, desenvolvi este app onde podemos alimentar com informações sobre ninjas consistindo em seu level, poder e Sensei para uma melhor analise de tal.''\nO app é baseado em um banco de dados inspirado no Mundo de Naruto. ', textAlign: TextAlign.justify, style: Theme.of(context).textTheme.headline6!)),
            Text('\nDados:', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6!),
            Text('Email: miguelguedes.oli@gmail.com\nGit: @Miguel-Galli', style: Theme.of(context).textTheme.headline6!),

          ],
        ),
      )
    );
  }
}
