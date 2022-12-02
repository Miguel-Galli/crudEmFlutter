import 'package:flutter/material.dart';
import 'package:substituicao/model/model.dart';
import 'package:substituicao/repository/repository.dart';
import 'package:substituicao/views/views.dart';
import 'package:url_launcher/url_launcher.dart';

class ListShinobi extends StatefulWidget {
  @override
  _ListShinobiState createState() => _ListShinobiState();
}

class _ListShinobiState extends State<ListShinobi> {

  late ShinobiRepository _repository;
  Future<void>?   _launched;

  _title(Shinobi shinobi) {
    return Row(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text('Ninja ${shinobi.id} - ${shinobi.name.toString()}'),
            )
          ],
        )
      ],
    );
  }

  _subtitle(Shinobi shinobi) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.arrow_upward),
                Text('${shinobi.level}')
              ],
            ),
            Row(
              children: [
                Icon(Icons.whatshot),
                Text('${shinobi.power}')
              ],
            ),
            Row(
              children: [
                Icon(Icons.person),
                Text('${shinobi.teacher}')
              ],
            )
          ],
        )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._repository = ShinobiRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Listar Ninjas'),),
      body: FutureBuilder(
        future: this._repository.fetchAll(),
        builder: (BuildContext context, AsyncSnapshot<List<Shinobi>> snapshot) {

          final List<Shinobi> shinobis = snapshot.data!;

          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: shinobis.length, //snapshot.data?.length
              itemBuilder: (BuildContext context, int index) {
                final Shinobi shinobi = shinobis[index];
                return Dismissible(
                    direction: DismissDirection.endToStart,
                    background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(Icons.delete_forever)
                    ),
                    key: ValueKey<int>(shinobi.id!),
                    onDismissed: (DismissDirection direction) async {
                      await this._repository.delete(shinobi);
                      setState(() {
                        snapshot.data!.remove(snapshot.data![index]);
                      });
                    },
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          print('Você escolheu ${shinobi.toString()}');
                          //chamando o alert.
                          _showAlert(
                              'Você deseja ver detalhes e/ou alterar?',
                              button1: 'Ver detalhes',
                              button2: 'Alterar',
                              button1Function: () {
                                //programo aqui..... GAMBIARRA LIKE A BOSS.
                                print('detalhes');
                                //......

                                setState(() {
                                  _launched = _makePhoneCall('tel:${shinobi.level.toString()}');
                                });

                              },
                              button2Function: () async {
                                //programo aqui..... GAMBIARRA LIKE A BOSS.
                                print('alterar');
                                Navigator.of(context).pop(); //fechando o alertDialog

                                final reloadPage = await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (BuildContext context)
                                    => RegisterShinobi(shinobi: shinobi,))
                                );
                                _reloadPage(reloadPage);
                              }
                          );
                        },
                        title: _title(shinobi),
                        subtitle: _subtitle(shinobi),
                        leading: CircleAvatar(backgroundColor: Colors.indigo,),
                      ),
                    )
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _reloadPage(bool reloadPage) {
    if(reloadPage) {
      setState(() {
        print('vai atualizar a tela no retorno do alterar');
      });
    }
  }

  _showAlert(String message, {String? title, String? button1, String? button2, Function? button1Function, Function? button2Function/*, String? button3*/}) {
    AlertDialog alert = AlertDialog(
        title: Text(title ?? 'Atenção'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              button1Function!();
            },
            child: Text(button1 ?? 'Sim'),
          ),
          TextButton(
            onPressed: () {
              button2Function!();
            },
            child: Text(button2 ?? 'Não'),
          ),
        ]
    );

    showDialog(context: context, builder: (BuildContext context) {
      return alert;
    });
  }

}
