
import 'dart:async';

import 'package:flutter/services.dart';

class Sirioperationrobert {
  static const MethodChannel _channel =
      const MethodChannel('customersirioperationrobert');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<List> get GetAllVoiceResult async {
    final List instanceString = await _channel.invokeMethod('getAssemblyGetAllVoiceResult');
    return instanceString;
  }

  static Future <Map>getAssemblyinitWithModel (Map<String,dynamic> model,String type) async {

    final Map result = await _channel.invokeMethod('getAssemblyinitWithModel',[model,type]);

    return  result;
  }
}
