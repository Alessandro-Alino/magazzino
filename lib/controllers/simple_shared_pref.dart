import 'dart:convert';
import 'package:magazzino/models/WooCommerceModels/categories_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimpleSharedPreferences {
  SharedPreferences? _pref;

  saveCategPreferiteGrid(List<CategoriesModel> categoriesListSelected) async {
    _pref = await SharedPreferences.getInstance();
    List<String> categList =
        categoriesListSelected.map((e) => jsonEncode(e.toJson())).toList();
    await _pref!.setStringList('gridPref', categList);
  }

  getCategPreferiteGrid() async {
    _pref = await SharedPreferences.getInstance();
    var x = _pref!.getStringList('gridPref');
    return x!.map((e) => CategoriesModel.fromJson(jsonDecode(e))).toList();
  }
}
