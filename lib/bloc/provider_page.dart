
//vamos a crear la parte del codigo que nos va a servir para poder acceder
//en todo momento a las variables que necesitamos tanto del usuario como de la 
//contraseña

import 'package:flutter/cupertino.dart';
import 'package:recargas/bloc/login_bloc.dart';
//import 'package:recargas/providers/login_provider.dart';

class Provider extends InheritedWidget{


  static Provider _instancia;
 
  factory Provider({Key key, Widget child}){

    if(_instancia == null){
      _instancia = new Provider._internal(key: key, child: child);
      return _instancia;
    }else{
      return _instancia;
    }
  }


  final loginBloc = new ProviderLogin();


  Provider._internal({Key key, Widget child})
    :super(key: key, child: child);
 
 
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;



  static ProviderLogin of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }
}