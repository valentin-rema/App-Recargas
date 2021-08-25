import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recargas/models/recargas_model.dart';
import 'package:intl/intl.dart';
import 'package:recargas/providers/recargas_provider.dart';

class RecargaUnefon extends StatefulWidget {
  @override
  _RecargaUnefonState createState() => _RecargaUnefonState();
}

class _RecargaUnefonState extends State<RecargaUnefon> {

  //variables globales que vamos a necesitar
  //las columnas de la base de datos son: compania, cantidad, telefono, fecha las cuales son de tipo
  //String, double, String, String

  //tanto como los campos de texto de numero 1 y de numero 2 no van a tener la opcionde onSaved

  final keyForm = new GlobalKey<FormState>();

  String _eligiendoValor;

  String num1, num2;

  String fecha;

  RecargaProvider recargasProvider = new RecargaProvider(); 

  bool recargando = false;


  RecargasModel recargasModel = new RecargasModel(); 

  @override
  Widget build(BuildContext context) {

    //vamos a declarar la variable que sirve para manejar los datos de las recargas

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondoPantalla(context),
          _ponerNombre(context),
          _ponerSubtitulo(),
          _areaTrabajo(context),
          _piePagina(context)
        ],  
      )
    );
  }

  Widget _areaTrabajo(BuildContext context){

    final screenSize = MediaQuery.of(context).size;

    final cuerpo  = Container(
      //padding: EdgeInsets.only(top: 100.0),
      //margin: EdgeInsets.symmetric(horizontal: 15.0),
      height: screenSize.height*.62,
      width: screenSize.width*.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 1.0,
            color: Colors.black,
            offset: Offset(0.5, 5.0),
            spreadRadius: 3.0
          )
        ]
      ),
      child: SingleChildScrollView(
        child: Form(
          key: keyForm,
          child: Column(
            children: <Widget>[
              //SizedBox(height: 5.0),
              Container(
                //color: Colors.white,
                padding: EdgeInsets.only(top:20.0),
                height: 70.0,
                width: 200.0,
                //margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: Image(image: AssetImage('assets/img/unefon.png'), fit: BoxFit.cover),
                
              ),
              SizedBox(height: 30.0),
              //vamos a agregar el dropdownBotton
              Container(
                width: screenSize.width*.7,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.5, color: Color.fromRGBO(149, 157, 155, 1.0)),
                    left: BorderSide(width: 0.5, color: Color.fromRGBO(149, 157, 155, 1.0)),
                    right: BorderSide(width: 0.5, color: Color.fromRGBO(149, 157, 155, 1.0)),
                    top: BorderSide(width: 0.5, color: Color.fromRGBO(149, 157, 155, 1.0))
                  ) 
                ),
                //height: 72,
                //margin: EdgeInsets.symmetric(horizontal: 50.0),
                child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Elige un producto',
                      //alignLabelWithHint: false,
                      enabledBorder: InputBorder.none,
                      //errorStyle: TextStyle(decoration: TextDecoration()),
                      //suffixIcon: Icon(Icons.arrow_drop_down)
                    ),
                  //itemHeight: 1.0,
                    validator: (valor){
                      if(valor != null){
                        return null;          
                      }else{
                        return 'Seleccione la cantidad de la recarga';
                      }
                    },
                    onSaved: (valor2){
                      //vamos a guardar la cantidad que selecciono el usuario en nuestra variables
                      //recargasModel
                      recargasModel.cantidad = double.parse(valor2);
                      //print(recargasModel.cantidad);
                    },
                    //hint: Text('Elige un producto', style: TextStyle(color: Colors.black)),
                    //icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                    //isExpanded: true,
                    value: _eligiendoValor,
                    items: <String>[
                      '10.00', 
                      '20.00', 
                      '30.00', 
                      '50.00', 
                      '100.00',
                      '150.00',
                      '200.00',
                      '300.00',
                      '500.00'
                      ].map<DropdownMenuItem<String>>((String valor){
                        return DropdownMenuItem(
                          value: valor,
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 20.0),
                                Icon(Icons.attach_money, color: Colors.redAccent, size: 20.0),
                                //SizedBox(width: 1.0),
                                Text(valor, style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                                SizedBox(width: 5.0),
                                Text('pesos', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold))
                              ],
                            )
                          )//, style: TextStyle(color: Colors.black), textAlign: TextAlign.right)
                          );
                      }).toList(), 
                    onChanged: (valor2){
                      setState(() {
                        _eligiendoValor = valor2;  
                        //ok al guardar la opcion del dropdown se guarda la cantidad a recargar con dos 
                        //decimales 
                        print(_eligiendoValor);
                      });
                    }
                  ),
              ),
              SizedBox(height: 25.0),
              _agregandoNumero1(),
              SizedBox(height: 40.0),
              _agregandoNumero2(),
              SizedBox(height: 25.0),
              _agregarBoton(context)
              //Text('vamos a ver donde va', style: TextStyle(color: Colors.black)),
            ], //hasta aqui termina la parte de la columna del area de trabajo
          ),
        ),
      )
    );

    return Stack(
      children: <Widget>[
        Positioned(
          child: cuerpo,
          top: 165.0,
          left: screenSize.width*.05,
        )
      ],
    );
  }


  Widget _agregarBoton(BuildContext context){
    return Container(
      width: 170.0,
      height: 50.0,
      margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.blueAccent,
      ),
      child: FlatButton(
        onPressed: (){
          _saveDatos(context);
        }, 
        child: Text('Vender', textAlign: TextAlign.center, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white))
      ),
    );
  }

  _saveDatos(BuildContext context) async {
    
    if(!keyForm.currentState.validate()){
      return;
    }

    keyForm.currentState.save();

    if(num1 == num2){

      //ok hemos obtenido todos los valores de los datos que vamos a necesitar subir a la base de datos
      //ahora vamos a guardarlos en firebase

      print('todos los datos son correctos.........');
      //hasta aqui ya tenemos la cantidad, telefono, compañia
      recargasModel.telefono = num1;
      recargasModel.compania = 'Unefon';

      
      //vamos a obtener la fecha en la que se hace la recarga
      final fecha = new DateTime.now();
      final formatoFecha = new DateFormat('yyyy-MM-dd');
      String fechaString = formatoFecha.format(fecha);

      String horaString = DateFormat('jms').format(fecha);

      String fechadefinitiva = '$fechaString  $horaString';
      recargasModel.fecha = fechadefinitiva;

      print('Los datos de la recarga son los siguientes');
      print('compañia: ${recargasModel.compania}');
      print('cantidad: ${recargasModel.cantidad}');
      print('fecha: ${recargasModel.fecha}');
      print('telefono: ${recargasModel.telefono}');

      //ok hasta aqui hemos guardado todos los datos que necesitamos para ya poder subirlos a la 
      //base de datos, a continuacion vamos a comenzar con el guardado de estos en la base de datos
      //que se encuentra en nuestro proyecto de firebase
      while(!recargando){
        print('entro al menos una vez en falso');
        showDialog(
          context: context,
          builder: (context){
            return Center(
              child: Container(
                //margin: EdgeInsets.all(10.0),
                color: Colors.white,
                width: 70.0,
                height: 70.0,
                child: Container(
                  margin: EdgeInsets.all(15.0),
                  child: CircularProgressIndicator()
                  ),
              ),
            ); 
          }
        );
        await Future.delayed(
          Duration(seconds: 2)
        );
        recargando = await recargasProvider.agregarRecarga(recargasModel);

        await recargasProvider.cambiandoSaldo(recargasModel.cantidad, '-');

        //ahora hay que aumentar el valor de las ganancias ya que acabamos de vender una recarga

        await recargasProvider.aumentarGanancias(recargasModel.cantidad);

      }
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Operacion'),
            content: Text('Recarga Exitosa'),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, 'home', (r)=> false);
                },
                child: Text('OK')
              )
            ],
          );
        }
      );
    }else{
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Error'),
            content: Text('Los numeros celular son diferentes'),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ) 
            ],
          );
        }
      );
    }
  }


  Widget _agregandoNumero2(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        //controller: controladorNum2,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        keyboardType: TextInputType.numberWithOptions(decimal: false),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: 'Escriba el numero de telefono',  
          //hintStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        validator: (valor){
          if(valor.length > 9){
            return null;
          }else{
            return 'El numero de telefono es de 10 digitos';
          }
        },
        onSaved: (valor){
          num2 = valor;
        }
        ), 
    );
  }


  Widget _agregandoNumero1(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      //child: Text('aqui va a ir el numero'),
      child: TextFormField(
        //controller: controladorNum1,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        keyboardType: TextInputType.numberWithOptions(decimal: false),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: 'Escriba el numero de telefono',  
          //hintStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        validator: (valor){
          if(valor.length > 9){
            return null;
          }else{
            return 'El numero de telefono es de 10 digitos';
          }
        }, 
        onSaved: (valor){
          num1= valor;
        }
        ), 
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
      margin: EdgeInsets.symmetric(horizontal: 103.0, vertical: 90.0),
      child: Text('==Venta Unefon==', style: GoogleFonts.benchNine(
        color: Colors.white,
        fontSize: 30.0,
        fontWeight: FontWeight.bold
      ))
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
          top: tamPantalla.height*1-100.0,
          child: piePagina
        )
      ],
    );
  }
}