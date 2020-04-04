import 'package:app/screens/main/widgets/ovalRightClipper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // method to open a url
    _launchUrl(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return ClipPath(
        clipper: OvalRightBorderClipper(),
        child: Drawer(
            child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Image(image: AssetImage('assets/images/logo.png'), width: 150),
              ),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ExpansionTile(
                    leading: Icon(
                      Icons.school,
                      color: Colors.grey[700],
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey[700],
                    ),
                    title: Text('Language Tests',
                        style: TextStyle(
                          color: Colors.grey[900],
                        )),
                    children: <Widget>[
                      ListTile(
                        leading: Text(
                          '🇩🇪',
                          style: TextStyle(fontSize: 20),
                        ),
                        title: Text(
                          'Deutsch',
                          style: TextStyle(fontSize: 15),
                        ),
                        onTap: () {
                          _launchUrl(
                              'https://sprachtest.de/einstufungstest-deutsch');
                        },
                      ),
                      ListTile(
                        leading: Text(
                          '🇬🇧',
                          style: TextStyle(fontSize: 20),
                        ),
                        title: Text(
                          'English',
                          style: TextStyle(fontSize: 15),
                        ),
                        onTap: () {
                          _launchUrl(
                              'https://sprachtest.de/einstufungstest-englisch');
                        },
                      ),
                      ListTile(
                        leading: Text(
                          '🇪🇸',
                          style: TextStyle(fontSize: 20),
                        ),
                        title: Text(
                          'Español',
                          style: TextStyle(fontSize: 15),
                        ),
                        onTap: () {
                          _launchUrl(
                              'https://sprachtest.de/einstufungstest-spanisch');
                        },
                      )
                    ],
                  ),
                ],
              )),
              Container(
                  child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                          child: Column(
                        children: <Widget>[
                          Divider(),
                          ListTile(
                              leading: Icon(Icons.help),
                              title: Text('Help'),
                              onTap: () => _launchUrl(
                                  'https://github.com/elaisasearch/elaisa.org/blob/master/README.md')),
                          Divider(),
                          ListTile(
                              leading: Icon(Icons.code),
                              title: Text('See Code'),
                              onTap: () => _launchUrl(
                                  'https://github.com/elaisasearch/app')),
                          ListTile(
                            leading: Icon(Icons.bug_report),
                            title: Text('Report Bug'),
                            onTap: () => _launchUrl(
                                'https://github.com/elaisasearch/app/issues'),
                          ),
                          Divider(thickness: 1),
                          Container(
                              padding: EdgeInsets.all(10),
                              height: 50,
                              child: Text('v1.0.0 - elaisa.org',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)))
                        ],
                      ))))
            ],
          ),
        )));
  }
}
