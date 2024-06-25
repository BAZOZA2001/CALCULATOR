import 'package:flutter/material.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';
import 'calculator_screen.dart';
import 'drawer_screen.dart';
import 'package:calculator_app/user_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  User? _currentUser;
  List<User> _users = [];

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      SignInScreen(onSignIn: _handleSignIn, users: _users),
      SignUpScreen(onSignUp: _handleSignUp),
      _buildCalculatorScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Demo'),
        actions: [
          if (_currentUser != null)
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: _handleSignOut,
            ),
        ],
      ),
      drawer: DrawerScreen(currentUser: _currentUser),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _handleTabTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Sign In',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Sign Up',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  void _handleTabTap(int index) {
    if (index == 2 && _currentUser == null) {
      _showLoginRequiredDialog();
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _showLoginRequiredDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Required'),
          content: Text('You need to create an account and log in to use the calculator.'),
          actions: <Widget>[
            TextButton(
              child: Text('Sign Up'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _currentIndex = 1; // Switch to Sign Up tab
                });
              },
            ),
            TextButton(
              child: Text('Sign In'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _currentIndex = 0; // Switch to Sign In tab
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCalculatorScreen() {
    if (_currentUser != null) {
      return CalculatorScreen();
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Please sign in to use the calculator'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => setState(() => _currentIndex = 0),
              child: Text('Go to Sign In'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => setState(() => _currentIndex = 1),
              child: Text('Create an Account'),
            ),
          ],
        ),
      );
    }
  }

  void _handleSignIn(User user) {
    setState(() {
      _currentUser = user;
      _currentIndex = 2; // Switch to calculator tab
    });
  }

  void _handleSignUp(User newUser) {
    setState(() {
      _users.add(newUser);
      _currentIndex = 0; // Switch to sign-in tab after signup
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Account created successfully. Please sign in.')),
    );
  }

  void _handleSignOut() {
    setState(() {
      _currentUser = null;
      _currentIndex = 0; // Switch back to sign-in tab
    });
  }
}