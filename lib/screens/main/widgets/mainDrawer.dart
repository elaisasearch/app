import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey
            ),
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/logo.png'), 
                  width: 50
                ),
                Text('Menu')
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Language Tests')
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help')
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.code),
            title: Text('See Code')
          ),
          ListTile(
            leading: Icon(Icons.bug_report),
            title: Text('Report Bug')
          )
        ],
      ),
    );
  }
}