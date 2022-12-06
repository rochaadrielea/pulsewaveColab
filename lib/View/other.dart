import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'View_devices.dart';



class pleaseWork extends StatelessWidget {
  const pleaseWork({super.key});
  @override
 @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'BLE Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlueHomePage(title: 'ANOTHER TEST Flutter BLE '),
      );
}

class BlueHomePage extends StatefulWidget {
   BlueHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList =  List<BluetoothDevice>.empty(growable: true);
  final Map<Guid, List<int>> readValues =  <Guid, List<int>>{};

 
  @override
  _BlueHomePageState createState() => _BlueHomePageState();
}

class _BlueHomePageState extends State<BlueHomePage> {
  final _writeController = TextEditingController();
 BluetoothDevice? _connectedDevice;
  late List<BluetoothService> _services;
 

  ListView _buildListViewOfDevices() {
   List<Container> containers =  List<Container>.empty(growable: true);
    for (BluetoothDevice device in widget.devicesList) {
      containers.add(
        Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.name == '' ? '(unknown device)' : device.name),
                    Text(device.id.toString()),
                  ],
                ),
              ),
              ElevatedButton(
             
                child: const Text(
                  'Connect',
                  style:  TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  widget.flutterBlue.stopScan();
                  try {
                    await device.connect();
                  } catch (e) {
                    if (e.toString() != 'already_connected') {
                      throw e;
                    }
                  } finally {
                    _services = await device.discoverServices();
                  }
                  setState(() {
                    _connectedDevice = device;
                  });
                },
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  

  @override
  
  Widget build(BuildContext context) => Scaffold(
  
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _buildListViewOfDevices(),
      );

}

class grr extends StatefulWidget {
  const grr({super.key});
discoverServices(_services) async {
  List<BluetoothService> services;
  BluetoothService ?myImportantService;
  List<BluetoothCharacteristic> ?characteristics;
  BluetoothCharacteristic ?myImportantCharacteristic;
  List<Container> containers =  List<Container>.empty(growable: true);
 const ReadHoursWB();
  //Get your services from your device.
  services = _services;
 
  //Find the service we are looking for.
  for(BluetoothService s in services) {
    //Would recommend to convert all to lowercase if comparing.
    if(s.uuid.toString().toLowerCase() == ' 0000fee0-0000-1000-8000-00805f9b34fb')
      myImportantService = s;
       characteristics = myImportantService?.characteristics;
  }

  //Get this services characteristics.
 

  //Find the characteristic we are looking for.
  for(BluetoothCharacteristic c in characteristics!) {
    //Would recommend to convert all to lowercase if comparing.
    if(c.uuid.toString().toLowerCase() == '00002a2b-0000-1000-8000-00805f9b34fb')
      myImportantCharacteristic = c;
  }

  List<int> data = await myImportantCharacteristic!.read();
    print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
  print(data);
}




  @override
  State<grr> createState() => _grrState();
}

class _grrState extends State<grr> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}