// Copyright 2017, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

import '../fogaiht_bluetooth_pages/bluetooth_find_devices_screen.dart';
import '../fogaiht_bluetooth_pages/bluetooth_off_screen.dart';

/*void main() {
  runApp(const FlutterBlueApp());
}*/

class FlutterBlueApp extends StatefulWidget {
  const FlutterBlueApp({super.key});

  @override
  State<FlutterBlueApp> createState() => _FlutterBlueAppState();
}

class _FlutterBlueAppState extends State<FlutterBlueApp> {
    late Timer _timer;
     final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (await Permission.bluetooth.request().isGranted) {
        // Either the permission was already granted before or the user just granted it.
        print('FOGAIHT: Sucesso!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.lightBlue,
      home: StreamBuilder<BluetoothState>(
        stream: FlutterBlue.instance.state,
        initialData: BluetoothState.unknown,
        builder: (c, snapshot) {
          final state = snapshot.data;
          return state == BluetoothState.on
              ? const FindDevicesScreen()
              : BluetoothOffScreen(state: state);
        },
      ),
    );
  }

   _readCharacteristicValid(BluetoothCharacteristic characteristic) {
    var sub = characteristic.value.listen((value) {
      //print('Time: $value');
      setState(() {
        readValues[characteristic.uuid] = value;
      });
    });
   const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) async {
      await characteristic.read();
      //sub.cancel();
      var data = characteristic.lastValue;
      print('TIME ON THE WB');
      var timew = [data[4], data[5], data[6]];

      print(timew);
       //startTimer(characteristic);
    });
  }
}


