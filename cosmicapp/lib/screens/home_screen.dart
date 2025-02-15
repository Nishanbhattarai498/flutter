import 'package:flutter/material.dart';
import 'package:cosmicapp/widgets/planet_card.dart';
import 'package:cosmicapp/screens/planet_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF0B0D1C),
              Colors.indigo.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Solar System',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Planet of the day',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue.shade200,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    PlanetCard(
                      name: 'Mars',
                      description: 'The red planet',
                      imageUrl:
                          'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Screenshot%202025-02-15%20113953-n1KU3kwCRWwbiFga25fAryiTq2vFQY.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PlanetDetailScreen(
                              planetName: 'Mars',
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    PlanetCard(
                      name: 'Earth',
                      description: 'Our home planet',
                      imageUrl:
                          'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Screenshot%202025-02-15%20113953-n1KU3kwCRWwbiFga25fAryiTq2vFQY.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PlanetDetailScreen(
                              planetName: 'Earth',
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0B0D1C),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
