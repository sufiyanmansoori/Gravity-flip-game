import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionStatusResult {
  const PermissionStatusResult({
    required this.name,
    required this.isGranted,
    required this.isDenied,
    required this.isPermanentlyDenied,
    required this.isRestricted,
    required this.isLimited,
  });

  final String name;
  final bool isGranted;
  final bool isDenied;
  final bool isPermanentlyDenied;
  final bool isRestricted;
  final bool isLimited;

  @override
  String toString() => '$name: granted=$isGranted denied=$isDenied';
}

class PermissionsService {
  PermissionsService();

  Future<PermissionStatusResult> requestNotificationPermission() async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      return const PermissionStatusResult(
        name: 'notification',
        isGranted: true,
        isDenied: false,
        isPermanentlyDenied: false,
        isRestricted: false,
        isLimited: false,
      );
    }

    final status = await Permission.notification.status;
    final granted = status.isGranted;

    if (!granted) {
      final requested = await Permission.notification.request();
      return PermissionStatusResult(
        name: 'notification',
        isGranted: requested.isGranted,
        isDenied: requested.isDenied,
        isPermanentlyDenied: requested.isPermanentlyDenied,
        isRestricted: requested.isRestricted,
        isLimited: requested.isLimited,
      );
    }

    return PermissionStatusResult(
      name: 'notification',
      isGranted: status.isGranted,
      isDenied: status.isDenied,
      isPermanentlyDenied: status.isPermanentlyDenied,
      isRestricted: status.isRestricted,
      isLimited: status.isLimited,
    );
  }

  Future<PermissionStatusResult> requestCameraPermission() async {
    final status = await Permission.camera.status;
    final requested = status.isGranted
        ? status
        : await Permission.camera.request();

    return PermissionStatusResult(
      name: 'camera',
      isGranted: requested.isGranted,
      isDenied: requested.isDenied,
      isPermanentlyDenied: requested.isPermanentlyDenied,
      isRestricted: requested.isRestricted,
      isLimited: requested.isLimited,
    );
  }

  Future<PermissionStatusResult> requestStoragePermission() async {
    final status = await Permission.storage.status;
    final requested = status.isGranted
        ? status
        : await Permission.storage.request();

    return PermissionStatusResult(
      name: 'storage',
      isGranted: requested.isGranted,
      isDenied: requested.isDenied,
      isPermanentlyDenied: requested.isPermanentlyDenied,
      isRestricted: requested.isRestricted,
      isLimited: requested.isLimited,
    );
  }
}
