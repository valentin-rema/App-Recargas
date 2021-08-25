//import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:recargas/models/comprarSaldoModel.dart';
import 'package:recargas/models/recargas_model.dart';
import 'package:http/http.dart' as http;
import 'package:recargas/models/saldo_model.dart';
import 'package:recargas/models/total_model.dart';
//import 'package:recargas/src/pages/total_ventas.dart';
//mport 'package:recargas/models/saldo_model.dart';





class RecargaProvider{


  final modeloRecargas = new RecargasModel();

  final modeloComprandoSaldo = new ComprarSaldoModel();

  final totalVentas = new TotalModel(); //la variable que nos va a servir para guardar los datos de 
  //las ventas

  //las variables que vamos a utilizar para poder hacer el envio de datos a firebase

  //la llave o el endpoint para poder acceder al servicio
  final _url = 'https://t-mar-f97a6.firebaseio.com';



  Future<bool> agregarRecarga(RecargasModel recarga) async {

    //ok vamos a preparar todas las cosas para poder ingresar la recarga

    //primero vamos a preparar la url

    final url = '$_url/recargas.json';

    //haciendo la solicitud al endpoint
    final respuesta = await http.post(url, body: recargasModelToJson(recarga));

    final decodedData = json.decode(respuesta.body);

    if(decodedData != null){
      return true;
    }
    else{
      return false;
    }
  }

  Future<List<RecargasModel>> obtenerRecargas() async {
    
    List<RecargasModel> recargas = new List(); 

    final url = '$_url/recargas.json';


    //vamos a hacer la peticion al endpoint
    final respuesta = await http.get(url);

    Map<String, dynamic> decodedData = json.decode(respuesta.body);

    if(decodedData != null){
      decodedData.forEach((id, recarga){
        //hemos puesto solo los datos de la recargas en una variable temporal
        final recargaTemp = RecargasModel.fromJson(recarga);
        //vaciamos la primera recarga en nuestra lista de recargas
        recargas.add(recargaTemp);
      });
    }else{
      print('Error al obtener los datos de las recargas');
    }
    return recargas;
  }

  Future<bool> agregarCompraSaldo(ComprarSaldoModel comprarSaldo) async {
    //primero vamos a definir el endpoint donde se guardan los datos de la compra del saldo

    final url = '$_url/comprar_saldo.json';

    //ahora lo que vamos a hacer es hacer la solicitud

    final respuesta = await http.post(url, body: comprarSaldoModelToJson(comprarSaldo));

    //ahora lo que vamos a hacer es obtener la respuesta que nos envia firebase

    Map<String, dynamic> decodedData = json.decode(respuesta.body);

    if(decodedData.containsKey('name')){
      print('vamos a ver si entramos cuando nos mande algo firebase');
      return true;
    }
    else{
      return false;
    }
  }

  //en este metodo solo cambiamos dependiendo del caso el saldo que tenemos en nuestro sistema de
  //recargas
  Future cambiandoSaldo(double cantidad, String cambio) async {

    final SaldoModel saldo = new SaldoModel();


    //lo primero que tenemos que hacer es definir el url de la parte del saldo con ella vamos a ver
    //primero cuanto tenemos de saldo
    final urlSaldo = '$_url/saldo.json'; 

    //obtenemos los valores que se encuentran en la base de datos de saldo
    final respuesta1 = await http.get(urlSaldo);

    Map<String, dynamic> decodedData1 = json.decode(respuesta1.body);
    //vamos a imprimir a ver como salen los valores del saldo

    //solamente sale esto al momento de obtener los valores de la base de datos de saldo {cantidad: 500.0}

    //ok ahora lo que vamos a hacer es la manipulacion de esa cantidad

    //vamos a ver como lo saco

    String cantidadProvisional = decodedData1['cantidad'].toString();

    //vamos a imprimir la cantida a ver si lo guarda bien

    saldo.cantidad = double.parse(cantidadProvisional);

    //ok hemos comprobado que sale la cantidad que nosotros deseamos ahora lo que vamos a hacer es 
    //sumarle esa cantidad al saldo que tenemos o en su defecto a restarlo dependiendo del caso
    print(saldo.cantidad);

    //bien ahora vamos a poner un if para ver cuando vamos a sumar y cuando vamos a restar


    //en la variable cantidad que recibimos estan el saldo que apenas recargamos


    //condicional que sirve cuando la persona hizo una compra de saldo
    if(cambio == '+'){
      //esta es la opcion para que sumemos la cantidad del saldo
      //vamos a hacer el cambio del saldo 

      saldo.cantidad = saldo.cantidad+cantidad;

      //ahora si vamos a hacer la respectiva modificacion

      final respuesta2 = await http.put(urlSaldo, body: saldoModelToJson(saldo));

      final decodedData2 = json.decode(respuesta2.body);

      print(decodedData2);

      //se ha cambiado el valor de saldo sin ningun problema hemos resuelto toda la parte de comprarSaldo

    }

    //condicional que sirve para funcionar cuando la persona hizo una recarga
    if(cambio == '-'){
      //esta es la opcion para que sumemos la cantidad del saldo
      //vamos a hacer el cambio del saldo 

      saldo.cantidad = saldo.cantidad-cantidad;

      //ahora si vamos a hacer la respectiva modificacion

      final respuesta2 = await http.put(urlSaldo, body: saldoModelToJson(saldo));

      final decodedData2 = json.decode(respuesta2.body);

      print(decodedData2);

      //se ha cambiado el valor de saldo sin ningun problema hemos resuelto toda la parte de comprarSaldo

    }
    
  }

  Future<double> obtenerSaldo() async {

    //{cantidad: 1030}

    //primero vamos a definir la url del endpoint

    final url = '$_url/saldo.json';

    //vamos a hacer la consulta en la base de datos

    final respuesta = await http.get(url);

    //vamos a sacar la informacion que salio de la consulta

    Map<String, dynamic> decodedData = json.decode(respuesta.body);

    String saldoProv = decodedData['cantidad'].toString();

    final saldo = double.parse(saldoProv);
    
    return saldo;

  }

  //este metodo sirve para obtener todos las compras de los saldo que hemos hecho
  Future<List<ComprarSaldoModel>> obtenerSaldos() async {
    //vamos a definir el endpoint que nos va a servir para obtener todas las compras de saldo

    List<ComprarSaldoModel> saldoCompras = new List();


    final url = '$_url/comprar_saldo.json';

    //linea de codigo que sirve para obtener los datos de todas las compras 
    final respuesta = await http.get(url);

    Map<String, dynamic> decodedData = json.decode(respuesta.body);

    decodedData.forEach((id, comprasSaldos){
      
        //vamos a ir recorriendo uno por uno las opciones
        final compraProvisional = ComprarSaldoModel.fromJson(comprasSaldos);
        
        saldoCompras.add(compraProvisional);
    });

    return saldoCompras;
  }

  Future<double> obtenerVentaTotal() async {
    //ok lo primero que vamos a hacer es obtener el total de todas las ventas

    //{cantidad: 200.0, compania: Telcel, fecha: 2020-08-31  2:13:57 PM, telefono: 2211524690}

    
    double total;

    final url = '$_url/venta_total.json';

    final respuesta = await http.get(url);

    Map<String, dynamic> todasVentas = json.decode(respuesta.body);

    String totalProvisional = todasVentas['cantidad'].toString();

    total = double.parse(totalProvisional);

    return total;

  }

  //como sugerencia hay que agregar una base de datos mas que se llame venta total para que cuando se 
  //desee cambiar el valor de las ventas totales


  //ahora vamos a definir una variable que nos va a servir para aumentar el valor de las ganancias
  //o de las recargas que hemos vendido hasta el momento 

  Future aumentarGanancias(double recarga) async {
    //vamos a definir el endpoint de donde se encuentra la base de datos de las ventas totales

    String totalProvisional;

    double ventasTotales;

    final url = '$_url/venta_total.json';

    final respuesta = await http.get(url);

    //vamos a sacar el valor de las ventas totales
    Map<String, dynamic> decodedData = json.decode(respuesta.body);

    totalProvisional = decodedData['cantidad'].toString();

    ventasTotales = double.parse(totalProvisional);

    //aumentamos la cantidad de las gananacias mas la nueva recarga vendida
    totalVentas.cantidad= ventasTotales+ recarga;

    //vamos a agregar la nueva cantidad de las ganancias

    final respuesta2 = await http.put(url, body: totalModelToJson(totalVentas));

    final decodedData2 = json.decode(respuesta2.body);

    print(decodedData2);
  }
}