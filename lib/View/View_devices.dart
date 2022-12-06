import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';



class ReadHoursWB extends StatelessWidget {
  const ReadHoursWB({super.key});
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
 bool stremdata=false;
  
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

  List<ButtonTheme> _buildReadWriteNotifyButton(
      BluetoothCharacteristic characteristic) {
    List<ButtonTheme> button =  List<ButtonTheme>.empty(growable: true);
   
    if (characteristic.properties.read) {
      button.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton(
           
              child: Text('READ', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                var sub = characteristic.value.listen((value) {
                  setState(() {
                    widget.readValues[characteristic.uuid] = value;
                  });
                });
                await characteristic.read();
                sub.cancel();
                 var data = characteristic.lastValue;
              
              },
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
                      _buildListViewOfDevices()
                 ],
               ),
                Row  (
                  
                  children: <Widget>  [
                 
                    discoverServices(characteristic) ,
                  ],
                ),
                Row(
                  children: <Widget>[
                    // ignore: prefer_interpolation_to_compose_strings
                    Text('Value: ' +
                       widget.readValues[characteristic.uuid].toString()),
                  ],
                ),
                const Divider(),
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
stremdata=true;
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }



discoverServices(characteristic) async {
  List<BluetoothService> services;
  BluetoothService ?myImportantService;
  List<BluetoothCharacteristic> ?characteristics;
  BluetoothCharacteristic ?myImportantCharacteristic;
  List<Container> containers =  List<Container>.empty(growable: true);
 
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






   _buildView() {
    if (_connectedDevice != null) {
     
      return _buildConnectDeviceView();
      
       
       }
     
    
    return _buildListViewOfDevices();
  }


@override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _buildView(),
      );
      
}



