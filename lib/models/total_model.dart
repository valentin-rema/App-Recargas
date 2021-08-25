import 'dart:convert';

TotalModel totalModelFromJson(String str) => TotalModel.fromJson(json.decode(str));

String totalModelToJson(TotalModel data) => json.encode(data.toJson());

class TotalModel {
    TotalModel({
        this.cantidad,
    });

    double cantidad;

    factory TotalModel.fromJson(Map<String, dynamic> json) => TotalModel(
        cantidad: json["cantidad"],
    );

    Map<String, dynamic> toJson() => {
        "cantidad": cantidad,
    };
}
