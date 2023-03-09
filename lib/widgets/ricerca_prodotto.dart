import 'package:flutter/material.dart';
import 'package:magazzino/controllers/app_provider.dart';
import 'package:magazzino/models/WooCommerceModels/products_model.dart';
import 'package:magazzino/widgets/product_single_list.dart';
import 'package:provider/provider.dart';

class RicercaProdotto extends StatelessWidget {
  const RicercaProdotto({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    List<ProductsModel> productsListSearched = appProvider.productsListSearched;

    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: [
          TextFormField(
            controller: appProvider.ricercaController,
            onChanged: (value) {
              appProvider.searchedProducts(value);
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(), label: Text('Cerca')),
          ),
          const Divider(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: appProvider.connessione
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Cerca un Prodotto... ',
                        style: TextStyle(fontSize: 17),
                      ),
                      Icon(Icons.search)
                    ],
                  )
                : const Text('Sembra non ci sia Connessine!'),
          ),
          productsListSearched.isEmpty
              ? const SizedBox()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: productsListSearched.length,
                  itemBuilder: (context, index) {
                    ProductsModel prod = productsListSearched[index];
                    return ProductSingleList(
                      prod: prod,
                    );
                  })
        ],
      ),
    ));
  }
}
