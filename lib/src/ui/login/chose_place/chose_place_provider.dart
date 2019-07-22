import 'package:flutter/material.dart';

class ChosePlaceNotifier with ChangeNotifier {
  ChosePlaceNotifier();

  List<Place> _places = initialPlaces;
  List<Place> get places {
    return _places;
  }

  void onClick(Place place) {
    place.isSelected = !place.isSelected;
    notifyListeners();
  }

  void onAllClick() {
    places.map((Place place) => place.isSelected = true).toList();
    notifyListeners();
  }

  bool onCheckPlaces() {
    return places.where((Place place) => place.isSelected == true).isNotEmpty;
  }
}

class Place {
  Place({@required this.title, @required this.imageUrl});

  String title;
  String imageUrl;
  int id;

  bool isSelected = false;
}

final List<Place> initialPlaces = [
  Place(
      title: 'The Doe in the Forest',
      imageUrl:
          'https://about.canva.com/wp-content/uploads/sites/3/2015/01/children_bookcover.png'),
  Place(
      title: 'Norse Mythology',
      imageUrl:
          'https://pro2-bar-s3-cdn-cf3.myportfolio.com/560d16623f9c2df9615744dfab551b3d/e50c016f-b6a8-4666-8fb8-fe6bd5fd9fec_rw_1920.jpeg?h=dc627898fc5eac88aa791fb2b124ecbd'),
];
