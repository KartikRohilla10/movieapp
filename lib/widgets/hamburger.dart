import 'package:flutter/material.dart';

class HamburgerMenu extends StatelessWidget {
  final List<String> favoriteMovies;
  final VoidCallback onTapFavorites; // Define the onTapFavorites parameter

  const HamburgerMenu({
    Key? key,
    required this.favoriteMovies,
    required this.onTapFavorites, // Add the onTapFavorites parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Hey User !',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          for (var movie in favoriteMovies)
            ListTile(
              title: Text(movie),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
          ListTile(
            // Add a ListTile for the Favorites button
            leading: Icon(Icons.login), // Add icon for Login/Sign Up
            title: const Text('Login/Sign Up'),
            onTap: onTapFavorites, // Call onTapFavorites when tapped
          ),
          ListTile(
            // Add a ListTile for the My Profile button
            leading: Icon(Icons.person), // Add icon for My Profile
            title: Text('My Profile'),
            onTap: onTapFavorites, // Call onTapFavorites when tapped
          ),
          ListTile(
            // Add a ListTile for the Favorites button
            leading: Icon(Icons.favorite), // Add icon for Favorites
            title: Text('Favorites'),
            onTap: onTapFavorites, // Call onTapFavorites when tapped
          ),
          ListTile(
            // Add a ListTile for the Settings button
            leading: Icon(Icons.settings), // Add icon for Settings
            title: Text('Settings'),
            onTap: onTapFavorites, // Call onTapFavorites when tapped
          ),
          ListTile(
            // Add a ListTile for the About Us button
            leading: Icon(Icons.info), // Add icon for About Us
            title: Text('About Us'),
            onTap: onTapFavorites, // Call onTapFavorites when tapped
          ),
          ListTile(
            // Add a ListTile for the Help button
            leading: Icon(Icons.help), // Add icon for Help
            title: Text('Help'),
            onTap: onTapFavorites, // Call onTapFavorites when tapped
          ),
        ],
      ),
    );
  }
}
