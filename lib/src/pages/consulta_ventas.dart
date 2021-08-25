import 'package:flutter/material.dart';
import 'package:recargas/models/recargas_model.dart';
import 'package:recargas/providers/recargas_provider.dart';




//vamos a continuar con el el proyecto de las recargas T-MAR, terminaremos el dia de hoy con la opcion
//de mostrar las recargas que se se han hecho desde este momento, ok vamos a comnezar

class ConsultaVentas extends StatelessWidget {


  final recargas = new RecargaProvider();

  //String signoPesos = '$';

  @override
  Widget build(BuildContext context) {

    //recargas.obtenerRecargas();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mostrar Recargas', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: _mostrarRecargas(context),
    );
  }

  Widget _mostrarRecargas(BuildContext context){
    //final tamPantalla = MediaQuery.of(context).size;
    return FutureBuilder(
        future: recargas.obtenerRecargas(),
        builder: (BuildContext context, AsyncSnapshot<List<RecargasModel>> snapshot){
          if(snapshot.hasData){
            return _listaRecargas(context, snapshot.data);
          }else{
            return Center(
              child: CircularProgressIndicator()
            );
          }
        }
      );
  }

  Widget _listaRecargas(BuildContext context, List<RecargasModel> recargas){

    int tamLista = recargas.length;

    if(tamLista == 1){
      return Container();
    }
    else{
      recargas.removeAt(0);
      return ListView.builder(
      itemCount: recargas.length,
      itemBuilder: (context, index) {
          return Container(
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            border: Border.all(color: Color.fromRGBO(196, 205, 203, 1.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 1.0,
                color: Colors.black38,
                offset: Offset(1.5, 2.0),
                spreadRadius: 1.5 
              )
            ]
          ),
          child: ListTile(
            
            //mostrando un icono al principio
            leading: Icon(Icons.attach_money, color: Colors.orange, size: 40.0),
            //colocando la compañia como titulo
            title: Container(
              margin: EdgeInsets.symmetric(vertical: 5.0),
              child: Text(recargas[index].compania, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0))
              ),
            //en el subtitulo ponermos una columna en donde va el telefono y mas abajo va la fecha
            subtitle: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(recargas[index].telefono, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
                SizedBox(height: 5.0),
                Text(recargas[index].fecha, style: TextStyle(fontSize: 13.0)),
              ]
            ),
            //ponemos la cantidad que se recargo en la parte de la derecha
            trailing: Column(
              children: <Widget>[
                Container(
                  width: 60.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text('Exitosa', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                SizedBox(height: 5.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.attach_money),
                    Text(recargas[index].cantidad.toString(), style: TextStyle(fontSize: 20.0)),
                  ],
                )
                
                ],
            ),
          )
        );
      } 
    );
    }
  }
}