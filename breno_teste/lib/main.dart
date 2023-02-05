import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Lendo e gravando arquivos',
      home: FlutterDemo(storage: LocalDataStorage()),
    ),
  );
}

class LocalDataStorage {
  //Metodo obter caminho do arquivo
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  //Metodo obter arquivo local
  Future<File> get _localFile async {
    final path = await _localPath;
    // print("o local do arquivo:" '$path');
    // print(File('$path/arquivo.txt'));
    return File('$path/arquivo.txt');
  }

  //Metodo de ler valor no arquivo
  Future<Object> readValue() async {
    try {
      final file = await _localFile;
      // Lendo o arquivo
      String dataString = await file.readAsString();
      return (dataString);
    } catch (e) {
      // Se encontrou erro retorna 0
      return 0;
    }
  }

  //Metodo de escrever valor no arquivo
  Future<File> writeValue(String value) async {
    final file = await _localFile;

    // Escrevendo no arquivo
    return file.writeAsString(value);
  }
}

class FlutterDemo extends StatefulWidget {
  const FlutterDemo({super.key, required this.storage});

  final LocalDataStorage storage;

  @override
  State<FlutterDemo> createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  int _counter = 0;
  String _value_bluetooth = "Data0:";

  @override
  void initState() {
    super.initState();
    widget.storage.readValue().then((value) {
      setState(() {
        _value_bluetooth = value as String;
      });
    });
  }

  Future<File> _getBluetooth() {
    setState(() {
      _value_bluetooth = '$_value_bluetooth dado:${_counter++}';
    });

    // Escreva a variável como uma string no arquivo.
    return widget.storage.writeValue(_value_bluetooth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lendo e gravando arquivos'),
      ),
      body: Center(
        child: Text(
          'Ultimos dados salvos : $_value_bluetooth ',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getBluetooth,
        tooltip: 'GetBluetooth',
        child: const Icon(Icons.bluetooth),
      ),
    );
  }
}
