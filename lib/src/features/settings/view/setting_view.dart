import 'package:flutter/material.dart';

import 'basic/about_tile.dart';
import 'basic/theme_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const String name = 'settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true, elevation: 0.0),
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(6.0), child: BasicPart()),
      ),
    );
  }
}

class BasicPart extends StatelessWidget {
  const BasicPart({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(child: Column(children: [ThemeTile(), AboutTile()]));
  }
}
