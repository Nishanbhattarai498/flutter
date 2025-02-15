import 'package:flutter/material.dart';

class Planet {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final Map<String, dynamic> stats;
  bool isFavorite;

  Planet({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.stats,
    this.isFavorite = false,
  });
}

class PlanetProvider with ChangeNotifier {
  final List<Planet> _planets = [
    Planet(
      id: '1',
      name: 'Mercury',
      description: 'The smallest planet in our solar system.',
      imageUrl: 'https://images.unsplash.com/photo-1614732414444-096e5f1122d5',
      stats: {
        'Mass': '3.285 × 10²³ kg',
        'Radius': '2,439.7 km',
        'Gravity': '3.7 m/s²',
      },
    ),
    Planet(
      id: '2',
      name: 'Venus',
      description: 'The hottest planet in our solar system.',
      imageUrl: 'https://images.unsplash.com/photo-1614313913007-2b4ae8ce32d6',
      stats: {
        'Mass': '4.867 × 10²⁴ kg',
        'Radius': '6,051.8 km',
        'Gravity': '8.87 m/s²',
      },
    ),
    Planet(
      id: '3',
      name: 'Earth',
      description: 'Our home planet.',
      imageUrl: 'https://images.unsplash.com/photo-1614730321146-b6fa6a46bcb4',
      stats: {
        'Mass': '5.972 × 10²⁴ kg',
        'Radius': '6,371 km',
        'Gravity': '9.807 m/s²',
      },
    ),
    // Add more planets...
  ];

  List<Planet> get planets => _planets;
  List<Planet> get favoritePlanets =>
      _planets.where((p) => p.isFavorite).toList();

  void toggleFavorite(String planetId) {
    final planetIndex = _planets.indexWhere((p) => p.id == planetId);
    if (planetIndex != -1) {
      _planets[planetIndex].isFavorite = !_planets[planetIndex].isFavorite;
      notifyListeners();
    }
  }
}
