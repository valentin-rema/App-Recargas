import 'dart:convert';

SaldoModel saldoModelFromJson(String str) => SaldoModel.fromJson(json.decode(str));

String saldoModelToJson(SaldoModel data) => json.encode(data.toJson());

class SaldoModel {
    SaldoModel({
        this.cantidad,
    });

    double cantidad;

    factory SaldoModel.fromJson(Map<String, dynamic> json) => SaldoModel(
        cantidad: json["cantidad"],
    );

    Map<String, dynamic> toJson() => {
        "cantidad": cantidad,
    };
}
