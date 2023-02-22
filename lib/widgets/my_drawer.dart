import 'package:flutter/material.dart';
import 'package:magazzino/controllers/app_provider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Drawer(
      child: Column(
        children: [
          AppBar(
            leading: const SizedBox(),
            backgroundColor: Colors.transparent,
            actions: [
              //Switch Theme Light and Dark
              IconButton(
                  onPressed: () {
                    appProvider.setLightOrDarkMode();
                    Navigator.pop(context);
                  },
                  icon: appProvider.isLightMode == true
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.light_mode)),
            ],
          ),
          const Text('Hola')
        ],
      ),
    );
  }
}
