
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:phone_store_app/view/screens/Login/log_out.dart';
import '../screens/orders_screen.dart';
import '../screens/products_overview_screen.dart';
import '../shared/custom_bottomAppBar.dart';

class SharedBottomAppBar extends StatefulWidget {
  const SharedBottomAppBar({super.key});

  @override
  _SharedBottomAppBarState createState() => _SharedBottomAppBarState();
}

class _SharedBottomAppBarState extends State<SharedBottomAppBar> {
  Widget _lastSelected = const ProductsOverviewScreen();
  List<Widget> pages = [
   const LogOut(),
    OrdersScreen(),
    const ProductsOverviewScreen(),
  ];
  List<String> titles = [ 'Users','My Orders',  'Home'];

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _lastSelected,
      bottomNavigationBar: CustomBottomAppBar(
        color: Colors.grey,
        selectedColor: Theme.of(context).accentColor,
        notchedShape: const CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          BottomAppBarItem(iconData: Icons.person, text: 'Users'),
          BottomAppBarItem(iconData: Icons.card_travel, text: 'My Orders'),
          BottomAppBarItem(iconData: Icons.home, text: 'Home'),
        ],
      ),
    );
  }
}
