import 'package:flutter/material.dart';
import 'package:recargas/bloc/provider_page.dart';
import 'package:recargas/preferencias/preferencias_usuario.dart';
import 'package:recargas/src/pages/comprar_saldo.dart';
import 'package:recargas/src/pages/consulta_ventas.dart';
import 'package:recargas/src/pages/consultar_compras.dart';
import 'package:recargas/src/pages/consultar_saldo.dart';
import 'package:recargas/src/pages/home_page.dart';
import 'package:recargas/src/pages/login_page.dart';
import 'package:recargas/src/pages/recarga_att.dart';
import 'package:recargas/src/pages/recarga_movistar.dart';
import 'package:recargas/src/pages/recarga_telcel.dart';
import 'package:recargas/src/pages/recarga_unefon.dart';
import 'package:recargas/src/pages/recargar_page.dart';
import 'package:recargas/src/pages/total_ventas.dart'; 

void main() async {

  //cada vez que se inicilizan la preferencias de usuario esta linea de codigo
  //siempre va primero
  //WidgetsFlutterBinding.ensureInitialized();

  //vamos a inicializar las variables que nos van a servir para guardar el 
  //token y con ella los usuarios que accedan puedan ver toda la informacion 
  //de la aplicacion


  //vamos a comenzar a diseñar la opcion de consultar saldo

  //perfecto hemos terminado con la opcion de consultar saldo ahora tenemos que ir con la opcion de 
  //consultar compras

  //vamos a comenzar
  

  
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new Preferencias();
  await prefs.initPrefs();

  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login'            : (BuildContext context) => LoginPage(),
          'home'             : (BuildContext context) => HomePage(),
          'recargar'         : (BuildContext context) => RecargarPage(),
          'telcel'           : (BuildContext context) => RecargaTelcel(),
          'movistar'         : (BuildContext context) => RecargaMovistar(),
          'att'              : (BuildContext context) => RecargaAtt(),
          'unefon'           : (BuildContext context) => RecargaUnefon(),
          'consultaVentas'   : (BuildContext context) => ConsultaVentas(),
          'comprarSaldo'     : (BuildContext context) => ComprarSaldo(),
          'consultarSaldo'   : (BuildContext context) => ConsultarSaldo(),
          'consultarCompras' : (BuildContext context) => ConsultarCompras(),
          'totalVentas'      : (BuildContext context) => TotalVenta()
        },
        //color: Colors.white,
        ),
      );
  }
}


//vamos a comenzar con el backend para la venta de las recargas por parte del telcel a ver que tal
//nos va 

//ok al parecer ya tenemos la parte donde agregamos la recarga de la compañia que se escoja y esta se sube 
//a la base de datos ahora lo que vamos a hacer es mostrar las recargas que se han vendido para ver
//todos los datos ok vamos a comenzar manos a la obra 

//ok ya tenemos lista las bases de datos tanto de la parte de el saldo que tenemos y la base de datos 
//de la opcion de compras de comprar saldo.

//ok manos a la obra vamos con la opcion de comprar el saldo... listos vamos a comenzar a ver como nos
//va