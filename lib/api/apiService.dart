import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<String> getAddress(double lat, double lng) async {
    try {
      final googleMapsApiKey = dotenv.env['GOOGLE_MAPS_API'];

      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleMapsApiKey',
      );
      final response = await http.get(url);
      final resData = json.decode(response.body);
      final String address = resData['results'][0]['formatted_address'];
      return address;
    } catch (e) {
      throw Exception(e);
    }
  }
}
