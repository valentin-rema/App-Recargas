
import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioProvider{

  final _clave= ''; //aqui va la clave para acceder al servicio



  Future<Map<String, dynamic>> login (String email, String password) async {

    //primero definimos la parte del url

    final _url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_clave';

    //ahora vamos a definir los elementos que se necesitan poner en la parte del cuerpo de la solicitud

    final datosAutenticacion = {
      'email'             : email,
      'password'          : password,
      'returnSecureToken' : true
    };

    //vamos a mandar la solicitud al endpoint para verificar si los datos son correctos

    final respuesta = await http.post(_url, body: json.encode(datosAutenticacion)); 


    //vamos a obtener los datos de la solicitud
    Map<String, dynamic> decodedData = json.decode(respuesta.body);

    if(decodedData.containsKey('idToken')){
      return { 'ok' : true, 'mensaje' : 'Acceder al sistema'};
    }else{
      return { 'ok': false, 'mensaje': decodedData['error']['message']};
    } 
  }
}