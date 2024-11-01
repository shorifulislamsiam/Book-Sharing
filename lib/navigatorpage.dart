
import 'package:bookshairing/favouritelist.dart';
import 'package:bookshairing/homepage.dart';
import 'package:bookshairing/profilepage.dart';
import 'package:bookshairing/settingslist.dart';
import 'package:flutter/material.dart';


class navigatorpage extends StatefulWidget {
  const navigatorpage({super.key});

  @override
  State<navigatorpage> createState() => _navigatorpageState();
}

class _navigatorpageState extends State<navigatorpage> {
  int _selectedIndex = 0;
  

  List widgetOption = [homepage(), profilepage(),favouritelist(),settingslist()];

  void _onItemTap(int Index) {
    setState(
      () {
        _selectedIndex = Index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOption.elementAt(_selectedIndex),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,color: Colors.red,),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settingslist',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey, 
      ),
    );
  }
}
