import '../kgk.dart';
import 'package:geolocator/geolocator.dart' as geoloc;

class LocationService with WidgetsBindingObserver {
  static final LocationService _instance = LocationService._internal();

  factory LocationService() {
    return _instance;
  }

  LocationService._internal();

  /// Method 1: Request Location Permission
  Future<bool> _checkAndRequestPermission() async {
    geoloc.LocationPermission permission = await geoloc.Geolocator.checkPermission();

    // If denied, attempt to request permission
    if (permission == geoloc.LocationPermission.denied) {
      permission = await geoloc.Geolocator.requestPermission();
    }

    // Return true if permission is always or while in use
    return permission == geoloc.LocationPermission.always || permission == geoloc.LocationPermission.whileInUse;
  }

  /// Method 2: Fetch User's Current Location
  Future<geoloc.Position?> getCurrentLocation(BuildContext context) async {
    try {
      // Check location services are enabled
      if (!await geoloc.Geolocator.isLocationServiceEnabled()) {
        await Utils.showPermissionDeniedDialog(
          context: context,
          onOkPressed: (context) async {
            await context.pop();
            geoloc.Geolocator.openAppSettings();
          },
          onCancelPressed: (context) async {
            await context.pop();
          },
        );
        return null;
      }

      // Request and check permissions
      if (!await _checkAndRequestPermission()) {
        await Utils.showPermissionDeniedDialog(
          context: context,
          onOkPressed: (context) async {
            await context.pop();
            geoloc.Geolocator.openAppSettings();
          },
          onCancelPressed: (context) async {
            await context.pop();
          },
        );
        return null;
      }

      // Fetch current position with high accuracy
      return await geoloc.Geolocator.getCurrentPosition(
        locationSettings: const geoloc.LocationSettings(accuracy: geoloc.LocationAccuracy.high),
      );
    } catch (e) {
      debugPrint("Error fetching location: $e");
      await Utils.showPermissionDeniedDialog(
        context: context,
        onOkPressed: (context) async {
          await context.pop();
          geoloc.Geolocator.openAppSettings();
        },
        onCancelPressed: (context) async {
          await context.pop();
        },
      );
      return null;
    }
  }
}
