import 'package:flutter/material.dart';
import 'package:substituicao/views/views.dart';

class App extends StatelessWidget {

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ninjas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       primarySwatch: Colors.blueGrey,
      ),
      home: const Home(title: 'Sistema dos Ninjas'),
    );
  }
}
