import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ScanResultTile extends StatelessWidget {
  const ScanResultTile({Key? key, required this.result, this.onTap})
      : super(key: key);

  final ScanResult result;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: result.device.name.isEmpty
          ? Text(result.device.id.toString())
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  result.device.name,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  result.device.id.toString(),
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
      leading: Text(result.rssi.toString()),
      trailing: ElevatedButton(
        onPressed: (result.advertisementData.connectable) ? onTap : null,
        child: const Text('CONNECT'),
      ),
      children: <Widget>[
        _ScanResultData(
          title: 'Complete Local Name',
          value: result.advertisementData.localName,
        ),
        _ScanResultData(
          title: 'Tx Power Level',
          value: '${result.advertisementData.txPowerLevel ?? 'N/A'}',
        ),
        _ScanResultData(
          title: 'Manufacturer Data',
          value: getNiceManufacturerData(
            result.advertisementData.manufacturerData,
          ),
        ),
        _ScanResultData(
          title: 'Service UUIDs',
          value: (result.advertisementData.serviceUuids.isNotEmpty)
              ? result.advertisementData.serviceUuids.join(', ').toUpperCase()
              : 'N/A',
        ),
        _ScanResultData(
          title: 'Service Data',
          value: getNiceServiceData(result.advertisementData.serviceData),
        ),
      ],
    );
  }
}

class _ScanResultData extends StatelessWidget {
  final String title;
  final String value;

  const _ScanResultData({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.caption),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.apply(color: Colors.black),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}

String getNiceHexArray(List<int> bytes) {
  return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]'
      .toUpperCase();
}

String getNiceManufacturerData(Map<int, List<int>> data) {
  if (data.isEmpty) {
    return 'N/A';
  }
  List<String> res = [];
  data.forEach((id, bytes) {
    res.add('${id.toRadixString(16).toUpperCase()}: ${getNiceHexArray(bytes)}');
  });
  return res.join(', ');
}

String getNiceServiceData(Map<String, List<int>> data) {
  if (data.isEmpty) {
    return 'N/A';
  }
  List<String> res = [];
  data.forEach((id, bytes) {
    res.add('${id.toUpperCase()}: ${getNiceHexArray(bytes)}');
  });
  return res.join(', ');
}
