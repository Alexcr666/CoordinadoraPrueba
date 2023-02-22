import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:pruebaTest/data/models/GeSendModel.dart';

import 'package:pruebaTest/data/models/InfoProductModel.dart';

import 'package:pruebaTest/data/networking/api.dart';
import 'package:pruebaTest/generated/l10n.dart';

import 'package:pruebaTest/app/app_constants.dart';
import 'package:pruebaTest/redux2/app/app_state.dart';
import 'package:pruebaTest/redux2/settingApp/settingsHomeActions.dart';
import 'package:pruebaTest/redux2/settingApp/settingsHomeState.dart';
import 'package:pruebaTest/redux2/settingApp/store.dart';
import 'package:pruebaTest/redux2/store.dart';
import 'package:pruebaTest/routes/assets_routes.dart';
import 'package:pruebaTest/sharedPreferences/shared.dart';

import 'package:pruebaTest/styles/colors.dart';
import 'package:pruebaTest/styles/style.dart';
import 'package:pruebaTest/ui/main/mapsScreen.dart';

import 'package:pruebaTest/utils/adapt_screen.dart';
import 'package:pruebaTest/utils/alert.dart';
import 'package:pruebaTest/widget/card/cardInicio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:pruebaTest/widget/widget.dart';
import 'package:redux/redux.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:sign_in_with_apple/sign_in_with_apple.dart';
//import 'package:google_sign_in/google_sign_in.dart';

import 'dart:convert';
import 'dart:math';

import 'dart:math';
import 'dart:ui';

import '../../styles/colors.dart';

class infoProductPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  infoProductPage({Key key, this.listSend}) : super(key: key);
  Guia listSend;
  //ResultInfoProduct data;

  @override
  _infoProductState createState() => _infoProductState();
}

var _store;
Widget item({String name, String value}) {
  return Container(
      margin: EdgeInsets.only(top: 5.sp),
      child: Row(
        children: [
          Text(name, style: AppStyle().styleText(12.sp, Colors.black, false, bold2: false)),
          SizedBox(
            width: 10,
          ),
          Text(value, style: AppStyle().styleText(12.sp, Colors.black, false, bold2: false)),
          Expanded(child: SizedBox()),
        ],
      ));
}

List<bool> open = [];

class _infoProductState extends State<infoProductPage> {
  @override
  Widget build(BuildContext context) {
    AdaptScreen.initAdapt(context);
    //open = [];

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppWidget().appbar(true, context),
        body: StoreProvider<AppStateHome>(
            //ReduxSignUp.store,
            store: ReduxHome.store,
            child: StoreConnector<AppStateHome, dynamic>(
                //distinct: false,
                converter: (store) => store.state.postsState,
                onInit: (store) {
                  _store = store;
                },
                builder: (context, value) {
                  return Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: Text(
                            widget.listSend.guia.toString(),
                            style: AppStyle().styleText(23.sp, AppColors.main2Color, false, bold2: true),
                            textAlign: TextAlign.center,
                          )),
                          /*  Text(" widget.data.title.toString()", style: AppStyle().styleText(18, AppColors.main2Color, false, bold2: false)),
                          Image.network(
                            "widget.data.thumbnail.toString()",
                            height: 400,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),*/

                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Container(
                              child: Row(
                            children: [
                              SizedBox(
                                width: 70.sp,
                              ),
                              Flexible(
                                  child: Container(
                                height: 50,
                                width: 200.sp,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Icon(
                                        AppWidget().getIconSend(widget.listSend.estadoGuia),
                                        size: 23.sp,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10.sp,
                                      ),
                                      Text(
                                        widget.listSend.estadoGuia.toString(),
                                        style: AppStyle().styleText(16, Colors.white, false, bold2: true),
                                      ),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0, //Defines Elevation
                                    primary: AppWidget().getColorSend(widget.listSend.estadoGuia),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              )),
                              // Expanded(child: SizedBox()),
                            ],
                          )),
                          SizedBox(
                            height: 15.sp,
                          ),
                          Text(
                            "Información del destinatario: ",
                            style: AppStyle().styleText(14.sp, AppColors.main2Color, false, bold2: true),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          item(name: "Nombre", value: widget.listSend.destinatario.nombre.toString()),
                          item(name: "Teléfono", value: widget.listSend.destinatario.telefono.toString()),
                          item(name: "Dirección", value: widget.listSend.destinatario.zonificacion.direccion.toString()),
                          item(name: "Ciudad", value: widget.listSend.destinatario.zonificacion.ciudad.toString()),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(child: SizedBox()),
                              Text("Unidades(" + widget.listSend.unidades.length.toString() + ")",
                                  style: AppStyle().styleText(19, Colors.black, false, bold2: false)),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.listSend.unidades.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                Unidade unidades = widget.listSend.unidades[index];

                                //  Attribute data = widget.data.attributes[index];

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          open[index] = !open[index];
                                          Timer.run(() {
                                            setState(() {});
                                          });
                                        },
                                        child: Container(
                                            color: Colors.grey.withOpacity(0.3),
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(top: 20, left: 20),
                                                  height: 50,
                                                  child: Text(unidades.etiqueta1D.toString(),
                                                      style: AppStyle().styleText(12.sp, Colors.black, false, bold2: false)),
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(right: 20),
                                                    child: Icon(
                                                      open[index] != true ? Icons.arrow_upward : Icons.arrow_downward_outlined,
                                                      size: 20.sp,
                                                    )),
                                              ],
                                            ))),

                                    /*Expanded(
                                      child: Container(
                                    height: 50,
                                    color: Colors.grey.withOpacity(0.2),
                                    child: Center(
                                        child: Text("data.valueName.toString()",
                                            style: AppStyle().styleText(12, Colors.black, false, bold2: false))),
                                  )),*/
                                    open[index] == true
                                        ? SizedBox()
                                        : Column(
                                            children: [
                                              Container(
                                                  color: Colors.grey.withOpacity(0.3),
                                                  width: double.infinity,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 10.sp,
                                                      ),
                                                      Container(
                                                        height: 50,
                                                        child: Center(
                                                            child: Text("Etiqueta 1D: " + unidades.etiqueta1D.toString(),
                                                                style: AppStyle().styleText(12.sp, Colors.black, false, bold2: false))),
                                                      ),
                                                      SizedBox(
                                                        width: 10.sp,
                                                      ),
                                                    ],
                                                  )),
                                              Container(
                                                  color: Colors.grey.withOpacity(0.3),
                                                  width: double.infinity,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 10.sp,
                                                      ),
                                                      Flexible(
                                                          child: Container(
                                                        height: 50,
                                                        child: Center(
                                                            child: Text("Etiqueta 2D: " + unidades.etiqueta2D.toString(),
                                                                style: AppStyle().styleText(12.sp, Colors.black, false, bold2: false))),
                                                      )),
                                                      SizedBox(
                                                        width: 10.sp,
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          )
                                  ],
                                );
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          AppWidget().submitButtomRounded(
                              context: context,
                              colorBackground: AppColors.mainColor,
                              text: "Abrir mapa de ubicación",
                              tap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => mapResumePage(
                                            list: widget.listSend.ubicacionGuia,
                                          )),
                                );
                              })
                        ],
                      )));
                })));
  }

  Widget _decorationBox() {
    return Transform.rotate(
        angle: -pi / 5.0,
        child: Container(
          height: 360.0,
          width: 360.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80.0),
              gradient: LinearGradient(colors: [
                AppColors.mainColor,
                AppColors.main2Color,
              ])),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < widget.listSend.unidades.length; i++) {
      open.add(false);
    }

    //refreshList();
  }
}

class RefreshItemsAction {
  final Completer<Null> completer;

  RefreshItemsAction({Completer completer}) : this.completer = completer ?? Completer<Null>();
}
