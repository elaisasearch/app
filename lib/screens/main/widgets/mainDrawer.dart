import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Column(

        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/logo.png'), 
                  width: 150
                ),
                Text(
                  'Menu',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.school),
                  title: Text('Language Tests')
                ),
              ],
            )
          ),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                child: Column(
                  children: <Widget>[
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
                    ),
                    Divider(thickness: 1),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 50,
                      child: Text(
                        'v1.0.0 - elaisa.org',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        )
                      )
                    )
                  ],
                )
              )
            )
          )
        ],
      ),
    );
  }
}