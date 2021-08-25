import 'dart:convert';

ComprarSaldoModel comprarSaldoModelFromJson(String str) => ComprarSaldoModel.fromJson(json.decode(str));

String comprarSaldoModelToJson(ComprarSaldoModel data) => json.encode(data.toJson());

class ComprarSaldoModel {
    ComprarSaldoModel({
        this.cantidad,
        this.fecha,
    });

    double cantidad;
    String fecha;

    factory ComprarSaldoModel.fromJson(Map<String, dynamic> json) => ComprarSaldoModel(
        cantidad: json["cantidad"],
        fecha: json["fecha"],
    );

    Map<String, dynamic> toJson() => {
        "cantidad": cantidad,
        "fecha": fecha,
    };
}
