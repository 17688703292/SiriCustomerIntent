import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sirioperationrobert/sirioperationrobert.dart';

void main() {
  const MethodChannel channel = MethodChannel('sirioperationrobert');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Sirioperationrobert.platformVersion, '42');
  });
}
