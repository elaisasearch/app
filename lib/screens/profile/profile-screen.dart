import 'package:app/models/userModel.dart';
import 'package:app/providers/mainProvider.dart';
import 'package:app/screens/profile/login-screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({key: Key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

User user;

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    MainState mainState = MainState();

    try {
      if (user.email != '') {
      mainState.signInUser(user.email, user.firstname, user.lastname);
      }
    } catch (e) {};

    if (mainState.getLoggedIn) {
      return Scaffold(
        body: Text('logged in'),
      );
    } else {
      return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              user = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            label: Text('Login'),
            icon: Icon(
              Icons.vpn_key,
            ),
            backgroundColor: Colors.red,
          ));
    }
  }
}
