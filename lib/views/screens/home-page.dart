import 'package:flutter/material.dart';
import 'package:hotel_booking_app/views/screens/add_page.dart';
import 'package:hotel_booking_app/views/screens/components/Helpers/db_helepers.dart';
import 'package:hotel_booking_app/views/screens/search_page.dart';

import 'add_spending_components.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController pageController;

  List<Widget> pagelist = [
    const AddPage(),
    const AddSpendingComponents(),
    const SearchPage(),
  ];

  int selectedIndex = 0;

  void initState() {
    Db_Helper.db_helper.initDB();
    pageController = PageController(initialPage: selectedIndex, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (val) {
          setState(() {
            selectedIndex = val;
            pageController.animateToPage(selectedIndex,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInBack);
          });
        },
        selectedIndex: selectedIndex,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.add),
            label: 'Add Category',
          ),
          NavigationDestination(
            icon: Icon(Icons.money),
            label: 'Spending Category',
          ),
          NavigationDestination(
              icon: Icon(Icons.search), label: 'Search Category'),
        ],
      ),
      body: PageView(
        children: pagelist,
        onPageChanged: (val) {
          setState(() {
            selectedIndex = val;
          });
        },
      ),
    );
  }
}
