import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easyhome/src/menu_screens/account.dart';
import 'package:easyhome/src/menu_screens/annonce.dart';
import 'package:easyhome/src/menu_screens/favoris.dart';
import 'package:easyhome/src/menu_screens/home.dart';
import 'package:easyhome/src/menu_screens/navbar_key.dart';
import 'package:easyhome/src/menu_screens/notification.dart';
import 'package:easyhome/src/menu_screens/options.dart';
import 'package:easyhome/src/menu_screens/details_house_screens/produit_item_widget.dart';

//import 'package:easyhome/main.dart';
//Je deplace le conteneue Initiale de ce Fichier Main pour le mettre dans un
//bloc note

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 2;
  final screen = [
    const FavoriScreen(),
    const ProduitItem(),
    HomeScreen(),
    //const OptionsScreen(),
    const AccountScreen(),
    const NotificationsScreen(),
    //const AnnonceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromRGBO(255, 152, 0, 1),
        //buttonBackgroundColor: Colors.orange[400],
        index: selectedIndex,
        key: Navbarkey.getKey(),
        items: <Widget>[
          _buildIcon(Icons.favorite, selectedIndex == 0),
          _buildIcon(Icons.notifications_active_rounded, selectedIndex == 1),
          _buildIcon(Icons.home, selectedIndex == 2),
          _buildIcon(Icons.account_circle_rounded, selectedIndex == 3),
          _buildIcon(Icons.menu, selectedIndex == 4),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        animationCurve: Curves.easeInBack,
        animationDuration: const Duration(milliseconds: 300),
      ),
      body: screen[selectedIndex],
    );
  }

  Widget _buildIcon(IconData icon, bool isSelected) {
    return Icon(
      icon,
      size: 30,
      color: isSelected ? Colors.orange : Colors.grey,
    );
  }
}
