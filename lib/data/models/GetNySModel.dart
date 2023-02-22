// To parse this JSON data, do
//
//     final getNysModel = getNysModelFromJson(jsonString);

import 'dart:convert';

GetNysModel getNysModelFromJson(String str) => GetNysModel.fromJson(json.decode(str));

String getNysModelToJson(GetNysModel data) => json.encode(data.toJson());

class GetNysModel {
  GetNysModel({
    this.cliente,
    this.fechaReporte,
    this.fechaSolucion,
    this.guia,
    this.novedad,
    this.solucion,
  });

  String cliente;
  String fechaReporte;
  String fechaSolucion;
  String guia;
  String novedad;
  String solucion;

  factory GetNysModel.fromJson(Map<String, dynamic> json) => GetNysModel(
        cliente: json["cliente"],
        fechaReporte: json["fecha_reporte"],
        fechaSolucion: json["fecha_solucion"],
        guia: json["guia"],
        novedad: json["novedad"],
        solucion: json["solucion"],
      );

  Map<String, dynamic> toJson() => {
        "cliente": cliente,
        "fecha_reporte": fechaReporte,
        "fecha_solucion": fechaSolucion,
        "guia": guia,
        "novedad": novedad,
        "solucion": solucion,
      };
}
