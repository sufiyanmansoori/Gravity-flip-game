import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  DeviceInfoService._();

  static final DeviceInfoPlugin _plugin = DeviceInfoPlugin();

  static Future<DeviceInfoSnapshot> get info async {
    if (Platform.isAndroid) {
      final android = await _plugin.androidInfo;
      return DeviceInfoSnapshot(
        platform: 'android',
        brand: android.brand,
        model: android.model,
        version: android.version.release,
        sdkInt: android.version.sdkInt,
      );
    }

    if (Platform.isIOS) {
      final ios = await _plugin.iosInfo;
      return DeviceInfoSnapshot(
        platform: 'ios',
        brand: 'Apple',
        model: ios.model,
        version: ios.systemVersion,
      );
    }

    if (Platform.isWindows) {
      return const DeviceInfoSnapshot(
        platform: 'windows',
        brand: 'Microsoft',
        model: 'Windows',
        version: 'unknown',
      );
    }

    return const DeviceInfoSnapshot(
      platform: 'unknown',
      brand: 'unknown',
      model: 'unknown',
      version: 'unknown',
    );
  }
}

class DeviceInfoSnapshot {
  const DeviceInfoSnapshot({
    required this.platform,
    required this.brand,
    required this.model,
    required this.version,
    this.sdkInt,
  });

  final String platform;
  final String brand;
  final String model;
  final String version;
  final int? sdkInt;

  @override
  String toString() => '$platform/$brand/$model/$version';
}
