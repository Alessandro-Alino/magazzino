import 'dart:async';
import 'package:flutter/material.dart';
import 'package:magazzino/controllers/app_provider.dart';
import 'package:magazzino/models/WooCommerceModels/categories_models.dart';
import 'package:magazzino/models/WooCommerceModels/products_model.dart';
import 'package:magazzino/screens/products_list_page.dart';
import 'package:magazzino/widgets/ricerca_prodotto.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Page01 extends StatefulWidget {
  const Page01({super.key});

  @override
  State<Page01> createState() => _Page01State();
}

class _Page01State extends State<Page01> {
  Future? futureOfReadAll;
  Timer? myTimerReadAll;
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

    List<ProductsModel> productsList = appProvider.productsList;
    List<CategoriesModel> categoriesList = appProvider.categoriesList;
    List<CategoriesModel> categoriesParentList =
        categoriesList.where((element) => element.parent == 0).toList();
    List<CategoriesModel> categoriesPrefList = categoriesList
        .where((element) =>
            element.name == 'iPhone' ||
            element.name == 'iPhone Ricondizionati' ||
            element.name == 'Samsung' ||
            element.name == 'Xiaomi')
        .toList();

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
                        appProvider.productsListSearched.clear();
                        appProvider.ricercaController.clear();
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
                  children: [
                    //Titolo Categorie Principali
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Categorie Principali',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Divider()
                        ],
                      ),
                    ),
                    //Future per Categorie Principali con ShimmerEffect
                    FutureBuilder(
                        future: futureOfReadAll,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return GridView.builder(
                                padding: const EdgeInsets.all(0.0),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 3 / 2),
                                itemCount: categoriesPrefList.length,
                                itemBuilder: (context, index) {
                                  CategoriesModel categPref =
                                      categoriesPrefList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      appProvider.selectItem(categPref.id);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductsListPage(
                                                    productsList: productsList,
                                                  )));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(16.0),
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Center(
                                          child: Text(
                                        '${categPref.name} ',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  );
                                });
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return GridView.builder(
                                padding: const EdgeInsets.all(0.0),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 3 / 2),
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Shimmer(
                                      gradient: LinearGradient(colors: [
                                        Colors.grey,
                                        Colors.grey.shade100
                                      ]),
                                      child: Container(
                                        height: 50,
                                        margin: const EdgeInsets.all(16.0),
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                      ));
                                });
                          }
                          return const Text('Error');
                        }),
                    //Titolo per lista tutte Categorie
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Tutte le Categorie',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Divider()
                        ],
                      ),
                    ),
                    //Tutte le categorie con ShimmerEffect
                    FutureBuilder(
                        future: futureOfReadAll,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: categoriesParentList.length,
                                itemBuilder: (context, index) {
                                  CategoriesModel categParent =
                                      categoriesParentList[index];
                                  List<CategoriesModel> categoriesChildList =
                                      categoriesList
                                          .where((element) =>
                                              element.parent == categParent.id)
                                          .toList();
                                  return Container(
                                    margin: const EdgeInsets.all(16.0),
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: appProvider.isLightMode
                                              ? Colors.grey.shade200
                                              : Colors.blueGrey.shade900,
                                          spreadRadius: 0.5,
                                          blurRadius: 1,
                                          offset: const Offset(0.5, 0.5),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${categParent.name} ',
                                          style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 80,
                                          child: ListView.builder(
                                              itemCount:
                                                  categoriesChildList.length,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                CategoriesModel categChild =
                                                    categoriesChildList[index];
                                                return GestureDetector(
                                                  onTap: () {
                                                    appProvider.selectItem(
                                                        categChild.id);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProductsListPage(
                                                                  productsList:
                                                                      productsList,
                                                                )));
                                                  },
                                                  child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 16.0,
                                                              top: 16.0),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      decoration: BoxDecoration(
                                                          color: Colors.blueGrey
                                                              .shade700,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0)),
                                                      child: Center(
                                                        child: Text(
                                                            '${categChild.name} ',
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                      )),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Shimmer(
                                      gradient: LinearGradient(colors: [
                                        Colors.grey,
                                        Colors.grey.shade100
                                      ]),
                                      child: Container(
                                        height: 100,
                                        margin: const EdgeInsets.all(16.0),
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                      ));
                                });
                          }
                          return const SliverToBoxAdapter(child: Text('Error'));
                        }),
                  ],
                ),
              )
      ],
    );
  }
}
