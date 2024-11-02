import 'package:geolocator/geolocator.dart';

class RouteTracker {
  List<Position> routePoints = []; // Stores the route points
  Position? destination; // The target destination
  double alertRadius; // Radius in meters to trigger an alert
  Function onOutOfBounds; // Callback when deviation occurs

  RouteTracker({
    required this.destination,
    required this.alertRadius,
    required this.onOutOfBounds,
  });

  // Start tracking the route
  void startRouteTracking() {
    // Define location settings
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      routePoints.add(position); // Record each point

      // Check if user is outside the alert radius
      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        destination!.latitude,
        destination!.longitude,
      );

      if (distance > alertRadius) {
        onOutOfBounds();
      }
    });
  }

  // Stop tracking and clear points
  void stopRouteTracking() {
    routePoints.clear();
  }
}
