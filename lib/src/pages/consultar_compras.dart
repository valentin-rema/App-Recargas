import 'package:flutter/material.dart';
import 'package:recargas/models/comprarSaldoModel.dart';
import 'package:recargas/providers/recargas_provider.dart';


class ConsultarCompras extends StatelessWidget {

  final obtenerCompras = new RecargaProvider();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar compras'),
      ),
      body: _mostrarCompras(context)
    );
  }

  Widget _mostrarCompras(BuildContext context){
    return FutureBuilder(
      future: obtenerCompras.obtenerSaldos(),
      builder: (BuildContext context, AsyncSnapshot<List<ComprarSaldoModel>> snapshot){
        if(snapshot.hasData){
          return _comprando(context, snapshot.data);
        }else{
          return Center(
            child: CircularProgressIndicator()
          );
        }
      }
    );
  }

Widget _comprando(BuildContext context, List<ComprarSaldoModel> compras){

  final tamPantalla = MediaQuery.of(context).size;


  int tamLista = compras.length;

  if(tamLista == 1){
    return Container();
  }
  else{
    compras.removeAt(0);
    return ListView.builder(
    itemCount: compras.length,
    itemBuilder: (context, index){
      return Container(
        margin: EdgeInsets.all(10.0),
        width: tamPantalla.width*.9,
        height: 90.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
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
          leading: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                Icon(Icons.arrow_forward_ios, size: 40.0)
              ],
            )
          ),
          title: Text('Compra', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0)),
          subtitle: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.attach_money, size: 20.0, color: Colors.black54),
                    Text('${compras[index].cantidad}', style: TextStyle(color: Colors.black54, fontSize: 18.0))
                  ],
                  //
                )
              ),
              SizedBox(height: 5.0,),
              Text('${compras[index].fecha}', style: TextStyle(color: Colors.black54, fontSize: 13.5)),
            ],
          ),
          trailing: Container(
              width: 80.0,
              height: 80.0,
              //color: Colors.orange,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.orangeAccent
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 18.0),
                  Text('Exitosa', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                ],
              )
            ),
          )
      );     
    }
    );

  }

}


}