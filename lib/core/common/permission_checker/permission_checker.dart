import 'package:permission_handler/permission_handler.dart';

class PermissionChecker {
  // Checking for Runtime Camera Permissions
  static Future<void> checkCameraPermission() async {
    var status = await Permission.camera.request();
    if (status.isDenied || status.isRestricted) {
      await Permission.camera.request();
    }
  }

  // Checking for Runtime Location Permissions
  static Future<void> checkLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isDenied || status.isRestricted) {
      await Permission.location.request();
    }
  }
}
