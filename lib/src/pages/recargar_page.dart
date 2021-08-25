import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class RecargarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondoPantalla(context),
          _ponerNombre(context),
          _ponerSubtitulo(),
          _ponerMenu(context),
          _piePagina(context)
        ],
      )
    );
  }

  Widget _fondoPantalla(BuildContext context){
    
    final tamPantalla = MediaQuery.of(context).size;

    //aqui vamos a poner el nombre de la empresa nada mas
    final fondo1 = Container(
      width: tamPantalla.width*1,
      height: 500.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.blueAccent
      ),
    );   


    final fondo2 = Container(
      width: tamPantalla.width*1,
      height: 500.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Color.fromRGBO(220, 44, 81, .8),
      ),
    );


    return Stack(
      children: <Widget>[
        Positioned(
          top: -350.0,
          child: fondo1
        ),
        Positioned(
          top: -420,
          child: fondo2 
        )
      ],
    );
  } 

  Widget _ponerNombre(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 129.0, vertical: 20.0),
      child: Text('T-Mar', textAlign: TextAlign.center, style: GoogleFonts.grenze(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 40.0
      )), 
    );
  }

  Widget _ponerSubtitulo(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 75.0, vertical: 90.0),
      child: Text('==Ingrese la compañia==', style: GoogleFonts.benchNine(
        color: Colors.white,
        fontSize: 30.0,
        fontWeight: FontWeight.bold
      ))
    );
  }

  Widget _ponerMenu(BuildContext context){
    final tamPantalla = MediaQuery.of(context).size;

    return Container(
      //padding: EdgeInsets.only(top: 200.0),
      margin: EdgeInsets.only(left: 20.0, top: 170.0),
      width: tamPantalla.width*.9,
      height: tamPantalla.height*.6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 1.0,
            color: Colors.black,
            offset: Offset(.5, 5.0),
            spreadRadius: 3.0 
          )
        ]
      ),
      child: Table(
              children: <TableRow>[
                TableRow(
                children: <Widget>[
                  _construirTarjeta('assets/img/telcel.png', 'Telcel', context),
                  _construirTarjeta('assets/img/movistar.png', 'Movistar', context)
                ]
                ),
                TableRow(
                  children: <Widget>[
                    _construirTarjeta('assets/img/att.png', 'ATT', context),
                    _construirTarjeta('assets/img/unefon.png', 'Unefon', context),
                  ]
                ),
            ],
          )
      );
  }

  Widget _construirTarjeta(String ubicacion, String descripcion, BuildContext context){
    return Container(
          width: 20.0,
          height: 150.0,
          margin: EdgeInsets.only(top: 45.0, left: 15.0, right: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.black,
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 7.0,
                color: Colors.blueAccent,
                offset: Offset(0.0, 5.0),
                spreadRadius: 3.0,
              )
            ]
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: 20.0),
              FlatButton(
                onPressed: (){
                  if(descripcion == 'Telcel'){
                    print('Vamos a ir a la opcion de telcel');
                    Navigator.pushNamed(context, 'telcel');
                  }
                  if(descripcion == 'Movistar'){
                    print('Vamos a ir a la opcion de movistar');
                    Navigator.pushNamed(context, 'movistar');
                  }
                  if(descripcion == 'ATT'){
                    print('Vamos a ir a la opcion de ATT');
                    Navigator.pushNamed(context, 'att');
                  }
                  if(descripcion == 'Unefon'){
                    print('Vamos a ir a la opcion de Unefon');
                    Navigator.pushNamed(context, 'unefon');
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image(image: AssetImage(ubicacion)),
                  radius: 40.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(descripcion, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0)),
            ],
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
        color: Colors.blueAccent,
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
          top: tamPantalla.height*1-100.0,
          child: piePagina
        )
      ],
    );
  }

}