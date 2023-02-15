import 'package:flutter/material.dart';
import 'package:magazzino/controllers/app_provider.dart';
import 'package:magazzino/screens/home_page.dart';
import 'package:magazzino/screens/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AppProvider())],
      builder: (context, child) {
        final appProvider = Provider.of<AppProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              useMaterial3: true,
              primarySwatch: Colors.blue,
              brightness: appProvider.isLightMode == true
                  ? Brightness.light
                  : Brightness.dark),
          home: appProvider.isLoggedIn == true
              ? const HomePage()
              : const LoginPage(),
        );
      },
    );
  }
}
