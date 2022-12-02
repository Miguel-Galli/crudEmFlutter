import 'package:flutter/material.dart';
import 'package:substituicao/views/views.dart';

class Home extends StatefulWidget {

  final String title;

  const Home({Key? key, required this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: SingleChildScrollView ( child: Center(
          child: Column(
            children: [
              Container(
                padding:  const EdgeInsets.all(70.0),
                child: Image.asset("image/uzumaki.png"),),
              Padding(padding: const EdgeInsets.all(20.0)),
              Text('Bem Vindo ao Sistema dos Ninjas'),
              TextButton.icon(
                  onPressed: (){
                    print('Cadastrar Ninjas');
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext) => RegisterShinobi())
                    );
              },
                  label: Text('Cadastrar Ninjas'),
                  icon: Icon(Icons.add)
              ),
              TextButton.icon(
                  onPressed: (){
                    print('Listar Ninjas');
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext) => ListShinobi())
                    );
                  },
                  label: Text('Listar Ninjas'),
                  icon: Icon(Icons.list)
              ),
              TextButton.icon(
                  onPressed: (){
                    print('Listar Ninjas');
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext) => About())
                    );
                  },
                  label: Text('Sobre'),
                  icon: Icon(Icons.account_tree_outlined)
              ),
            ],
          ),
       ),
      ),
     );
   }
}
