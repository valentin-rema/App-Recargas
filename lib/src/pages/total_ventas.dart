import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recargas/providers/recargas_provider.dart';
//import 'package:recargas/providers/recargas_provider.dart';


//vamos a terminar la ultima parte es decir que en la parte de ventas de recargas como en la compra 
//de saldo no aparezca nada ya que efecticavamente a partir de hoy la aplicacion a pasado por todas
//las pruebas y esta lista para su lanzamiento 



class TotalVenta extends StatelessWidget{


  //vamos a definir la variable que nos va a servir para poder acceder a los 
  //providers

  final providerSaldo = new RecargaProvider();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Total Ventas', style: TextStyle(color: Colors.white))
      ),
      body: Stack(
        children: <Widget>[
          _areaTrabajo(context),
          _piePagina(context),
        ],
      )
    );
  }

  Widget _areaTrabajo(BuildContext context){
    //vamos a poner el container que va a servir para contener el area de trabajo donde vamos a poner
    //el saldo con el cual contamos

    //vamos a obtener el valor  del saldo que tenemos.
    final tamPantalla = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 80.0, horizontal: 30.0),
      width: tamPantalla.width*.85,
      height: tamPantalla.height*.55,
      //margin: EdgeInsets.symmetric(vertical: 80.0),
      decoration: BoxDecoration(
        //color: Colors.white,
        borderRadius: BorderRadius.circular(50.0)
      ),
      //vamos ahora a ingresar las cosas que necesitamos en el container
      child: FutureBuilder(
        future: providerSaldo.obtenerVentaTotal(),
        builder: (BuildContext context, AsyncSnapshot<double> snapshot){
          if(snapshot.hasData){
            return Column(
              children: <Widget>[
                //Divider(color: Colors.black38),
                SizedBox(height: 40.0),
                _imagenDinero(context),
                SizedBox(height: 20.0),
                Text('Venta Total', style: GoogleFonts.pressStart2p(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 25.0),
                _ventaTotal(snapshot.data),
                //SizedBox(height: 25.0),
                //Divider()
              ],
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      } 
    )
    );
  }

  Widget _ventaTotal(double context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.attach_money, color: Colors.black, size: 30.0),
        Text('$context', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.0))
      ],
    );
  }

  Widget _imagenDinero(BuildContext context){
    final tamPantalla = MediaQuery.of(context).size;
    return Container(
      width: tamPantalla.width*1,
      height: 130.0,
      child: Image(
        image: AssetImage('assets/img/bolsaDinero.png'),
        //fit: BoxFit.cover,
      )
    );
  }


  Widget _piePagina(BuildContext context){

    final tamPantalla = MediaQuery.of(context).size;

    final piePagina = Container(
      width: tamPantalla.width*1,
      height: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.blueAccent
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 40.0),
          Container(
            padding: EdgeInsets.only(top: 3.0),
            margin: EdgeInsets.only(right: 5.0),
            child: CircleAvatar(
              child: Image(
                image: AssetImage('assets/img/logosinfondo.png')
              ),
              radius: 46.0,
              backgroundColor: Colors.white,
            ),
          ),
        Flexible(
          child: Column(
            //SizedBox(height: 20.0),
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 17.0),
              Text('Calle Melchor Ocampo #104', style: GoogleFonts.blackAndWhitePicture(fontSize: 18.0)),
              Text('Altepexi, Puebla Mexico', style: GoogleFonts.blackAndWhitePicture(fontSize: 18.0)),
              Text('Tel: 2361079618', style: GoogleFonts.blackAndWhitePicture(fontSize: 18.0)),
            ],
          )
        )
        ],
      )
    );

    return Stack(
      children: <Widget>[
        Positioned(
          top: tamPantalla.height*1-185.0,
          child: piePagina
        )
      ],
    );
  }


}