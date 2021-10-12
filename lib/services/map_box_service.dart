import 'dart:convert';
import 'package:http/http.dart' as http;

class MapBoxService {
  static String accessToken = "";

  Future<List<MapBoxPlace>> searchPlaces(String searchQuery,
      [int limit = 6]) async {
    List<MapBoxPlace> result = [];
    var response = await http.get(Uri.parse(
        "https://api.mapbox.com/geocoding/v5/mapbox.places/$searchQuery"
        ".json?access_token=$accessToken&autocomplete=true&country=de&types=place&limit=$limit"));

    try {
      var decodedJson = json.decode(response.body);
      var features = decodedJson["features"];
      if (features is List) {
        for (dynamic place in features) {
          var mapBoxPlace = MapBoxPlace.fromJson(place);
          result.add(mapBoxPlace);
        }
      }
    } catch (err) {
      print(err);
    }

    return result;
  }

  Future<MapBoxPlace?> lookup(double latitude, double longitude) async {
    var response = await http.get(Uri.parse(
        "https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude"
        ".json?access_token=$accessToken&types=region"));

    try {
      Map decodedJson = json.decode(response.body);
      List features = decodedJson["features"];

      if (features is List) {
        for (dynamic place in features) {
          return MapBoxPlace?.fromJson(place);
        }
      }
    } catch (err) {
      print(err);
    }

    return null;
  }
}

class MapBoxPlace {
  final String id;
  final String name;
  final double latitude;
  final double longitude;

  MapBoxPlace(this.id, this.name, this.latitude, this.longitude);

  MapBoxPlace.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['text'],
        latitude = double.parse(json['center'][1].toString()),
        longitude = double.parse(json['center'][0].toString());
}
