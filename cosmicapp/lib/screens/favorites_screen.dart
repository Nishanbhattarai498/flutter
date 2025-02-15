import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cosmicapp/providers/planet_provider.dart';
import 'package:cosmicapp/widgets/planet_card.dart';
import 'package:cosmicapp/screens/planet_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1419242902214-272b3f66ee7a'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Favorites',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Consumer<PlanetProvider>(
                  builder: (context, provider, child) {
                    final favoritePlanets = provider.favoritePlanets;
                    if (favoritePlanets.isEmpty) {
                      return Center(
                        child: Text(
                          'No favorite planets yet',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      );
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: favoritePlanets.length,
                      itemBuilder: (context, index) {
                        final planet = favoritePlanets[index];
                        return PlanetCard(
                          planet: planet,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PlanetDetailScreen(planet: planet),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
