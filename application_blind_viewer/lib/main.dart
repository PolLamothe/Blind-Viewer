// @dart=3
import 'dart:collection';

import 'package:application_blind_viewer/variable.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:typed_data';

void main() {
  runApp(MyApp());
}

String getRandomChar() {
  int random = Random().nextInt(caractere.length);
  return caractere[random];
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MainApp(),
        'LearnPage': (context) => LearnPage(),
        'TestPage': (context) => TestPage()
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TestPage()),
                );
              },
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
  String randomChar = getRandomChar();

  void playSound(String letter) async {
    AudioPlayer player = AudioPlayer();
    if (hashMap.containsKey(letter)) {
      letter = hashMap[letter].toString();
    }
    String audioasset = "assets/${letter}.ogg";
    ByteData bytes = await rootBundle.load(audioasset); //load sound from assets
    Uint8List soundbytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    int result = await player.playBytes(soundbytes);
  }

  @override
  void initState() {
    super.initState();
    playSound(randomChar.toUpperCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              randomChar,
              style: TextStyle(fontSize: 30),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    randomChar = getRandomChar();
                    playSound(randomChar.toUpperCase());
                  });
                },
                child: Text('Appuyez pour changer la lettre'))
          ],
        )
      ]),
    );
  }
}

// ignore: must_be_immutable
class TestPage extends StatefulWidget {
  TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  void Scan() async {
    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 4));

// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.id} found! rssi: ${r.rssi}');
      }
    });

// Stop scanning
    flutterBlue.stopScan();
  }

  @override
  void initState() {
    super.initState();
    playSound();
  }

  void playSound() async {
    AudioPlayer player = AudioPlayer();
    String audioasset = "assets/A.ogg";
    ByteData bytes = await rootBundle.load(audioasset); //load sound from assets
    Uint8List soundbytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    int result = await player.playBytes(soundbytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [ElevatedButton(onPressed: Scan, child: Text('Chercher'))]),
    );
  }
}
