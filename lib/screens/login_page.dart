import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:magazzino/controllers/app_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      appProvider.checkConnection(result);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          appProvider.connessione == true
              ? Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      color: Colors.green[500],
                      borderRadius: BorderRadius.circular(20.0)),
                  child: const Icon(Icons.wifi, color: Colors.white),
                )
              : Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      color: Colors.red[500],
                      borderRadius: BorderRadius.circular(20.0)),
                  child: const Icon(Icons.wifi_off, color: Colors.white),
                ),

          //Switch Theme Light and Dark
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  appProvider.setLightOrDarkMode();
                },
                icon: appProvider.isLightMode == true
                    ? const Icon(Icons.light_mode)
                    : const Icon(Icons.dark_mode)),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            //Padding iniziale per far salire il contenitore quando viene mostrata la tastiera.
            padding: MediaQuery.of(context).viewInsets,
            constraints: const BoxConstraints(maxWidth: 800),
            child: Form(
                key: appProvider.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    //USERNAME TEXTFIELD
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: appProvider.userNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '"Email o Username" non può essere vuoto';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Email o Username')),
                        )),
                    //PASSWORD TEXTFIELD
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: appProvider.passWordController,
                          obscureText: appProvider.passVisible,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '"Password" non può essere vuoto';
                            } else if (value.length < 8) {
                              return 'La Password è troppo corta';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              label: const Text('Password'),
                              suffixIcon: appProvider.passVisible == false
                                  ? IconButton(
                                      onPressed: () =>
                                          appProvider.showHidePassLogin(),
                                      icon: const Icon(Icons.visibility))
                                  : IconButton(
                                      onPressed: () =>
                                          appProvider.showHidePassLogin(),
                                      icon: const Icon(Icons.visibility_off))),
                        )),
                    //PULSANTE ACCEDI
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                  const Size(90, 50),
                                ),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(15.0),
                                ),
                              ),
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (appProvider.connessione == false) {
                                  appProvider.mostraMessaggio(
                                      context,
                                      'Nessuna Connessione',
                                      Colors.red,
                                      Icons.wifi_off);
                                } else {
                                  if (appProvider.formKey.currentState!
                                      .validate()) {
                                    //Icona Caricamento
                                    appProvider.setIsLoading(true);
                                    appProvider
                                        .requestLogin(
                                            context,
                                            appProvider.userNameController.text,
                                            appProvider.passWordController.text)
                                        .then((value) {
                                      //Icona Caricamento STOP
                                      appProvider.setIsLoading(false);
                                      //Controllo se Email o Psw errate
                                      if (appProvider.loginModel!.code ==
                                          'invalid_username') {
                                        appProvider.mostraMessaggio(
                                            context,
                                            'Username non valido',
                                            Colors.red,
                                            Icons.error);
                                      } else if (appProvider.loginModel!.code ==
                                          'incorrect_password') {
                                        appProvider.mostraMessaggio(
                                            context,
                                            'Password non valida',
                                            Colors.red,
                                            Icons.error);
                                      } else if (appProvider
                                              .loginModel!.success ==
                                          true) {
                                        //Bool per confermare che utente è loggato
                                        appProvider.userLogin(true);
                                        //Salvare il Token nella variabile
                                        appProvider.setToken(
                                            appProvider.loginModel!.data.token);
                                        //Dopo Login, pulire i textfield e bool passwhide
                                        appProvider.userNameController.clear();
                                        appProvider.passWordController.clear();
                                        appProvider.passVisible == false
                                            ? appProvider.showHidePassLogin()
                                            : null;
                                      }
                                    });
                                  }
                                }
                              },
                              child: appProvider.isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : const Text('Accedi'))
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
