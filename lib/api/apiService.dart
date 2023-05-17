import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_favorite_places_app/api/apiConstants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _googleMapsApiKey = dotenv.env['GOOGLE_MAPS_API'];

  Future<String> getAddress(double lat, double lng) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}json?latlng=$lat,$lng&key=$_googleMapsApiKey',
      );
      final response = await http.get(url);
      final resData = json.decode(response.body);
      final String address = resData['results'][0]['formatted_address'];
      return address;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> getLocationImage(double lat, double lng) async {
    try {
      final locationImage =
          '${ApiConstants.mapsStaticUrl}?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=$_googleMapsApiKey';

      return locationImage;
    } catch (e) {
      throw Exception(e);
    }
  }
}
