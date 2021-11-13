import 'package:flutter/material.dart';

import 'main_screen.dart';
import 'navigation_menu.dart';

void main() {
  runApp(const CustomNavigationDrawerApp());
}

class CustomNavigationDrawerApp extends StatelessWidget {
  const CustomNavigationDrawerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CustomNavigationDrawer(),
    );
  }
}

class CustomNavigationDrawer extends StatefulWidget {
  const CustomNavigationDrawer({Key? key}) : super(key: key);

  @override
  State<CustomNavigationDrawer> createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500));

  late final Animation<double> _drawerAnimation =
      Tween<double>(begin: 0.0, end: 0.1).animate(CurvedAnimation(
          parent: _animationController, curve: const Interval(0.0, 0.5)));

  late final Animation<double> _menuAnimation = CurvedAnimation(
      parent: _animationController, curve: const Interval(0.5, 1.0));

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _closeNavDrawer() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    }
  }

  void _toggleNavDrawer() {
    _animationController.isCompleted
        ? _animationController.reverse()
        : _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_animationController.isCompleted) {
          _animationController.reverse();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Stack(
              children: [
                Container(
                  color: Colors.lightBlueAccent,
                ),
                AnimatedPositioned(
                  top: 80 * (1 - _menuAnimation.value),
                  left: 0.0,
                  right: 0.0,
                  duration: const Duration(milliseconds: 0),
                  child: Opacity(
                    opacity: _menuAnimation.value,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0, left: 6.0),
                      child: NavigationMenu(
                        onClose: _toggleNavDrawer,
                        items: [
                          NavigationMenuItem(
                              title: 'Home', icon: Icons.home, onTap: () {}),
                          NavigationMenuItem(
                              title: 'Account',
                              icon: Icons.person,
                              onTap: () {}),
                          NavigationMenuItem(
                              title: 'Settings',
                              icon: Icons.settings,
                              onTap: () {}),
                          NavigationMenuItem(
                              title: 'Log out',
                              icon: Icons.logout,
                              onTap: () {}),
                        ],
                      ),
                    ),
                  ),
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(0, 3, 300 * _animationController.value)
                    ..setEntry(3, 3, 1 / (1 - _drawerAnimation.value)),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(20 * _animationController.value),
                    child: MainScreen(
                      onOpenNav: _toggleNavDrawer,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
