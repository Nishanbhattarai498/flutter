import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cosmicapp/providers/auth_provider.dart';
import 'package:cosmicapp/providers/planet_provider.dart';
import 'package:cosmicapp/screens/splash_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Update this import

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PlanetProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosmic Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF6C63FF),
        scaffoldBackgroundColor: const Color(0xFF0B0D1C),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6C63FF),
          secondary: Color(0xFF8A84FF),
          background: Color(0xFF0B0D1C),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Map<String, String>> planets = [
    {
      'name': 'Mercury',
      'image': 'assets/images/mercury.png',
      'description': 'The smallest planet in our solar system.'
    },
    {
      'name': 'Venus',
      'image': 'assets/images/venus.png',
      'description': 'The second planet from the sun.'
    },
    {
      'name': 'Earth',
      'image': 'assets/images/earth.png',
      'description': 'Our home planet.'
    },
    {
      'name': 'Mars',
      'image': 'assets/images/mars.png',
      'description': 'The red planet.'
    },
    {
      'name': 'Jupiter',
      'image': 'assets/images/jupiter.png',
      'description': 'The largest planet in our solar system.'
    },
    {
      'name': 'Saturn',
      'image': 'assets/images/saturn.png',
      'description': 'Known for its ring system.'
    },
    {
      'name': 'Uranus',
      'image': 'assets/images/uranus.png',
      'description': 'An ice giant with a unique tilt.'
    },
    {
      'name': 'Neptune',
      'image': 'assets/images/neptune.png',
      'description': 'The farthest planet from the sun.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ListView.builder(
        itemCount: planets.length,
        itemBuilder: (context, index) {
          final planet = planets[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Image.asset(
                  planet['image']!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        planet['name']!,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      SizedBox(height: 10),
                      Text(
                        planet['description']!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
