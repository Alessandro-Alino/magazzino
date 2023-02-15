import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:magazzino/models/WooCommerceModels/categories_models.dart';
import 'package:magazzino/models/WooCommerceModels/product_variations_model.dart';
import 'package:magazzino/models/WooCommerceModels/products_model.dart';
import 'package:magazzino/models/login_model.dart';
import 'package:http/http.dart' as http;

class Repo {
  static const baseURL = 'https://www.icomroma.com/vendita/wp-json';
  static const consumKey = 'ck_dd1520247d9b79778b736c08a31a4492e4e14e46';
  static const secretKey = 'cs_c984819d251591a1ad39784aaced9f9df82a13e8';

  //Richiesta del Token per autorizzazione
  static Future requestLogin(String username, String password) async {
    try {
      final response =
          await http.post(Uri.parse('$baseURL/jwt-auth/v1/token'), headers: {
        'Content-type': 'application/x-www-form-urlencoded',
      }, body: {
        'username': username,
        'password': password,
      });
      if (response.statusCode == 200) {
        var jsonRes = jsonDecode(response.body);
        return LoginModel.fromJson(jsonRes);
      } else if (response.statusCode == 403) {
        var jsonRes = jsonDecode(response.body);
        debugPrint(jsonRes.toString());
        return LoginModel.fromJson(jsonRes);
      } else {
        debugPrint(response.body.toString());
        throw 'Error loginUser';
      }
    } catch (e) {
      if (e is SocketException) {
        debugPrint('Socket Exception catchato');
      }
    }
  }

  static Future updateSediToMetaData(String token, ProductsModel prod,
      ProductVariationsModel prodVar, Map sediList) async {
    final response = await http.post(
        Uri.parse(
            '$baseURL/wc/v3/products/${prod.id}/variations/${prodVar.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(sediList));
    if (response.statusCode == 200) {
      debugPrint(response.body.toString());
    } else {
      debugPrint(response.body.toString());
      throw 'Error Location';
    }
  }

  //Chiamata per leggere categorie
  static Future<List<CategoriesModel>> readCategories(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseURL/wc/v3/products/categories?per_page=100'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        List jsonRes = jsonDecode(response.body);
        var res = jsonRes.map((e) => CategoriesModel.fromJson(e)).toList();
        return res;
      } else {
        debugPrint(response.body.toString());
        throw 'Error Categories';
      }
    } catch (e) {
      if (e is SocketException) {
        debugPrint('Socket Exception catchato Categorie');
      }
      List<CategoriesModel> list = [];
      return list;
    }
  }

  //Chiamata per leggere i Prodotti
  static Future<List<ProductsModel>> readProducts(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseURL/wc/v3/products?per_page=100'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        List jsonRes = jsonDecode(response.body);
        var res = jsonRes.map((e) => ProductsModel.fromJson(e)).toList();
        return res;
      } else {
        debugPrint(response.body.toString());
        throw 'Error Products';
      }
    } catch (e) {
      if (e is SocketException) {
        debugPrint('Socket Exception catchato Prodotti');
      }
      List<ProductsModel> list = [];
      return list;
    }
  }

  //Chiamata per leggere le variazioni di un Prodotto
  static Future<List<ProductVariationsModel>> readProductVariations(
      String token, ProductsModel product) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseURL/wc/v3/products/${product.id}/variations?per_page=100'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        List jsonRes = jsonDecode(response.body);
        var res =
            jsonRes.map((e) => ProductVariationsModel.fromJson(e)).toList();
        return res;
      } else {
        debugPrint(response.body.toString());
        throw 'Error ProductVariations';
      }
    } catch (e) {
      if (e is SocketException) {
        debugPrint('Socket Exception catchato Variazioni');
      }
      List<ProductVariationsModel> list = [];
      return list;
    }
  }

  //Cambiare le quantità per singola sede
  static Future updateQuantity(String token, ProductsModel prod,
      ProductVariationsModel prodVar, Map data) async {
    try {
      final response = await http.post(
          Uri.parse(
              '$baseURL/wc/v3/products/${prod.id}/variations/${prodVar.id}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        debugPrint(response.body.toString());
      } else {
        debugPrint(response.body.toString());
        throw 'Error updateQuantity';
      }
    } catch (e) {
      if (e is SocketException) {
        debugPrint('Socket Exception catchato updateQuantity');
      }
    }
  }
}
