
//import 'package:flutter/cupertino.dart';
import 'package:recargas/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class ProviderLogin with Validators{

  //primero vamos a definir los streamsBuilders los cuales nos van a servir
  //para poder controlar el flujo de la informacion tanto de la cuenta como
  //de la contraseña

  //variable para manerajar el flujo de la informacion de la cuenta
  final _controllerEmail = BehaviorSubject<String>();

  //varable para controlar el flujo de informacion por parte de la contraseña
  final _controllerPassword = BehaviorSubject<String>();


  //vamos a definir las variables que nos van a servir para poder extraer los valores de los streams


  Stream<String> get streamEmail => _controllerEmail.transform(validarEmail);

  Stream<String> get streamPassword => _controllerPassword.transform(validarPassword); 


  //ahora las funciones para ir cambiando el flujo de la informacion que se manda en los controller 
  //tanto de la cuenta como de la contraseña

  Function(String) get cambiarEmail => _controllerEmail.sink.add;

  Function(String) get cambiarPassword => _controllerPassword.sink.add; 


  //ahora vamos a crear unas variables que nos van a servir para sacar la informacion que se 
  //encuentra en los controller

  String get usuario => _controllerEmail.value;

  String get password => _controllerPassword.value;


  //ahora falta agregar la funcion que nos va a servir para activar o desactivar el boton de ingresar
  
  Stream<bool> get validarBoton => Rx.combineLatest2(streamEmail, streamPassword, (a, b) => true);


  //esta funcion siempre se declara para que el stramController no se queje
  //con el warning
  void dispose(){
    _controllerEmail?.close();
    _controllerPassword?.close();
  }

}