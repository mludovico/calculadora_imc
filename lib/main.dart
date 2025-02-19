import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightTextController = TextEditingController();
  TextEditingController heightTextController = TextEditingController();

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";
  void resetFields(){
    weightTextController.text = "";
    heightTextController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _globalKey = GlobalKey<FormState>();
    });
  }

  void calculate(){
    setState(() {
      double weight = double.parse(weightTextController.text);
      double height = double.parse(heightTextController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso normal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc > 40) {
        _infoText = "Obesidade grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Calculadora de IMC"),
      centerTitle: true,
      backgroundColor: Colors.green,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: resetFields),

      ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Form(
          key: _globalKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(Icons.person, size: 120.0, color: Colors.green,),
            TextFormField(keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Peso [Kg]", labelStyle: TextStyle(color: Colors.green)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),
              controller: weightTextController,
              validator: (value){
                if(value.isEmpty){
                  return "Insira seu peso!";
                }
              },
            ),
      TextFormField(keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: "Altura [cm]", labelStyle: TextStyle(color: Colors.green)),
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.green),
      controller: heightTextController,
      validator: (value){
    if(value.isEmpty){
    return "Insira sua altura!";
    }
    },
      ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Container(
            height: 50.0,
            child: RaisedButton(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              onPressed: (){
                if(_globalKey.currentState.validate())
                  calculate();
                },
                child: Text("Calcular",
               style: TextStyle(color: Colors.white, fontSize: 25.0),),
              color: Colors.green,
            )
          )
          ),
          Text(_infoText, textAlign: TextAlign.center, style: TextStyle(color: Colors.green, fontSize: 25.0),)
        ],
      ),
    )
    )
    );
  }
}
