import 'dart:async';
import 'package:flutter/material.dart';
import 'package:magazzino/controllers/app_provider.dart';
import 'package:magazzino/widgets/ricerca_prodotto.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Page02 extends StatefulWidget {
  const Page02({super.key});

  @override
  State<Page02> createState() => _Page02State();
}

class _Page02State extends State<Page02> {
  Future? futureOfReadAll;
  Timer? myTimerReadAll;
  SharedPreferences? pref;

  @override
  void initState() {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    myTimerReadAll = Timer.periodic(const Duration(seconds: 5), (timer) {
      appProvider.readAll(appProvider.token);
    });
    futureOfReadAll = appProvider.readAll(appProvider.token);
    super.initState();
  }

  @override
  void dispose() {
    myTimerReadAll!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    //List<CategoriesModel> categoriesList = appProvider.categoriesList;
    //List<CategoriesModel> categoriesListSelected =
    //    appProvider.categoriesListSelected;
    //List<ProductsModel> productsList = appProvider.productsList;

    //List<ProductsModel> productsListFilt = productsList
    //    .where((element) => element.categories!
    //        .map((e) => e!.id == appProvider.selectedIndex)
    //        .toList()
    //        .any((element) => element))
    //    .toList();

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('iCom'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: appProvider.isSearching
                  ? IconButton(
                      onPressed: () {
                        appProvider.isSearchMode(false);
                      },
                      icon: const Icon(Icons.close))
                  : IconButton(
                      onPressed: () {
                        appProvider.isSearchMode(true);
                      },
                      icon: const Icon(Icons.search)),
            )
          ],
          backgroundColor: Colors.transparent,
        ),
        appProvider.isSearching
            ? const RicercaProdotto()
            : SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [],
                ),
              )
      ],
    );
  }
}
