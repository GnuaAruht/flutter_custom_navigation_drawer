import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  final VoidCallback onOpenNav;
  const MainScreen({Key? key, required this.onOpenNav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: onOpenNav, icon: const Icon(Icons.menu)),
        title: const Text('Custom Navigation Drawer'),
      ),
      body: const Center(
        child: Text('Main Screen'),
      ),
    );
  }
}
