import 'package:flutter/material.dart';

import 'login_page.dart';
import 'buttons_page.dart';
import 'text_fields_page.dart';
import 'gestures_demo_page.dart';
import 'images_demo_page.dart';
import 'local_json_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<String> _menuItems = const [
    'Login View',
    'Buttons',
    'Text Fields',
    'Gesture',
    'Images',
    'Local JSON'
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Flutter'),
        backgroundColor: colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _menuItems.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(
                _menuItems[index],
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              onTap: () {
                if (index == 0) {
                  // Navigate to Login View
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else if (index == 1) {
                  // Navigate to Buttons Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ButtonsPage()),
                  );
                } else if (index == 2) {
                  // Navigate to Text Fields Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TextFieldsPage()),
                  );
                } else if (index == 3) {
                  // Navigate to Gestures Demo Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GesturesDemoPage()),
                  );
                } else if (index == 4) {
                  // Navigate to Images Demo Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ImagesDemoPage()),
                  );
                } else if (index == 5) {
                  // Navigate to Local JSON Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LocalJsonPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${_menuItems[index]} tapped'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
