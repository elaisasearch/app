import 'package:flutter/material.dart';

// import Screens
import 'package:app/screens/home/home.dart';

class AppBottomBar extends StatefulWidget {
  AppBottomBar({Key key}) : super(key: key);

  @override
  _AppBottomBarState createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text(
      'Bookmarks',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onMenuIconTapped() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        // transparent background and no shadow for app bar
        backgroundColor: Colors.white,
        elevation: 0.0,

        leading: IconButton(icon: Icon(Icons.menu), onPressed: _onMenuIconTapped),
        actions: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 48.0,
            child: ClipOval(
              // replace with Image.network(image-url) later
              child: Image.asset(
                'assets/images/alex.jpg',
              )
            )
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Bookmarks'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}