import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

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
  infoProductPage({Key key}) : super(key: key);

  //ResultInfoProduct data;

  @override
  _infoProductState createState() => _infoProductState();
}

var _store;

class _infoProductState extends State<infoProductPage> {
  @override
  Widget build(BuildContext context) {
    AdaptScreen.initAdapt(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          //title: Text("Hello Appbar"),
          backgroundColor: AppColors.bgPrimaryColor,
          elevation: 0,
        ),
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
                            "32900490423",
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
                              Expanded(child: SizedBox()),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Container(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _launchURL() async {
                                      String url = "widget.data.permalink.toString()";
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    }

                                    _launchURL();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.car_crash,
                                        size: 23.sp,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10.sp,
                                      ),
                                      Text(
                                        'En Reparto',
                                        style: AppStyle().styleText(16, Colors.white, false, bold2: true),
                                      ),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0, //Defines Elevation
                                    primary: AppColors.raisedButtonColor,
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
                            "Información del destinatario",
                            style: AppStyle().styleText(14.sp, AppColors.main2Color, false, bold2: true),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(child: SizedBox()),
                              Text("Nombre: ", style: AppStyle().styleText(12.sp, Colors.black, false, bold2: false)),
                              SizedBox(
                                width: 10,
                              ),
                              Text("R/SENTACIONES CASTRO HNOS LTDA", style: AppStyle().styleText(12.sp, Colors.black, false, bold2: false)),
                              Expanded(child: SizedBox()),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(child: SizedBox()),
                              Text("Unidades(5)", style: AppStyle().styleText(19, Colors.black, false, bold2: false)),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 1,
                              itemBuilder: (BuildContext ctxt, int index) {
                                //  Attribute data = widget.data.attributes[index];

                                return Row(children: [
                                  Expanded(
                                      child: Container(
                                    height: 50,
                                    color: Colors.grey.withOpacity(0.3),
                                    child: Center(
                                        child: Text("  data.name.toString()".replaceAll("Name.", ""),
                                            style: AppStyle().styleText(12, Colors.black, false, bold2: true))),
                                  )),
                                  /*Expanded(
                                      child: Container(
                                    height: 50,
                                    color: Colors.grey.withOpacity(0.2),
                                    child: Center(
                                        child: Text("data.valueName.toString()",
                                            style: AppStyle().styleText(12, Colors.black, false, bold2: false))),
                                  )),*/
                                ]);
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          AppWidget().submitButtomRounded(
                              context: context, colorBackground: AppColors.mainColor, text: "Abrir mapa de ubicación", tap: () {})
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
    //refreshList();
  }
}

class RefreshItemsAction {
  final Completer<Null> completer;

  RefreshItemsAction({Completer completer}) : this.completer = completer ?? Completer<Null>();
}
