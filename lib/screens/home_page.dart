import 'dart:async';

import 'package:flutter/material.dart';
import 'package:magazzino/controllers/app_provider.dart';
import 'package:magazzino/models/WooCommerceModels/categories_models.dart';
import 'package:magazzino/models/WooCommerceModels/products_model.dart';
import 'package:magazzino/screens/detail_page.dart';
import 'package:magazzino/widgets/my_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

    List<CategoriesModel> categoriesList = appProvider.categoriesList;
    List<ProductsModel> productssList = appProvider.productsList;
    double width = MediaQuery.of(context).size.width;
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
          appBar: AppBar(
            elevation: 1,
            title: const Text('iCom'),
            centerTitle: true,
            actions: const [],
          ),
          drawer: const MyDrawer(),
          body: appProvider.connessione == false
              ? Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text('Sembra non ci sia Connessione!'),
                )
              : Column(
                  children: [
                    //Token
                    //Padding(
                    //  padding: const EdgeInsets.all(16.0),
                    //  child: Text(appProvider.token),
                    //),
                    FutureBuilder(
                      future: futureOfReadAll,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListOfCategories(
                            categoriesList: categoriesList,
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: Container(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: const CircularProgressIndicator()));
                        }
                        return const Text('Error');
                      },
                    ),
                    FutureBuilder(
                      future: futureOfReadAll,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Expanded(
                            child: width > 600
                                ? GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: width >= 750
                                                ? 3 / 2.8
                                                : 3 / 2.2,
                                            crossAxisSpacing: 0.5,
                                            mainAxisSpacing: 0.5,
                                            crossAxisCount: width >= 1000
                                                ? 4
                                                : width >= 750
                                                    ? 3
                                                    : 2),
                                    itemCount: productssList.length,
                                    itemBuilder: (context, index) {
                                      ProductsModel prod = productssList[index];
                                      return GridOfProducts(
                                        prod: prod,
                                      );
                                    })
                                : ListView.builder(
                                    itemCount: productssList.length,
                                    itemBuilder: (context, index) {
                                      ProductsModel prod = productssList[index];
                                      return ListOfProducts(
                                        prod: prod,
                                      );
                                    },
                                  ),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: Container(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: const CircularProgressIndicator()));
                        }
                        return const Text('Error');
                      },
                    ),
                  ],
                )),
    );
  }
}

class ListOfCategories extends StatefulWidget {
  const ListOfCategories({super.key, required this.categoriesList});

  final List<CategoriesModel> categoriesList;

  @override
  State<ListOfCategories> createState() => _ListOfCategoriesState();
}

class _ListOfCategoriesState extends State<ListOfCategories> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: ReorderableListView.builder(
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) {
                  newIndex = newIndex - 1;
                }
              });
              final categ = widget.categoriesList.removeAt(oldIndex);
              widget.categoriesList.insert(newIndex, categ);
            },
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.categoriesList.length,
            itemBuilder: (context, index) {
              CategoriesModel categ = widget.categoriesList[index];
              return Container(
                key: UniqueKey(),
                width: 120,
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    '${categ.name} ',
                    overflow: TextOverflow.fade,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            }));
  }
}

class ListOfProducts extends StatelessWidget {
  const ListOfProducts({super.key, required this.prod});

  final ProductsModel prod;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailPage(product: prod)));
      },
      child: Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(10.0),
          ),
          //Titolo del prodotto e Categorie Prodotto
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Immagine del Prodotto
              Hero(
                tag: prod.id.toString(),
                child: Image.network(
                  '${prod.images!.first!.src}',
                  width: 120,
                  height: 120,
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Titolo del Prodotto
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        prod.name.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    //Categorie Prodotto
                    SizedBox(
                      height: 20,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: prod.categories!.length,
                        itemBuilder: (context, index) {
                          Categoryz? category = prod.categories![index];
                          return index == prod.categories!.length - 1
                              ? Text(
                                  category!.name.toString(),
                                  style: TextStyle(color: Colors.grey.shade400),
                                )
                              : Text(
                                  '${category!.name.toString()},  ',
                                  style: TextStyle(color: Colors.grey.shade400),
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class GridOfProducts extends StatelessWidget {
  const GridOfProducts({super.key, required this.prod});

  final ProductsModel prod;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Immagine del Prodotto
          Hero(
            tag: prod.id.toString(),
            child: Image.network(
              '${prod.images!.first!.src}',
              width: 100,
              height: 100,
            ),
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Titolo del Prodotto
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    prod.name.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                //Categorie Prodotto
                Flexible(
                  child: SizedBox(
                    height: 20,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: prod.categories!.length,
                      itemBuilder: (context, index) {
                        Categoryz? category = prod.categories![index];
                        return index == prod.categories!.length - 1
                            ? Text(
                                category!.name.toString(),
                                style: TextStyle(color: Colors.grey.shade400),
                              )
                            : Text(
                                '${category!.name.toString()},  ',
                                style: TextStyle(color: Colors.grey.shade400),
                              );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
