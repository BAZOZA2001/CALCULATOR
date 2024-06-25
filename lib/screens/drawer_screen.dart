import 'package:flutter/material.dart';
import 'package:calculator_app/user_model.dart';

class DrawerScreen extends StatelessWidget {
  final User? currentUser;

  DrawerScreen({this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildHeader(),
          if (currentUser != null) ...[
            _buildProfileTile(),
            Divider(),
          ],
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.calculate),
            title: Text('Calculator'),
            onTap: () {
              Navigator.pop(context);
              // Add navigation to calculator screen here if needed
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Add navigation to settings screen here
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              Navigator.pop(context);
              // Add navigation to about screen here
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Text(
        currentUser != null ? 'Welcome, ${currentUser!.username}!' : 'Navigation Drawer',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget _buildProfileTile() {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(currentUser!.username),
      subtitle: Text('Logged In'),
      onTap: () {
        // Add navigation to profile screen here if needed
      },
    );
  }
}