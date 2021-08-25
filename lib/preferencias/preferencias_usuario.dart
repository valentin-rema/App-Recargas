


import 'package:shared_preferences/shared_preferences.dart';

class Preferencias{

  static Preferencias _instancia= new Preferencias._internal();


  factory Preferencias(){
    return _instancia;
  }

//inicializamos todas las preferencias de usuario

  Preferencias._internal();

  SharedPreferences prefs;


initPrefs() async {
    this.prefs = await SharedPreferences.getInstance();
}


 get token{
   return prefs.getString('token') ?? '';
 }

 set token(String valor){
   prefs.setString('token', valor);
 }

}