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
    List<ProductsModel> productsList = appProvider.productsList;

    List<ProductsModel> productsListFilt = productsList
        .where((element) => element.categories!
            .map((e) => e!.id == appProvider.selectedIndex)
            .toList()
            .any((element) => element))
        .toList();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                  width: width,
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
                    width > 1000
                        ? const SizedBox()
                        : FutureBuilder(
                            future: futureOfReadAll,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return ListOfCategories(
                                  appProvider: appProvider,
                                  categoriesList: categoriesList,
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: Container(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child:
                                            const SizedBox())); //CircularProgressIndicator()));
                              }
                              return const Text('Error');
                            },
                          ),
                    FutureBuilder(
                      future: futureOfReadAll,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return width > 1000
                              ? LayoutDesktop(
                                  appProvider: appProvider,
                                  categoriesList: categoriesList,
                                  productsList: productsListFilt,
                                  width: width,
                                  height: height,
                                )
                              : Expanded(
                                  child: width > 600
                                      ? GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  childAspectRatio: 3 / 2.1,
                                                  crossAxisSpacing: 0.5,
                                                  mainAxisSpacing: 0.5,
                                                  crossAxisCount:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .width ~/
                                                              250)
                                                          .toInt()),
                                          itemCount: productsListFilt.length,
                                          itemBuilder: (context, index) {
                                            ProductsModel prod =
                                                productsListFilt[index];

                                            return ListOfProducts(
                                              appProvider: appProvider,
                                              prod: prod,
                                            );
                                          })
                                      : ListView.builder(
                                          itemCount: productsListFilt.length,
                                          itemBuilder: (context, index) {
                                            ProductsModel prod =
                                                productsListFilt[index];

                                            return ListOfProducts(
                                              appProvider: appProvider,
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

class ListOfCategories extends StatelessWidget {
  const ListOfCategories(
      {super.key, required this.categoriesList, required this.appProvider});

  final List<CategoriesModel> categoriesList;
  final AppProvider appProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: categoriesList.length,
            itemBuilder: (context, index) {
              CategoriesModel categ = categoriesList[index];
              return GestureDetector(
                onTap: () {
                  //Seleziona la categoria da visualizzare al click della stessa
                  appProvider.selectItem(categ.id);
                },
                child: Container(
                  key: UniqueKey(),
                  width: 120,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: appProvider.selectedIndex == categ.id
                        ? appProvider.isLightMode
                            ? Colors.blueGrey
                            : Colors.grey[100]
                        : appProvider.isLightMode
                            ? Colors.grey[100]
                            : Colors.blueGrey[600],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      '${categ.name} ',
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          color: appProvider.selectedIndex == categ.id
                              ? appProvider.isLightMode
                                  ? Colors.white
                                  : Colors.black
                              : null,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            }));
  }
}

class ListOfProducts extends StatelessWidget {
  const ListOfProducts(
      {super.key, required this.prod, required this.appProvider});

  final ProductsModel prod;
  final AppProvider appProvider;
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
                  errorBuilder: (context, error, stackTrace) =>
                      const Text('err image'),
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

class LayoutDesktop extends StatelessWidget {
  const LayoutDesktop(
      {super.key,
      required this.categoriesList,
      required this.productsList,
      required this.width,
      required this.height,
      required this.appProvider});
  final AppProvider appProvider;
  final List<CategoriesModel> categoriesList;
  final List<ProductsModel> productsList;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Colonna Categorie
        Expanded(
          flex: 1,
          child: SizedBox(
            height: height - 56,
            child: Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: appProvider.isLightMode
                      ? Colors.blueGrey[100]
                      : Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Titolo scritta "Categorie"
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'Categorie:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  //Lista Categorie
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: categoriesList.length,
                        itemBuilder: (context, index) {
                          CategoriesModel categ = categoriesList[index];
                          return GestureDetector(
                            onTap: () {
                              appProvider.selectItem(categ.id);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: appProvider.selectedIndex == categ.id
                                      ? appProvider.isLightMode
                                          ? Colors.blueGrey
                                          : Colors.grey[100]
                                      : appProvider.isLightMode
                                          ? Colors.grey[100]
                                          : Colors.blueGrey[600]),
                              child: Text(
                                categ.name,
                                style: TextStyle(
                                    color: appProvider.selectedIndex == categ.id
                                        ? appProvider.isLightMode
                                            ? Colors.white
                                            : Colors.black
                                        : null,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
        //Colonna Prodotti
        Expanded(
          flex: 3,
          child: SizedBox(
            height: height - 56,
            child: Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: appProvider.isLightMode
                      ? Colors.blueGrey[100]
                      : Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //TextField Ricerca
                  Center(
                    child: Container(
                        width: 400,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: const TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              label: Text('Ricerca Prodotto'),
                              suffixIcon: Icon(Icons.search)),
                        )),
                  ),
                  //Titolo scritta "Prodotti"
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'Categoria Selez. :',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2 / 2.3,
                            crossAxisSpacing: 0.5,
                            mainAxisSpacing: 0.5,
                            crossAxisCount:
                                (MediaQuery.of(context).size.width ~/ 250)
                                    .toInt()),
                        itemCount: productsList.length,
                        itemBuilder: (context, index) {
                          ProductsModel prod = productsList[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: appProvider.isLightMode
                                      ? Colors.grey[100]
                                      : Colors.blueGrey[600]),
                              child: Column(
                                children: [
                                  //Immagine del Prodotto
                                  Hero(
                                    tag: prod.id.toString(),
                                    child: Image.network(
                                      '${prod.images!.first!.src}',
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    prod.name.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
