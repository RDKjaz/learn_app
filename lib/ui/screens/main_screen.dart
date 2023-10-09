import 'package:app_learn/factories/screen_factory.dart';
import 'package:app_learn/navigation/main_navigation.dart';
import 'package:app_learn/services/auth_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTab = 0;
  final _screenFactory = ScreenFactory();

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              AuthService().logout();
              MainNavigation.resetNavigation(context);
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          _screenFactory.makeLectureList(),
          _screenFactory.makeTestList()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Лекции'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_task_rounded), label: 'Тесты'),
        ],
        onTap: onSelectTab,
      ),
    );
  }
}
