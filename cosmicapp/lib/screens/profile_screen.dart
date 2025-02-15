import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cosmicapp/providers/auth_provider.dart';
import 'package:cosmicapp/widgets/cosmic_button.dart';
import 'package:cosmicapp/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1451187580459-43490279c0fa'),
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
                      'My Profile',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            NetworkImage(authProvider.profileImage ?? ''),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        authProvider.username ?? 'User',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        authProvider.email ?? 'email@example.com',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 32),
                      _buildProfileItem(context, 'Edit Profile', Icons.edit,
                          () {
                        // TODO: Implement edit profile functionality
                      }),
                      _buildProfileItem(context, 'Settings', Icons.settings,
                          () {
                        // TODO: Implement settings functionality
                      }),
                      _buildProfileItem(context, 'Help & Support', Icons.help,
                          () {
                        // TODO: Implement help & support functionality
                      }),
                      const SizedBox(height: 32),
                      CosmicButton(
                        onPressed: () async {
                          await authProvider.logout();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false,
                          );
                        },
                        child: const Text('Log Out'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
