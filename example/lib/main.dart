import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sirioperationrobert/sirioperationrobert.dart';
import 'package:flutter/services.dart';
import 'package:sirioperationrobert/sirioperationrobert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _classString = '';
  String _instanceString = '';

  @override
  void initState() {
    super.initState();

    initPlatformState();
    initAll();
  }
  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Sirioperationrobert.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> initAll() async {
    List platformVersion = await Sirioperationrobert.GetAllVoiceResult;
      print('捷径个数___${platformVersion}');

  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children:<Widget> [
            FlatButton(onPressed: (){


              Sirioperationrobert.getAssemblyinitWithModel({"deviceSN":'1',"orderType":'1',"orderName":'执行开始清扫命令'},'0').then((value) =>
              {

                print('测试flutter__${value}')
              });

            }, child: Text('添加快捷指令')),
            FlatButton(onPressed: (){


              initAll();

            }, child: Text('获取所有快捷指令')),
          ],
        ),
      ),
    );
  }
}
