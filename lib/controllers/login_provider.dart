import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:magazzino/controllers/repository.dart';
import 'package:magazzino/models/login_model.dart';

class LoginProvider extends ChangeNotifier {
  bool _connessione = false;
  bool _hidePsw = true;
  bool _isLoading = false;
  LoginModel? _loginModel;
  String _token = '';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameContr = TextEditingController();
  final TextEditingController _passNameContr = TextEditingController();

  mostraAvviso(
      BuildContext context, String message, Color color, Duration duration) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        backgroundColor: color,
        duration: duration,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 120,
            right: 20,
            left: 20),
      ),
    );
    notifyListeners();
  }

  checkConnection(
    BuildContext context,
    ConnectivityResult result,
  ) {
    if (result == ConnectivityResult.none) {
      _connessione = false;
    } else {
      _connessione = true;
    }
    notifyListeners();
  }

  Future requestLogin(String username, String password) async {
    _loginModel = await Repo.requestLogin(username, password);
    notifyListeners();
  }

  setToken(String token) {
    _token = token;
    notifyListeners();
  }

  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  showPsw(bool value) {
    _hidePsw = value;
    notifyListeners();
  }

  bool? get connessione => _connessione;
  bool get hidePsw => _hidePsw;
  bool? get isLoading => _isLoading;
  GlobalKey<FormState> get formKey => _formKey;
  LoginModel? get loginModel => _loginModel;
  String get token => _token;
  TextEditingController? get userNameContr => _userNameContr;
  TextEditingController? get passNameContr => _passNameContr;
}
