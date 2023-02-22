import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pruebaTest/data/models/GeSendModel.dart';
import 'package:pruebaTest/routes/assets_routes.dart';
import 'package:pruebaTest/styles/style.dart';
import 'package:sizer/sizer.dart';

import '../generated/l10n.dart';
import '../styles/colors.dart';
import '../utils/adapt_screen.dart';

class AppWidget {
  getIconSend(String state) {
    var icon;
    switch (state.toLowerCase()) {
      case "en terminal destino":
        icon = Icons.door_back_door;
        break;
      case "en nys":
        icon = Icons.info;
        break;
      case "en reparto":
        icon = Icons.car_rental;
        break;
      case "entregada":
        icon = Icons.check;
        break;
    }
    return icon;
  }

  Color getColorSend(String state) {
    Color color = Colors.amber;

    switch (state.toLowerCase()) {
      case "en terminal destino":
        color = AppColors.terminal;

        break;
      case "en nys":
        color = AppColors.nys;

        break;
      case "en reparto":
        color = AppColors.mainColor;

        break;
      case "entregada":
        color = AppColors.received;

        break;
    }
    return color;
  }

  Widget track(Guia listSend) {
    Color color = getColorSend(listSend.estadoGuia);
    var icon = getIconSend(listSend.estadoGuia);

    return Container(
      margin: EdgeInsets.only(top: 5.sp),
      width: 70.sp,
      height: 70.sp,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          SizedBox(
            height: 5.sp,
          ),
          Text(listSend.estadoGuia.toString(), style: AppStyle().styleText(10.sp, Colors.white, true)),
          SizedBox(
            height: 5.sp,
          ),
          Icon(
            icon,
            size: 30.sp,
            color: Colors.white,
          ),
        ],
      ),
      color: color,
    );
  }

  Widget appbar(bool back, BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(90.0), // here the desired height
        child: AppBar(
          leading: back != true
              ? SizedBox()
              : GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: Colors.black,
                  )),
          backgroundColor: Colors.white,
          title: Container(
            margin: EdgeInsets.only(top: 5, right: 50),
            child: Center(
              child: Image(
                image: AssetImage(AssetsRoutes.loginIcon),
                height: 120.0,
                width: 250,
              ),
            ),
          ),
        ));
  }

  Widget noResult() {
    return Text("No hay resultados", style: AppStyle().styleText(20, Colors.grey, false));
  }

  Widget widgetImage(String urlFoto, double width, double heigth) {
    return Container(
      width: width,
      height: heigth,
      child:
          /*Image.memory(
      base64Decode(urlFoto),
      height: heigth,
      width: width,
    ),*/
          FadeInImage(
        placeholder: NetworkImage('https://thumbs.dreamstime.com/b/fondo-gris-132209705.jpg'),
        image: NetworkImage(urlFoto),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget widgetAppbar(BuildContext context, String title) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.mainColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
      centerTitle: true,
    );
  }

  Widget submitButtomRounded({BuildContext context, Color colorBackground, String text, Function tap}) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          tap();
        },
        child: Text(
          text.toString(),
          style: AppStyle().styleText(16, Colors.white, false, bold2: true),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0, //Defines Elevation
          primary: colorBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
