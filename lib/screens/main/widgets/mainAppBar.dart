import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget{

  // needs to be overridden for Scaffold in main-screen.dart
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(

      // transparent background and no shadow for app bar
      backgroundColor: Colors.white,
      elevation: 0.0,

      // show menu icon to open the MainDrawer()
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () { Scaffold.of(context).openDrawer(); },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      actions: <Widget>[],
    );
  }
}
