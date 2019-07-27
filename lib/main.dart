import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";

    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculateIMC() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade grau 1 (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obseidade grau 2 (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade grau 3 (${imc.toStringAsPrecision(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(Icons.person_outline, size: 120, color: Colors.blue),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Massa (kg)",
                            labelStyle: TextStyle(color: Colors.blue)),
                        style: TextStyle(color: Colors.blue),
                        controller: weightController,
                        validator: (value) {
                          if (value.isEmpty) return "Informe seu peso";
                        }),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Altura (cm)",
                            labelStyle: TextStyle(color: Colors.blue)),
                        style: TextStyle(color: Colors.blue),
                        controller: heightController,
                        validator: (value) {
                          if (value.isEmpty) return "Informe sua altura";
                        }),
                    Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                          height: 50,
                          child: RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) _calculateIMC();
                              },
                              child: Text("Calcular",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              color: Colors.blue),
                        )),
                    Text(_infoText,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue, fontSize: 20))
                  ],
                ))));
  }
}
