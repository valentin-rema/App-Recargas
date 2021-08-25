import 'package:flutter/material.dart';


void mandarAlertaLogin(BuildContext context, String mensaje){

  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text('Datos Correctos'),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, 'home');
            }, 
            child: Text('Ok')
          )
        ],
      );
    }
  );
}


void mandarAlertaLoginError(BuildContext context, String mensaje){

  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text('Datos Incorrectos'),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.pop(context);
              //Navigator.pushReplacementNamed(context, 'home');
            }, 
            child: Text('Ok')
          )
        ],
      );
    }
  );
}


bool isNumeric(String cantidad){
  if(cantidad.isNotEmpty){
    final numero = num.tryParse(cantidad);
    if(numero != null){
      return true;
    }else{
      return false;
    }
  }
  else{
    return false;
  } 
}


//notas
//para que solo los usuarios autenticados puedan acceder a la informacion del sistema en la parte del 
//endpoint donde se sacan los datos de la base de datos agregar solo lo siguiente ?auth=${_prefs.token} 
//y ya con eso podemos acceder a toda la informacion de nuestro programa