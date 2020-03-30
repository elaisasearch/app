import 'package:app/screens/main/widgets/mainAppBar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          HomeScreen(key: _pageKeys[0]),
          HomeScreen(key: _pageKeys[1]),
          HomeScreen(key: _pageKeys[2]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            title: Text(''),
          ),
        ],
        currentIndex: _index,
        selectedItemColor: Colors.black,
        onTap: _onBottomNavItemPressed,
      ),
    );
  }
}
