import 'package:dhanvarsha/navigatorservice/navigatorservice.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

typedef OnPermissionGivenCallback = Function(Position position);

class DhanvarshaGeoLocator {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static void determinePosition(
      OnPermissionGivenCallback onPermissionGiven) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    print("INTO THE PERMISSION");
    print(permission);
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      print("PERMISSION IS");

      print(permission);
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        SuccessfulResponse.showScaffoldMessage(
            "Please allow location permission to proceed further.",
            NavigationService.navigationService.navigatorKey.currentContext!);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      SuccessfulResponse.showScaffoldMessage(
          "Please allow location permission",
          NavigationService.navigationService.navigatorKey.currentContext!);
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      onPermissionGiven(position);
    }
  }
}
