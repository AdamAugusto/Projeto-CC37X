import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_projeto/modelos/place.dart';
import 'package:flutter_projeto/modelos/place_search.dart';
import 'package:flutter_projeto/services/geoLocator_service.dart';
import 'package:flutter_projeto/services/places_service.dart';
import 'package:geolocator/geolocator.dart';

class ApplicationBloc extends ChangeNotifier {
  final geoLocatorService = GeoLocatorService();
  final placesService = PlacesService();
  StreamController<Place> selectedLocation =
      StreamController<Place>.broadcast();

  Position? currentLocation;
  List<PlaceSearch>? searchResults = [];

  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }

  setSelectedLocation(String placeId) async {
    selectedLocation.add(await placesService.getPlace(placeId));
    searchResults = null;
    notifyListeners();
  }

  @override
  void dispose() {
    selectedLocation.close();
    super.dispose();
  }
}
