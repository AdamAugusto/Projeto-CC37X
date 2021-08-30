import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_projeto/modelos/place.dart';
import 'package:flutter_projeto/modelos/place_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = FlutterConfig.get('ANDROID_MAPS_APIKEY');

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=address&language=pt_BR&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['predictions'] as List;
    return jsonResult.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  Future<Place> getPlace(String placeId) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&language=pt-BR&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);
  }
}
