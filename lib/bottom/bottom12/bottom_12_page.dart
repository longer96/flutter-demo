import 'package:flutter/material.dart';
import 'package:project/widget/my_app_bar.dart';
import 'salomon_bottom_bar.dart';

class Bottom12Page extends StatefulWidget {
  @override
  _Bottom12PageState createState() => _Bottom12PageState();
}

class _Bottom12PageState extends State<Bottom12Page> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'salomon底部导航', elevation: 0),
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: Container(
        color: Colors.white,
        child: SafeArea(
          bottom: true,
          child: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
                selectedColor: Colors.purple,
              ),

              /// Likes
              SalomonBottomBarItem(
                icon: Icon(Icons.favorite_border),
                title: Text("Likes"),
                selectedColor: Colors.pink,
              ),

              /// Search
              SalomonBottomBarItem(
                icon: Icon(Icons.search),
                title: Text("Search"),
                selectedColor: Colors.orange,
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile"),
                selectedColor: Colors.teal,
              ),
            ],
          ),
        ),
      ),
      body: content(),
    );
  }

  Widget content() {
    return Container(
      alignment: Alignment.center,
      child: Text(_currentIndex.toString(),
          style: TextStyle(color: Colors.grey[400], fontSize: 80)),
    );
  }
}
