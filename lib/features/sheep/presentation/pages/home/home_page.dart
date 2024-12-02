import 'package:flutter/material.dart';
import '../appointments/appointments_page.dart';
import '../settings/settings_page.dart';
import '../sheep_list/sheep_list_page.dart';

enum HomePageArguments {
  dashboard(0),
  sheepList(1),
  appointments(2),
  settings(3);

  final int tabIndex;
  const HomePageArguments(this.tabIndex);
}

class HomePage extends StatefulWidget {
  static const pageRoute = '/';

  final int defaultIndex;

  HomePage(HomePageArguments? defaultTab, {super.key})
      : defaultIndex = defaultTab?.tabIndex ?? 0;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Container(color: Colors.blue),
    SheepListPage(),
    AppointmentsPage(),
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    if (0 <= widget.defaultIndex && widget.defaultIndex < _pages.length) {
      _currentIndex = widget.defaultIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1,
        type: BottomNavigationBarType.fixed,
        // backgroundColor: Theme.of(context).colorScheme.primary,
        // selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Recap',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            activeIcon: Icon(Icons.groups),
            label: 'Brebis',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'RDV',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Paramètres',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
