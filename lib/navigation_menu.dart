import 'package:flutter/material.dart';

class NavigationMenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  NavigationMenuItem(
      {required this.title, required this.icon, required this.onTap});
}

class NavigationMenu extends StatelessWidget {
  final List<NavigationMenuItem> items;
  final VoidCallback onClose;
  const NavigationMenu({Key? key, required this.items, required this.onClose})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          onTap: onClose,
          leading: const Icon(Icons.close),
          title: const Text('Close menu'),
        ),
        const SizedBox(
          height: 20,
        ),
        const ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('images/profile.jpeg'),
            ),
            title: Text('Tom Harris'),
            subtitle: Text('tomharris@gmail.com')),
        ...items
            .map((item) => ListTile(
                  leading: Icon(item.icon),
                  title: Text(item.title),
                  onTap: item.onTap,
                ))
            .toList()
      ],
    );
  }
}
