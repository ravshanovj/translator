import 'package:flutter/material.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';
import 'package:translate_app/view/home_page.dart';
import 'package:translate_app/view/style/style.dart';
import 'favourites_page.dart';
import 'history_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;

  List<IndexedStackChild> listOfPage = [
     IndexedStackChild(child: const FavouritePage()),
     IndexedStackChild(child: const HomePage(),preload: true),
     IndexedStackChild(child: const HistoryPage()),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ProsteIndexedStack(
        index: _selectedIndex,
        children: listOfPage,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MoltenBottomNavigationBar(
        selectedIndex: _selectedIndex,
        domeHeight: 25,
        barColor: Theme.of(context).primaryColor,
        domeCircleColor: Style.primaryColor,
        onTabChange: (clickedIndex) {
          setState(() => _selectedIndex = clickedIndex);
        },
        tabs: [
          MoltenTab(
            icon: const Icon(Icons.star_border),
          ),
          MoltenTab(
            icon: const Icon(Icons.home),
          ),
          MoltenTab(
            icon: const Icon(Icons.history),
          ),
        ],
      ),
    );
  }
}
