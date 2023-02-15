import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:magazzino/controllers/repository.dart';
import 'package:magazzino/models/login_model.dart';
import 'package:magazzino/models/WooCommerceModels/categories_models.dart';
import 'package:magazzino/models/WooCommerceModels/product_variations_model.dart';
import 'package:magazzino/models/WooCommerceModels/products_model.dart';

class AppProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  String _errorUserNameLogin = '';
  String _errorPassLogin = '';
  String _token = '';
  bool _isLightMode = true;
  bool _passVisible = true;
  bool _isLoggedIn = false;
  bool _isLoading = false;
  bool _connessione = false;
  double _widthContainer = 0.0;
  LoginModel? _loginModel;
  List<CategoriesModel> _categoriesList = [];
  List<ProductsModel> _productsList = [];
  List<ProductVariationsModel> _productVarList = [];
  final TextEditingController _reginaQntController = TextEditingController();
  final TextEditingController _tagliaQntrdController = TextEditingController();

  //Cambio Tema Light e Dark
  setLightOrDarkMode() {
    _isLightMode = !_isLightMode;
    notifyListeners();
  }

  //Mostra o nasconde testo Password Login
  showHidePassLogin() {
    _passVisible = !_passVisible;
    notifyListeners();
  }

  //ErrorTextUsernameLogin
  setErrorUserNameLogin(String message) {
    _errorUserNameLogin = message;
    notifyListeners();
  }

  //ErrorTextPasswordLogin
  setErrorPassLogin(String message) {
    _errorPassLogin = message;
    notifyListeners();
  }

  //Loading Progress
  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //Controllo Stream della Connessione
  checkConnection(
    ConnectivityResult result,
  ) {
    if (result == ConnectivityResult.none) {
      _connessione = false;
      _widthContainer = 110.0;
    } else {
      _connessione = true;
      _widthContainer = 90.0;
    }
    notifyListeners();
  }

  //Controllo Connessione Messaggio
  modificaWidth() async {
    await Future.delayed(const Duration(seconds: 3), () {
      _widthContainer = 0;
    });
    notifyListeners();
  }

  //Avviso Generico
  mostraMessaggio(
      BuildContext context, String mex, Color? colore, IconData? icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
            decoration: BoxDecoration(
                color: colore, borderRadius: BorderRadius.circular(10.0)),
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              title: Text(
                mex,
                style: const TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                icon,
                color: Colors.white,
              ),
            )),
      ),
    );
    notifyListeners();
  }

  //Token per Autorizzazione Generale
  setToken(String token) {
    _token = token;
    notifyListeners();
  }

  //Stream Lista di Tutti i Dati
  Future userLogin(bool value) async {
    _isLoggedIn = value;
    notifyListeners();
  }

  //RICHIESTA TOKEN LOGIN E ACCESSO
  Future requestLogin(
      BuildContext context, String username, String password) async {
    _loginModel = await Repo.requestLogin(username, password);
    notifyListeners();
  }

  //Chiamata per Tutti i dati
  Future readAll(String token) async {
    try {
      _categoriesList = await Repo.readCategories(token);
      _productsList = await Repo.readProducts(token);
    } catch (e) {
      debugPrint('Error Read All AppProvider');
    }
    notifyListeners();
  }

  //Chiamata per le Variazioni
  Future readProductVariations(String token, ProductsModel product) async {
    try {
      _productVarList = await Repo.readProductVariations(token, product);
    } catch (e) {
      debugPrint('Error Read All Variations AppProvider');
    }
    notifyListeners();
  }

  //Aggiunta delle sedi nei meta dati
  Future addSediToMetaData(String token, ProductsModel prod,
      ProductVariationsModel prodVar, Map sediList) async {
    try {
      await Repo.updateSediToMetaData(token, prod, prodVar, sediList);
      debugPrint(sediList.toString());
    } catch (e) {
      debugPrint('Error Add Sedi to Metadata');
    }
    notifyListeners();
  }

  //Aggiornare Quantità Prodotti
  Future updateQuantity(String token, ProductsModel prod,
      ProductVariationsModel prodVar, Map data) async {
    try {
      await Repo.updateQuantity(token, prod, prodVar, data);
    } catch (e) {
      debugPrint('Error Update Quantity');
    }
    notifyListeners();
  }

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get userNameController => _userNameController;
  TextEditingController get passWordController => _passWordController;
  String get errorUserNameLogin => _errorUserNameLogin;
  String get errorPassLogin => _errorPassLogin;
  String get token => _token;
  bool get isLightMode => _isLightMode;
  bool get passVisible => _passVisible;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  bool get connessione => _connessione;
  double? get widthContainer => _widthContainer;
  LoginModel? get loginModel => _loginModel;
  List<CategoriesModel> get categoriesList => _categoriesList;
  List<ProductsModel> get productsList => _productsList;
  List<ProductVariationsModel> get productVariationsList => _productVarList;
  TextEditingController get reginaQntController => _reginaQntController;
  TextEditingController get tagliaQntrdController => _tagliaQntrdController;
}
