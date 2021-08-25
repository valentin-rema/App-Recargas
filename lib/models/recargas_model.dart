import 'dart:convert';

RecargasModel recargasModelFromJson(String str) => RecargasModel.fromJson(json.decode(str));

String recargasModelToJson(RecargasModel data) => json.encode(data.toJson());

class RecargasModel {
    
    //variables que utiliza la clase
    String compania;
    double cantidad;
    String telefono;
    String fecha;
    
    RecargasModel({
        this.compania,
        this.cantidad,
        this.telefono,
        this.fecha,
    });

    factory RecargasModel.fromJson(Map<String, dynamic> json) => RecargasModel(
        compania: json["compania"],
        cantidad: json["cantidad"],
        telefono: json["telefono"],
        fecha:    json["fecha"],
    );

    Map<String, dynamic> toJson() => {
        "compania" : compania,
        "cantidad" : cantidad,
        "telefono" : telefono,
        "fecha"    : fecha
    };
}
