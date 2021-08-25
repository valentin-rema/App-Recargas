//ok estamos comenzando con la parte de de la creacion de nuestra primera aplicacion ahora lo que 
//tenemos que hacer primero es lo siguiente 


//1.- vaos a empezar a crear el boceto que nos va a servir para logear la aplicacion

//vamos a comenzar por colocar la parte donde van a ir tanto la cuenta como la contraseña para ingresar
//a la aplicacion movil

//al parecer hemos terminado con el esqueleto de la parte del login de la aplicacion ahora vamos a hacer
//la parte del backend para que podamos acceder a la pagina sin ningun problema


//al parecer hemos terminado hasta la parte donde se ingresan tanto la cuenta como la contraseña
//del usuario

//vamos a habilitar y deshabilitar el boton cuando este sea necesario 

//bien vamos a comenzar

import 'package:flutter/material.dart';
import 'package:recargas/bloc/provider_page.dart';
import 'package:recargas/providers/usuario_provider.dart';
import 'package:recargas/utils/utils.dart' as utils;

class LoginPage extends StatelessWidget {

 final usuarioProvider = new UsuarioProvider();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _agregandoLogo(context),
            SizedBox(height: 5.0,),
            Expanded(
              child: SingleChildScrollView(
                child: _creandoFormulario(context),  
              ),
            ),
          
          ],
        ),
      )
    );
  }


  Widget _creandoFormulario(BuildContext context){

    final dimensiones = MediaQuery.of(context).size;

    final blocLogin = Provider.of(context);

    return Container(
      //vamos a crear el area de trabajo de nuestro formulario
      margin: EdgeInsets.all(10.0),
      height: dimensiones.height*.55,
      width: dimensiones.width*.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.blue,
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 3.0,
            color: Colors.black,
            offset: Offset(0.0, 5.0),
            spreadRadius: 5.0
          )
        ]
      ),
      child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0),
            Text('Ingresar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30.0)),
            //ok ahora lo que vamos a poner son las cajas de texto donde van a ir tanto la cuenta 
            //como la contraseña que ingrese el usuario
            SizedBox(height: 30.0,),
            //
            //
            //parte del codigo donde se agrega la caja de texto del usuario
            //
            //
            StreamBuilder(
              stream: blocLogin.streamEmail,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  //height: 70.0,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      //hintStyle: TextStyle(backgroundColor: Colors.white),
                      hintText: 'Usuario',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.account_circle, color: Colors.greenAccent, size: 40.0),
                      errorText: snapshot.error,
                      //icon: Icon(Icons.supervised_user_circle, color: Colors.blue)
                      //fillColor: Colors.black,
                    ),
                    onChanged: (valor){
                      blocLogin.cambiarEmail(valor);
                    },

                  ),
                );
              }
            ),
            SizedBox(height: 30.0,),
            //
            //
            //parte del codigo donde se agrega la caja de texto de la contraseña
            //
            //
            StreamBuilder(
                stream: blocLogin.streamPassword,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    //height: 70.0,
                    child: TextField(
                      obscureText: true,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        //hintStyle: TextStyle(backgroundColor: Colors.white),
                        hintText: 'Contraseña',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.security, color: Colors.greenAccent, size: 40.0),
                        errorText: snapshot.error,
                        //icon: Icon(Icons.supervised_user_circle, color: Colors.blue)
                        //fillColor: Colors.black,
                      ),
                      onChanged: (valor){
                        blocLogin.cambiarPassword(valor);
                      }
                    ),
                  ); 
                }
                
            ),
            //vamos a ingresar ahora un espacio 
            SizedBox(height: 60.0),
            //
            //Parte del codigo donde se agregar el boton que va a servir para acceder a la aplicacion
            //
            StreamBuilder(
              stream: blocLogin.validarBoton,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FlatButton(
                    color: Colors.white,
                    onPressed: (snapshot.hasData)
                      ? (){
                        _logearse(context, blocLogin.usuario, blocLogin.password);
                      }
                      : null,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0)  ,
                      //color: Colors.blueGrey,
                      child: Text('Entrar', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
                    )),
                );
              }
            )
          ],
        )  
    );
  }

  _logearse(BuildContext context, String email, String password) async {
    Map<String, dynamic> confirmando = await usuarioProvider.login(email, password);

    if(confirmando['ok']){
      utils.mandarAlertaLogin(context, confirmando['mensaje']);
    }else{
      utils.mandarAlertaLoginError(context, confirmando['mensaje']);
    }
  }


  Widget _agregandoLogo(BuildContext context){
  
    final screenSize = MediaQuery.of(context).size;


    final contenedor = SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(150.0),
        child: Container(
          padding: EdgeInsets.only(left: 30.0),
          height: screenSize.height*.35,
          width: screenSize.width*.7, 
          child: Image(
            //width: double.infinity,
            image: AssetImage('assets/img/logosinfondo.png'),
            fit: BoxFit.cover,
          )       
        ),
      ),
    );


    return Stack(
      children: <Widget>[
        Positioned(
          child: contenedor,
          //left: 15.0,
        )
      ],
    );   
  }
}

