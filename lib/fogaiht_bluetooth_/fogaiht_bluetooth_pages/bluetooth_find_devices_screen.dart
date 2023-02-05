import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'bluetooth_device_screen.dart';
import 'components/scan_result_tile.dart';

class FindDevicesScreen extends StatefulWidget {
  const FindDevicesScreen({super.key});

  @override
  State<FindDevicesScreen> createState() => _FindDevicesScreenState();
}

class _FindDevicesScreenState extends State<FindDevicesScreen> {
  static int secondsToSearch = 25;

  @override
  void initState() {
    FlutterBlue.instance
        .startScan(timeout: Duration(seconds: secondsToSearch))
        .then((_) {
      print('FOGAIHT: FINISH SCAN');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Devices'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<List<BluetoothDevice>>(
              stream: Stream.periodic(const Duration(seconds: 2))
                  .asyncMap((_) => FlutterBlue.instance.connectedDevices),
              initialData: const [],
              builder: (c, snapshot) => Column(
                children: snapshot.data!
                    .map((d) => ListTile(
                          title: Text(d.name),
                          subtitle: Text(d.id.toString()),
                          trailing: StreamBuilder<BluetoothDeviceState>(
                            stream: d.state,
                            initialData: BluetoothDeviceState.disconnected,
                            builder: (c, snapshot) => snapshot.data !=
                                    BluetoothDeviceState.connected
                                ? Text(snapshot.data.toString())
                                : ElevatedButton(
                                    child: const Text('OPEN'),
                                    onPressed: () {
                                       Navigator.of(context).pushNamedAndRemoveUntil('/Register/', (route) => false);
                                      /*Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => DeviceScreen(
                                            device: d,
                                          ),
                                        ),
                                      );*/
                                    },
                                  ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            StreamBuilder<List<ScanResult>>(
              stream: FlutterBlue.instance.scanResults,
              initialData: const [],
              builder: (c, snapshot) => Column(
                children: snapshot.data!.map(
                  (r) {
                    return r.advertisementData.localName.isNotEmpty
                        ? ScanResultTile(
                            result: r,
                            onTap: () => Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              r.device.connect();
                              return DeviceScreen(device: r.device);
                            })),
                          )
                        : const SizedBox();
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: StreamBuilder<bool>(
      //   stream: FlutterBlue.instance.isScanning,
      //   initialData: false,
      //   builder: (c, snapshot) {
      //     if (snapshot.data!) {
      //       return FloatingActionButton(
      //         onPressed: () {},
      //         // onPressed: () => FlutterBlue.instance.stopScan(),
      //         backgroundColor: Colors.red,
      //         child: const Icon(Icons.stop),
      //       );
      //     } else {
      //       return FloatingActionButton(
      //         onPressed: () {},
      //         child: const Icon(Icons.search),
      //         // onPressed: () => FlutterBlue.instance.startScan(
      //         //   timeout: const Duration(seconds: 10),
      //         // ),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
