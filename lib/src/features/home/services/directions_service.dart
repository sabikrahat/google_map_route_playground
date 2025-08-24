import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DirectionsService {
  static const String baseUrl = 'https://maps.googleapis.com/maps/api/directions/json';

  static Future<List<LatLng>> getRoute(LatLng origin, LatLng destination) async {
    try {
      // Load environment variables if not already loaded
      if (!dotenv.isInitialized) {
        await dotenv.load();
      }
      
      final String apiKey = dotenv.env['GOOGLE_MAP_KEY'] ?? '';
      
      if (apiKey.isEmpty) {
        if (kDebugMode) {
          print('Google Maps API key not found in environment variables');
        }
        return _createSimpleRoute(origin, destination);
      }
      
      final String url = '$baseUrl?'
          'origin=${origin.latitude},${origin.longitude}&'
          'destination=${destination.latitude},${destination.longitude}&'
          'key=$apiKey';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['status'] == 'OK' && data['routes'].isNotEmpty) {
          final String encodedPolyline = data['routes'][0]['overview_polyline']['points'];
          return _decodePolyline(encodedPolyline);
        } else {
          // Fallback to simple straight line if API fails
          return _createSimpleRoute(origin, destination);
        }
      } else {
        // Fallback to simple route if API request fails
        return _createSimpleRoute(origin, destination);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching directions: $e');
      }
      // Return a curved route as fallback
      return _createSimpleRoute(origin, destination);
    }
  }

  // Creates a simple curved route between two points
  static List<LatLng> _createSimpleRoute(LatLng origin, LatLng destination) {
    final List<LatLng> points = [];
    
    // Add intermediate points to create a curved path
    const int numPoints = 20;
    
    for (int i = 0; i <= numPoints; i++) {
      final double ratio = i / numPoints;
      
      // Create a curved path by adding some offset
      final double lat = origin.latitude + (destination.latitude - origin.latitude) * ratio;
      final double lng = origin.longitude + (destination.longitude - origin.longitude) * ratio;
      
      // Add some curve by offsetting points slightly
      final double curve = 0.01 * (4 * ratio * (1 - ratio)); // Parabolic curve
      
      points.add(LatLng(lat + curve, lng - curve * 0.5));
    }
    
    return points;
  }

  // Decode polyline from Google Directions API
  static List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }
}