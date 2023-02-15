import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:magazzino/controllers/app_provider.dart';
import 'package:magazzino/models/WooCommerceModels/product_variations_model.dart';
import 'package:magazzino/models/WooCommerceModels/products_model.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.product});

  final ProductsModel product;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future? futureOfReadProductVariations;
  Timer? myTimerReadProductVariations;
  @override
  void initState() {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    myTimerReadProductVariations =
        Timer.periodic(const Duration(seconds: 5), (timer) {
      appProvider.readAll(appProvider.token);
      appProvider.readProductVariations(appProvider.token, widget.product);
    });
    futureOfReadProductVariations =
        appProvider.readProductVariations(appProvider.token, widget.product);
    super.initState();
  }

  @override
  void dispose() {
    myTimerReadProductVariations!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    //Bool controllo prodotto Semplice o Variabile
    bool productIsVariable =
        describeEnum(widget.product.type.toString()) == 'simple' ? false : true;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //AppBar
          SliverAppBar(
            expandedHeight: 280.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.product.id.toString(),
                child: Image.network(
                  '${widget.product.images!.first!.src}',
                ),
              ),
              title: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
                child: Text(
                  '${widget.product.name}, ${widget.product.id}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            actions: const [],
          ),
          //SliverToBoxAdapter(
          //  child: Text(productIsVariable.toString()),
          //),
          productIsVariable
              ? FutureBuilder(
                  future: futureOfReadProductVariations,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const SliverToBoxAdapter(
                        child: SizedBox(
                          child: Center(
                            child: Text('Qualcosa non va'),
                          ),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    }
                    return SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: appProvider.productVariationsList
                                .length, (context, index) {
                      ProductVariationsModel productVariation =
                          appProvider.productVariationsList[index];
                      return ListOfProdVariation(
                        product: widget.product,
                        prodVar: productVariation,
                        appProvider: appProvider,
                      );
                    }));
                  })
              : SliverToBoxAdapter(
                  child: Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text('${widget.product.price} €')),
                )
        ],
      ),
    );
  }
}

class ListOfProdVariation extends StatelessWidget {
  const ListOfProdVariation(
      {super.key,
      required this.prodVar,
      required this.product,
      required this.appProvider});

  final ProductsModel product;
  final ProductVariationsModel prodVar;
  final AppProvider appProvider;

  @override
  Widget build(BuildContext context) {
    //Estrarre la lista delle sedi dai MetaData
    List listaSedi = prodVar.metaData!.map((e) {
      if (e!.key != null) {
        return describeEnum(e.key.toString()) == 'sedi' ? e.value : null;
      } else {
        return null;
      }
    }).toList();
    //Rimuove i valori dai meta_data non uguali a sedi -> uguali a null
    listaSedi.removeWhere((element) => element == null);

    return GestureDetector(
      onTap: () {
        if (listaSedi.isEmpty) {
          appProvider.mostraMessaggio(
              context,
              'Aggiungere prima le sedi a questo prodotto!',
              Colors.amber,
              Icons.error);
        } else {
          appProvider.reginaQntController.text =
              listaSedi[0][0]['quantita'].toString();
          appProvider.tagliaQntrdController.text =
              listaSedi[0][1]['quantita'].toString();
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              context: context,
              builder: (_) {
                return CustomModalBottom(
                  appProvider: appProvider,
                  prod: product,
                  prodVar: prodVar,
                );
              }).then((value) {
            appProvider.reginaQntController.text = '';
            appProvider.tagliaQntrdController.text = '';
          });
        }
      },
      child: Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            children: [
              //Titolo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${product.name} ',
                    overflow: TextOverflow.fade,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  listaSedi.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: PopupMenuButton(
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                              color: Colors.blueGrey[800],
                              offset: const Offset(-15, 40),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                      child: ListTile(
                                    onTap: () {
                                      //Aggiungere sede nei meta_data ad una singola variazione
                                      Map sediList = {
                                        "meta_data": [
                                          {
                                            "key": "sedi",
                                            "value": [
                                              {"sede": "Regina", "quantita": 0},
                                              {
                                                "sede": "Tagliamento",
                                                "quantita": 0
                                              }
                                            ]
                                          }
                                        ]
                                      };
                                      if (appProvider.connessione == true) {
                                        appProvider
                                            .addSediToMetaData(
                                                appProvider.token,
                                                product,
                                                prodVar,
                                                sediList)
                                            .then((value) {
                                          Navigator.pop(context);
                                          debugPrint(value.toString());
                                        });
                                      } else {}
                                    },
                                    leading: const Icon(
                                      Icons.store,
                                      color: Colors.white,
                                    ),
                                    title: const Text(
                                      'Aggiungi le Sedi',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ))
                                ];
                              }),
                        )
                      : const SizedBox()
                ],
              ),
              //Categorie
              Row(
                children: [
                  SizedBox(
                    height: 20,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: product.categories!.length,
                      itemBuilder: (context, index) {
                        Categoryz? category = product.categories![index];
                        return index == product.categories!.length - 1
                            ? Text(
                                category!.name.toString(),
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                              )
                            : Text(
                                '${category!.name.toString()},  ',
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                              );
                      },
                    ),
                  ),
                ],
              ),
              //Immagine prodotto e Attributi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Immagine
                  Flexible(
                    child: Column(
                      children: [
                        Image.network(
                          '${prodVar.image!.src}',
                          height: 150,
                        ),
                      ],
                    ),
                  ),
                  //Attributi
                  Flexible(
                    child: Column(
                      children: [
                        ...prodVar.attributes!.map((e) {
                          return Container(
                              constraints:
                                  const BoxConstraints(minWidth: 100.0),
                              margin: const EdgeInsets.all(2.0),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey[700],
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Text(
                                e!.option.toString(),
                                style: const TextStyle(color: Colors.white),
                              ));
                        })
                      ],
                    ),
                  )
                ],
              ),
              //Quantità divisa per Sede
              listaSedi.isEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Nessuna sede',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      ],
                    )
                  : Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[700],
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ...listaSedi[0].map((e) {
                                ValueElementz sede = ValueElementz.fromJson(e);
                                return Flexible(
                                  child: Column(
                                    children: [
                                      Text(
                                        sede.sede,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        sede.quantita.toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              //Quantità totale e prezzo
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                      child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[700],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Disponibiltà totale:',
                          overflow: TextOverflow.fade,
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          prodVar.stockQuantity.toString(),
                          overflow: TextOverflow.fade,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ],
          )),
    );
  }
}

class CustomModalBottom extends StatelessWidget {
  const CustomModalBottom(
      {super.key,
      required this.appProvider,
      required this.prod,
      required this.prodVar});

  final AppProvider appProvider;
  final ProductsModel prod;
  final ProductVariationsModel prodVar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      //Padding iniziale per far salire il contenitore quando viene mostrata la tastiera.
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.blueGrey[800]),
        margin: const EdgeInsets.all(8.0),
        height: MediaQuery.of(context).size.height * (3 / 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Immagine
            Center(
              child: Image.network(
                '${prod.images!.first!.src}',
                width: 150,
                height: 150,
              ),
            ),
            //Titolo
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  prod.name.toString(),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //Attributi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...prodVar.attributes!.map((e) {
                  return Container(
                      constraints: const BoxConstraints(minWidth: 100.0),
                      margin: const EdgeInsets.all(2.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[700],
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        e!.option.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ));
                })
              ],
            ),
            //TextField quantità per sede
            Row(
              children: [
                Flexible(
                    child: Container(
                  margin: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: appProvider.reginaQntController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text(
                          'Regina',
                          style: TextStyle(color: Colors.white),
                        )),
                    style: const TextStyle(color: Colors.white),
                  ),
                )),
                Flexible(
                    child: Container(
                  margin: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: appProvider.tagliaQntrdController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text(
                          'Tagliamento',
                          style: TextStyle(color: Colors.white),
                        )),
                    style: const TextStyle(color: Colors.white),
                  ),
                ))
              ],
            ),
            const Spacer(),
            const Divider(),
            //Pulsanti Action
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Indietro')),
                ElevatedButton(
                    onPressed: () {
                      if (appProvider.connessione) {
                        int totQnt = int.parse(
                                appProvider.reginaQntController.text) +
                            int.parse(appProvider.tagliaQntrdController.text);
                        Map updateData = {
                          "stock_quantity": totQnt,
                          "meta_data": [
                            {
                              "key": "sedi",
                              "value": [
                                {
                                  "sede": "Regina",
                                  "quantita": int.parse(
                                      appProvider.reginaQntController.text)
                                },
                                {
                                  "sede": "Tagliamento",
                                  "quantita": int.parse(
                                      appProvider.tagliaQntrdController.text)
                                }
                              ]
                            }
                          ]
                        };
                        appProvider
                            .updateQuantity(
                                appProvider.token, prod, prodVar, updateData)
                            .then((value) {
                          Navigator.pop(context);
                        });
                      } else {}
                    },
                    child: const Text('Salva')),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
