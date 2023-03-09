import 'package:flutter/material.dart';
import 'package:magazzino/controllers/app_provider.dart';
import 'package:magazzino/models/WooCommerceModels/products_model.dart';
import 'package:magazzino/screens/detail_page.dart';
import 'package:provider/provider.dart';

class ProductSingleList extends StatelessWidget {
  const ProductSingleList({super.key, required this.prod});

  final ProductsModel prod;

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailPage(product: prod)));
      },
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: appProvider.isLightMode
                ? Colors.blueGrey
                : Colors.blueGrey.shade700,
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: [
            Row(
              children: [
                Hero(
                  tag: Text('${prod.id} '),
                  child: Image.network(
                    '${prod.images!.first!.src}',
                    height: 100,
                    errorBuilder: (context, exception, stackTrace) {
                      return const Text('Err. image...');
                    },
                  ),
                ),
                Flexible(
                    child: Text(
                  '${prod.name} ',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
