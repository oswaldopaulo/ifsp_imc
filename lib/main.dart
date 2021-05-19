import 'dart:math';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextAltura = TextEditingController();
  final TextPeso = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String _result = "";
  String _msg = "";

  void _limpar(){
    setState(() {
        TextAltura.clear();
        TextPeso.clear();
        _result ="";
        _msg = "";

    });
  }
  void _imc(double altura, double peso) {


    setState(() {
      altura = altura = pow(altura, 2);
      double res = peso /altura;
      _result = "Seu imc é " + (res).toStringAsPrecision(4);
      if (res.clamp(0.00, 18.49) == res) {
        _msg = "Voce esta abaixo do peso";

      } else if(res.clamp(18.50, 24.99) == res){
        _msg = "Peso Normal";
      } else if(res.clamp(25.00, 29.99) == res){
        _msg = "Sobre Peso";
      } else if(res.clamp(30.00, 34.99) == res){
        _msg = "Obesidade Grau I";
      } else if(res.clamp(35.00, 39.99) == res){
        _msg = "Obesidade Severa Grau II";
      }
      else if(res > 40.00){
        _msg = "Obesidade Mórbida Grau III";
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caculadora IMC'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                    _limpar();
                },
                child: Icon(
                  Icons.delete,
                  size: 26.0,
                ),
              )
          ),

        ],

      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 20,
            runSpacing: 10,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Entre com sua altura e peso',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.blue
                    ),
                    textAlign: TextAlign.center,

                  ),
                ),

              ),
              TextFormField(
                controller: TextAltura,
                validator: alturaValidador(),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
                //onChanged: updateNome,
                decoration: InputDecoration(
                    labelText: "Altura (metros Ex: 1.70)",
                ),
              ),
              TextFormField(
                controller: TextPeso,
                validator: pesoValidador(),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                 inputFormatters: [
                   FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                //onChanged: updateNome,
                decoration: InputDecoration(
                  labelText: "Peso (Kilos Ex: 80)",
                ),
              ),
              SizedBox(
                  width: double.infinity,
                 child: Text(
                   '$_result',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(

                  '$_msg',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
              ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                child: Text("Calcular"),

                onPressed: (){
                    if(_formkey.currentState.validate()){
                      _imc( double.parse(TextAltura.text) ?? 0.00, double.parse(TextPeso.text) ?? 0.00 );
                    }

                  },

              ),
          ),
            ],
          ),

        ),
      ),
    );
  }
}
TextFieldValidator alturaValidador(){
  return RequiredValidator(errorText: "Requirido");
}

TextFieldValidator pesoValidador(){
  return RequiredValidator(errorText: "Requirido");
}

