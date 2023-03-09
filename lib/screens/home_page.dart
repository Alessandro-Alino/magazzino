import 'package:flutter/material.dart';
import 'package:magazzino/controllers/app_provider.dart';
import 'package:magazzino/screens/layout_desktop.dart';
import 'package:magazzino/screens/page01.dart';
import 'package:magazzino/screens/page02.dart';
import 'package:magazzino/screens/page03.dart';
import 'package:magazzino/widgets/my_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    double width = MediaQuery.of(context).size.width;
    List<Widget> page = [const Page01(), const Page02(), const Page03()];

    return WillPopScope(
      onWillPop: () async {
        //Messaggio di conferma prima di eseguire Logout
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Eseguire il Logout?'),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No')),
                      ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                          ),
                          onPressed: () {
                            appProvider.userLogin(false);
                            Navigator.pop(context);
                          },
                          child: const Text('Si'))
                    ],
                  )
                ],
              );
            });
        return false;
      },
      child: Scaffold(
        drawer: const MyDrawer(),
        body: width > 950
            ? const LayoutDesktop()
            : IndexedStack(
                index: appProvider.selectedBottomTab,
                children: page,
              ),
        extendBody: true,
        bottomNavigationBar: appProvider.isSearching
            ? null
            : Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  color:
                      appProvider.isLightMode ? Colors.white : Colors.blue[800],
                  boxShadow: [
                    BoxShadow(
                      color: appProvider.isLightMode
                          ? Colors.black26
                          : Colors.grey.shade800,
                      spreadRadius: 0.5,
                      blurRadius: 8,
                      offset:
                          const Offset(1.0, 1.0), // changes position of shadow
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    currentIndex: appProvider.selectedBottomTab,
                    onTap: appProvider.onItemTapped,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: 'Home 1'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: 'Home 2'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: 'Home 3'),
                    ]),
              ),
      ),
    );
  }
}
