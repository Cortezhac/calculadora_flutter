import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.red),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color btnPrincipal = const Color.fromRGBO(255, 255, 255, 0.2);
  Color btnSecundario = const Color.fromRGBO(255, 255, 255, 0.2);
  Color txtColorBtn = Colors.white;
  Color txtColorBtn2 = Colors.blue;
  String _txtDatos = '0';
  String _txtRespuesta = '0';

  // funcion que agrega los botones
  Widget agregarBoton(String texto, Color colorFondo, Color txtColor) {
    return Container(
      color: colorFondo,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 3),
      child: OutlinedButton(
        onPressed: () => {addData(texto)},
        child: Text(
          texto.toString(),
          style: TextStyle(color: txtColor, fontSize: 40),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'calculadora',
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // numeros
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0, right: 10, bottom: 0, left: 10),
                        child: Text(
                          _txtDatos.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 80),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, right: 10, bottom: 10, left: 10),
                child: Text(
                  '0',
                  style: const TextStyle(color: Colors.grey, fontSize: 40),
                ),
              )
            ],
          ),
          // Botones
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              agregarBoton('7', btnPrincipal, txtColorBtn),
              agregarBoton('8', btnPrincipal, txtColorBtn),
              agregarBoton('9', btnPrincipal, txtColorBtn),
              Container(
                color: btnPrincipal,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(bottom: 3),
                child: OutlinedButton(
                  onPressed: () => {addOperador('+')},
                  child: Text(
                    '+',
                    style: TextStyle(color: txtColorBtn2, fontSize: 40),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              agregarBoton('4', btnPrincipal, txtColorBtn),
              agregarBoton('5', btnPrincipal, txtColorBtn),
              agregarBoton('6', btnPrincipal, txtColorBtn),
              Container(
                color: btnPrincipal,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(bottom: 3),
                child: OutlinedButton(
                  onPressed: () => {addOperador('-')},
                  child: Text(
                    '-',
                    style: TextStyle(color: txtColorBtn2, fontSize: 40),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              agregarBoton('1', btnPrincipal, txtColorBtn),
              agregarBoton('2', btnPrincipal, txtColorBtn),
              agregarBoton('3', btnPrincipal, txtColorBtn),
              Container(
                color: btnPrincipal,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(bottom: 3),
                child: OutlinedButton(
                  onPressed: () => {addOperador('/')},
                  child: Text(
                    '/',
                    style: TextStyle(color: txtColorBtn2, fontSize: 40),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              agregarBoton('0', btnPrincipal, txtColorBtn),
              Container(
                color: btnPrincipal,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(bottom: 3),
                child: OutlinedButton(
                  onPressed: () => {clear()},
                  child: const Text(
                    'C',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
              ),
              Container(
                color: Colors.blueAccent,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(bottom: 3),
                child: OutlinedButton(
                  onPressed: () => {},
                  child: Text(
                    '=',
                    style: TextStyle(color: txtColorBtn, fontSize: 40),
                  ),
                ),
              ),
              Container(
                color: btnPrincipal,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(bottom: 3),
                child: OutlinedButton(
                  onPressed: () => {addOperador('x')},
                  child: Text(
                    'x',
                    style: TextStyle(color: txtColorBtn2, fontSize: 40),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // logica
  double valor1 = 0;
  double valor2 = 0;
  double salida = 0;
  String operador = '';

  void addData(String dato) {
    if (_txtDatos == '0') {
      setState(() {
        _txtDatos = '';
      });
    }

    setState(() {
      _txtDatos += dato;
    });
  }

  void addOperador(String ope) {
    if (operador == '') {
      //valor1 = _txtDatos as double;
      operador = ope;
      setState(() {
        _txtDatos += ope;
      });
    }
  }

  void operar() {
    if (operador != '') {
      valor2 = _txtDatos.substring(0, _txtDatos.indexOf(operador)) as double;
      switch (operador) {
        case '+':
          salida = valor1 + valor2;
          break;
      }

      setState(() {
        _txtRespuesta = salida.toString();
      });
    }
  }

  void clear() {
    valor1 = 0;
    valor2 = 0;
    operador = '';
    salida = 0;
    setState(() {
      _txtDatos = '0';
      _txtRespuesta = '0';
    });
  }
}
