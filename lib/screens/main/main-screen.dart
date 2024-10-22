import 'package:app/handlers/gravatarHandler.dart';
import 'package:app/providers/mainProvider.dart';
import 'package:app/screens/bookmarks/bookmarks-screen.dart';
import 'package:app/screens/main/widgets/mainAppBar.dart';
import 'package:app/screens/main/widgets/mainDrawer.dart';
import 'package:app/screens/profile/login-screen.dart';
import 'package:app/screens/profile/profile-screen.dart';
import 'package:flutter/material.dart';

// import Screens
import 'package:app/screens/search/search-screen.dart';

class MainScreen extends StatefulWidget {
  final int initialPage;
  final int intialIndex;

  const MainScreen({
    Key key,
    this.initialPage = 0,
    this.intialIndex = 0
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<GlobalKey> _pageKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  PageController _pageController;
  int _page;
  int _index;

  @override
  void initState() {
    super.initState();
    _page = widget.initialPage ?? 0;
    _index = widget.intialIndex ?? 0;
    _pageController = PageController(initialPage: _page);
    
  }

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  @override
  void reassemble() {
    super.reassemble();
    _onPageChanged(_page);
  }

  void _onPageChanged(int page) {
    setState(() => {
      _page = page,
      _index = page
    });
  }

  void _onBottomNavItemPressed(int index) {
    setState(() => _page = index);
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
    );
  }

  _buildAvatar(MainState mainState) {
    if (mainState.getLoggedIn == true) {
      return CircleAvatar(radius: 15.0, backgroundImage: NetworkImage(getGravatar(mainState.getEmail)));
    } else {
      return Icon(Icons.person);
    }
  }

  @override
  Widget build(BuildContext context) {
    MainState mainState = MainState();

    return Scaffold(
      drawer: MainDrawer(),
      appBar: MainAppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          SearchScreen(key: _pageKeys[0]),
          BookmarksScreen(key: _pageKeys[1]),
          //ProfileScreen(key: _pageKeys[2]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.search, color: Colors.red),
            icon: Icon(Icons.search),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.bookmark, color: Colors.red,),
            icon: Icon(Icons.bookmark_border),
            title: SizedBox.shrink(),
          ),
          // BottomNavigationBarItem(
          //   activeIcon: !mainState.getLoggedIn ? Icon(Icons.person, color: Colors.red,) : null,
          //   icon: _buildAvatar(mainState),
          //   title: SizedBox.shrink(),
          // ),
        ],
        currentIndex: _index,
        selectedItemColor: Colors.black,
        onTap: _onBottomNavItemPressed,
      ),
    );
  }
}
