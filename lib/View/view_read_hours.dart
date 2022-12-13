   
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'dart:convert' show utf8;

import 'View_devices.dart';
import '../firebase_options.dart';


class ReadHours extends StatelessWidget {
  const ReadHours({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'BLE Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlueHomePage(title: 'Connection with your WB'),
      );

      
       
}

class BlueHomePage extends StatefulWidget {
  BlueHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList =  List<BluetoothDevice>.empty(growable: true);
  final Map<Guid, List<int>> readValues =  Map<Guid, List<int>>();

  @override
  // ignore: library_private_types_in_public_api
  _BlueHomePageState createState() => _BlueHomePageState();
}

class _BlueHomePageState extends State<BlueHomePage> {
  final _writeController = TextEditingController();
   BluetoothDevice? _connectedDevice;
   late List<BluetoothService> _services;
   
     get padding => null;

  
  _addDeviceTolist(final BluetoothDevice device) {
    if (!widget.devicesList.contains(device)) {
      setState(() {
        widget.devicesList.add(device);



      });
    }
  }

  @override
  void initState() {
      
    super.initState();
    widget.flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    widget.flutterBlue.startScan();
  }

 String dataParser(List<int> dataFromDevice) {
    return utf8.decode(dataFromDevice);
  }






  



  List<ButtonTheme> _buildReadWriteNotifyButton(
      BluetoothCharacteristic characteristic) {
    List<ButtonTheme> button =  List<ButtonTheme>.empty(growable: true);

bool _isDisabled = false;
    if (characteristic.properties.read) {
      button.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton (
              
              
              onPressed: () async {
             // Navigator.of(context).pushNamedAndRemoveUntil('/Register/', (route) => true);
          

            },
child: const Text('READ', style: TextStyle(color: Colors.white)),

            ),
          ),
        ),
      );
    }
   
   

    return button;
  }

  ListView _buildConnectDeviceView() {
    List<Container> containers =  List<Container>.empty(growable: true);

    for (BluetoothService service in _services) {
      List<Widget> characteristicsWidget =  List<Widget>.empty(growable: true);

      for (BluetoothCharacteristic characteristic in service.characteristics) {
        characteristicsWidget.add(
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(characteristic.uuid.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    ..._buildReadWriteNotifyButton(characteristic),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('Value: ${widget.readValues[characteristic.uuid]}'),
                  ],
                ),
               const  Divider(),
              ],
            ),
          ),
        );
      }
      
      containers.add(
        Container(
          child: ExpansionTile(
              title: Text(service.uuid.toString()),
              children: characteristicsWidget),
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

  ListView _buildView() {
    
      return _buildConnectDeviceView();
    
   
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        const  Text("Please press the button bellow to connect with your device",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
             const SizedBox(height: 40),
         TextButton(
                        onPressed: (() {
                          /*Navigator.of(context).pushNamedAndRemoveUntil(
              '/Register/',
               (_) => false,);*/ 
              // Navigator.push(context, MaterialPageRoute(
  // builder: (context) => const ViewDevices())
                        
 
                                
                         
    }
     
                          
                        ), 
                      
                      child: const Text('Finding Devices',style: TextStyle(fontSize: 20.0, ),))
        
        
      ]
    )
        //  _buildView(),
          
      );

       Widget readhours(BuildContext context) => Scaffold(
       body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot)  => const Text('WRITE'),
      )
      
      );
}





