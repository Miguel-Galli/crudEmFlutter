import 'package:flutter/material.dart';
import 'package:substituicao/model/model.dart';
import 'package:substituicao/repository/repository.dart';

class RegisterShinobi extends StatefulWidget {

  final Shinobi? shinobi;

  RegisterShinobi({this.shinobi});

  @override
  _RegisterShinobiState createState() => _RegisterShinobiState();
}

class _RegisterShinobiState extends State<RegisterShinobi> {

  final ShinobiRepository _repository = ShinobiRepository();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _levelController = new TextEditingController();
  TextEditingController _powerController = new TextEditingController();
  TextEditingController _teacherController = new TextEditingController();

  bool _isUpdate = false;

  _rowIcon() {
    return Icon(Icons.workspaces_outline, size: 150, color: Colors.blueGrey,);
  }

  _rowName() {
    return new TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.text,
      decoration: new InputDecoration(hintText: "Nome do Ninja"),
      maxLength: 50,
      validator: (value) {
        if(value!.isEmpty) {
          return 'Digite um nome válido!';
        }
        return null;
      },
    );
  }

  _rowLevel() {
    return new TextFormField(
      controller: _levelController,
      keyboardType: TextInputType.text,
      decoration: new InputDecoration(
        hintText: "LVL",
      ),
      maxLength: 50,
      validator: (value) {
        if(value!.isEmpty) {
          return 'Digite um level válido!';
        }
        return null;
      },
    );
  }

  _rowPower() {
    return new TextFormField(
      controller: _powerController,
      keyboardType: TextInputType.text,
      decoration: new InputDecoration(
        hintText: "Poder do Ninja",
      ),
      maxLength: 50,
      validator: (value) {
        if(value!.isEmpty) {
          return 'Digite um Poder válido!';
        }
        return null;
      },
    );
  }

  _rowTeacher() {
    return new TextFormField(
      controller: _teacherController,
      keyboardType: TextInputType.text,
      decoration: new InputDecoration(
        hintText: "Sensei do Ninja",
      ),
      maxLength: 50,
      validator: (value) {
        if(value!.isEmpty) {
          return 'Digite um Mestre válido!';
        }
        return null;
      },
    );
  }

  _rowButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        _register(context);
        _resetFields();
      },
      style: TextButton.styleFrom(
          primary: Colors.white,
          padding: EdgeInsets.all(20.0),
          backgroundColor: Theme.of(context).primaryColor
      ),
      label: Text(_isUpdate ? 'Alterar Ninja' : 'Cadastrar Ninja'),
      icon: Icon(Icons.add),
    );
  }

  _formUI(BuildContext context) {
    return Column(
      children: [
        _rowIcon(),
        _rowName(),
        _rowLevel(),
        _rowPower(),
        _rowTeacher(),
        _rowButton(context),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.shinobi != null) {
      _nameController.text = widget.shinobi!.name.toString();
      _levelController.text = widget.shinobi!.level.toString();
      _powerController.text = widget.shinobi!.power.toString();
      _teacherController.text = widget.shinobi!.teacher.toString();
      _isUpdate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_isUpdate ? 'Alterar Ninja' : 'Cadastro'),),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Text(_isUpdate ? 'Alterar' : 'Tela de cadastro'),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: _formUI(context),
            )
          ],
        ),)
    );
  }

  _register(BuildContext context) {
    print('Validou o formulário: ${_formKey.currentState!.validate()}');

    if(_formKey.currentState!.validate()) {

      if(_isUpdate) {

        widget.shinobi?.name = _nameController.text;
        widget.shinobi?.level = _levelController.text;
        widget.shinobi?.power = _powerController.text;
        widget.shinobi?.teacher = _teacherController.text;

        this._repository.update(widget.shinobi!);

        _showSnackBar('Ninja alterado com sucesso :-)');


      } else {

        final shinobi = Shinobi(
            name: _nameController.text,
            level: _levelController.text,
            power: _powerController.text,
            teacher: _teacherController.text
        );

        this._repository.save(shinobi);

        _showSnackBar('Ninja cadastrado com sucesso :-)');
      }


      setState(() {
        Navigator.pop(context, true);
      });

    } else {
      print('Digite os campos corretamente :-/');
      _showSnackBar('Digite os campos corretamente :-/');
    }
  }

  _resetFields() => _formKey.currentState!.reset();

  _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message, ),)
    );
  }
}
