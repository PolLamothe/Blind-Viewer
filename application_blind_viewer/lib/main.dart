import 'package:application_blind_viewer/variable.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(MyApp());
  BluetoothDevice device;

  BluetoothState state;

  BluetoothDeviceState deviceState;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MainApp(),
        'LearnPage': (context) => LearnPage()
      },
    );
  }
}

class MainApp extends StatefulWidget {
  MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    FlutterBlue.instance.state.listen((state) {
      if (state == BluetoothState.off) {
      } else if (state == BluetoothState.on) {
        scanForDevices();
      }
    });
  }

  void scanForDevices() async {
    var scanSubscription = bluetoothInstance.scan().listen((scanResult) async {
      if (scanResult.device.name == "your_device_name") {
        print("found device");
//Assigning bluetooth device
        var device = scanResult.device;
//After that we stop the scanning for device
        stopScanning();
      }
    });
  }

  void stopScanning() {
    bluetoothInstance.stopScan();
    scanSubscription.cancel();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LearnPage()),
                );
              },
              // ignore: prefer_const_constructors
              style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(Colors.red)),
              child: const Text('Apprendre'),
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            // ignore: prefer_const_constructors
            child: ElevatedButton(
              onPressed: null,
              // ignore: prefer_const_constructors
              style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(Colors.blue)),
              child: const Text('Tester ses connaissances'),
            ),
          )
        ],
      ),
    ));
  }
}

class LearnPage extends StatefulWidget {
  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  String getRandomChar() {
    int random = Random().nextInt(caractere.length);
    return caractere[random];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              getRandomChar(),
              style: TextStyle(fontSize: 30),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text('Appuyez pour changer la lettre'))
          ],
        )
      ]),
    );
  }
}
