import 'package:flutter/material.dart';
import 'package:magazzino/controllers/app_provider.dart';
import 'package:magazzino/models/WooCommerceModels/products_model.dart';
import 'package:magazzino/widgets/product_single_list.dart';
import 'package:provider/provider.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key, required this.productsList});

  final List<ProductsModel> productsList;

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    List<ProductsModel> productsListFilt = widget.productsList
        .where((element) => element.categories!
            .map((e) => e!.id == appProvider.selectedIndex)
            .toList()
            .any((element) => element))
        .toList();

    return Scaffold(
      body: CustomScrollView(slivers: [
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
        appProvider.connessione
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: productsListFilt.length, (context, index) {
                ProductsModel prod = productsListFilt[index];
                return ProductSingleList(
                  prod: prod,
                );
              }))
            : const SliverToBoxAdapter(
                child: Text('Non c\'è connessione!'),
              )
      ]),
    );
  }
}
