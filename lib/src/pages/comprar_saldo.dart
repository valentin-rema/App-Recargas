import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:recargas/models/comprarSaldoModel.dart';
import 'package:recargas/providers/recargas_provider.dart';
import 'package:recargas/utils/utils.dart' as utils;

//vamos a agregar la variable que maneja los estados de un formulario para que tengamos el control de 
//sus accciones


//hemos terminado con la parte de comprar saldo ahora lo que nos queda es darle unos retoques como 
//por ejemplo la parte donde se muestran los alerts de cuando la compra de saldo fue exitosa y la parte
//donde esta cargando el servicio 

class ComprarSaldo extends StatelessWidget {


  final keyForm = new GlobalKey<FormState>(); //llave del form 

  final comprarSaldoProvider = new RecargaProvider();


  final comprarSaldoModel = new ComprarSaldoModel();

  bool comprando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comprar Saldo'), 
      ),
      body: Stack(
        children: <Widget>[
          _imagenComprar(context),
          Positioned(
            top: 180.0,
            child: _areaTrabajo(context)
          ),
          _piePagina(context),
        ],
      ),
    );
  }

  Widget _areaTrabajo(BuildContext context){
    final tamPantalla = MediaQuery.of(context).size;

    return Container(
      //padding: EdgeInsets.only(top: 200.0, left: 100.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0), 
      width: tamPantalla.width*.9,
      height: tamPantalla.height*.45,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 3.0,
            color: Colors.black, 
            offset: Offset(1.5, 3.0),
            spreadRadius: 3
          )
        ]
      ),
      child: Form(
        key: keyForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 10.0),
            Text('T-MAR', style: GoogleFonts.grenze(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              fontSize: 40.0
            )),
            SizedBox(height: 30.0),
            _ingresandoCantidad(context),
            //SizedBox(height: 20.0,),}
            SizedBox(height: 50.0),
            _agregandoBoton(context),
            //_botonComprar()
          ],
        ),
      ) 
      );
  }

  Widget _agregandoBoton(BuildContext context){
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.blueAccent
      ),
      child: FlatButton(
        onPressed: (){
          _comprandoSaldo(context);
        }, 
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          child: Text('Comprar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white))
          )
        )
    );
  }


  _comprandoSaldo(BuildContext context) async {
    //esta primera condicional va a servir para ver si la cantida que se ingreso fue valida
    if(!keyForm.currentState.validate()){
      return;
    }

    //se han guardado los cambios una vez hecha la validacion()
    keyForm.currentState.save();

    //ahora lo que vamos a hacer es guardar en la variale fecha la fecha en la cual se hizo la recarga

    final fecha = new DateTime.now();
    final formatoFecha = new DateFormat('yyyy-MM-dd');
    String fechaString = formatoFecha.format(fecha);

    String horaString = DateFormat('jms').format(fecha);


    //en esta variable se guarda de forma correcta la fecha en la cual se hizo la compra del saldo
    String fechadefinitiva = '$fechaString  $horaString';

    comprarSaldoModel.fecha = fechadefinitiva;

    while(!comprando){
      print('vemos si al menos entra una vez');
      //ya que se ingreso al menos una vez vamos a simular que se esta haciendo la operacion
      showDialog(
        context: context,
        builder: (context){
          return Center(
              child: Container(
                width: 70.0,
                height: 70.0,
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.all(15.0),
                  child: CircularProgressIndicator()
                )
              )
            );
        }
      );

      //ahora si vamos a meter los datos de nuestra primera compra de saldo
      //hacemos a fuerza un sleep de dos segundos
      await Future.delayed(
        Duration(seconds: 2)
      );
      

      //hasta aqui la variable comprando pasa de falso a verdadero indicando que la compra se hizo de 
      //manera satisfactoria
      comprando = await comprarSaldoProvider.agregarCompraSaldo(comprarSaldoModel); 


      //ahora lo que vamos a hacer es mandar la cantidad que se compro y con eso hacer un cambio en 
      //saldo a favor ya que se hizo la compra

      await comprarSaldoProvider.cambiandoSaldo(comprarSaldoModel.cantidad, '+'); 
    }

    //una ves que termine el while ahora lo que vamos a hacer es poner un alert dialog diciendo que la 
    //compra del saldo se hizo con exito 

    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Operacion'),
          content: Text('Compra Exitosa'),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                //primero vamos a quitar el alert dialog de la pila 
                Navigator.pop(context);
                //ahora vamos a quitar de la pila la pagina de comprar saldo
                Navigator.pop(context);
                //vamos a vaciar la pila y dejamos como raiz la pagina del home
                Navigator.pushNamedAndRemoveUntil(context, 'home', (r)=> false);
              },
              child: Text('OK')
            )
          ],
        );
      }
    );
    //ahora vamos a mandar los datos de la compra de saldo a nuestra base de datos de firebase
  }


  Widget _ingresandoCantidad(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: 'ingrese la cantidad a comprar' ,
          hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)
        ),
        validator: (valor){
          if(utils.isNumeric(valor)){
            return null;
          }
          else{
            return 'Cantidad no valida';
          }
        },
        onSaved: (valor2){
          //se va a guardar la cantidad correcta una vez antes hecho la validacion
          comprarSaldoModel.cantidad = double.parse(valor2)*1.06;
          print(comprarSaldoModel.cantidad);
        }
      ),
    );
  }


  Widget _imagenComprar(BuildContext context){
    final tamPantalla = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0 ),
      width: tamPantalla.width*1,
      height: tamPantalla.height*.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: Image(image: AssetImage('assets/img/comprar_saldo.png'), fit: BoxFit.cover)
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
          top: tamPantalla.height*1-182.0,
          child: piePagina
        )
      ],
    ); 
  }

}