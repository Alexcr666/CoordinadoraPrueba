import 'package:flushbar/flushbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pruebaTest/data/models/GeSendModel.dart';
import 'package:pruebaTest/data/networking/api.dart';
import 'package:pruebaTest/generated/l10n.dart';
import 'package:pruebaTest/styles/colors.dart';
import 'package:pruebaTest/styles/style.dart';
import 'package:pruebaTest/widget/widget.dart';
import 'package:sizer/sizer.dart';
import 'package:sizer/sizer.dart';
import 'package:pruebaTest/redux2/app/app_state.dart';
import 'package:pruebaTest/redux2/settingApp/settingsHomeActions.dart';
import 'package:pruebaTest/redux2/settingApp/settingsHomeState.dart';
import 'package:pruebaTest/redux2/settingApp/store.dart';
import 'package:pruebaTest/redux2/store.dart';
import 'package:redux/redux.dart';

class AlertWidget {
  alertInfo(var context, String client, Guia listSend, {String title, String description, Color color}) {
    TextEditingController _controllerMessage = TextEditingController();
    showDialog(
      barrierDismissible: false,
      context: context,
      useRootNavigator: false,
      builder: (BuildContext contextAlert) {
        return AlertDialog(
            insetPadding: EdgeInsets.all(1),
            contentPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
                width: MediaQuery.of(context).size.width - 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10.sp,
                            ),
                            Icon(
                              Icons.info,
                              size: 30.sp,
                              color: Colors.white,
                            ),
                            Expanded(child: SizedBox()),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Guia de rastreo",
                                  style: AppStyle().styleText(13.sp, Colors.white, false, bold2: true),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 5.sp,
                                ),
                                Text(
                                  listSend.guia.toString(),
                                  style: AppStyle().styleText(18.sp, Colors.white, false, bold2: true),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 10.sp,
                            ),
                          ],
                        )),
                    Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.sp,
                            ),
                            Text(
                              "Fecha de reporte: " + DateFormat('yyyy/MM/dd hh:mm').format(listSend.fechaNovedad),
                              style: AppStyle().styleText(13.sp, Colors.black, false, bold2: false),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "Fecha de solución: " + DateFormat('yyyy/MM/dd hh:mm').format(DateTime.now()),
                              style: AppStyle().styleText(13.sp, Colors.black, false, bold2: false),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[100]))),
                              child: TextFormField(
                                  controller: _controllerMessage,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1, //Normal textInputField will be displayed
                                  maxLines: 5,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context).requiredfield;
                                    }
                                    return null;
                                  },
                                  //  controller: _ediUser,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100.0),
                                    ),
                                    filled: true,
                                    hintStyle: TextStyle(color: Colors.grey[800]),
                                    hintText: "Ingresar solución",
                                  )),
                            ),
                            AppWidget().submitButtomRounded(
                                context: context,
                                colorBackground: AppColors.mainColor,
                                text: "Reportar solución",
                                tap: () {
                                  asinc() async {
                                    Store<AppState> store = await createStore(api: API());
                                    String dateFormat = DateFormat('yyyy-MM-dd').format(DateTime.now());
                                    store.dispatch(getSendNySAction(context,
                                        message: _controllerMessage.text,
                                        messageSolutions: _controllerMessage.text,
                                        dateReport: dateFormat,
                                        dateExecute: dateFormat,
                                        guia: listSend.guia,
                                        cliente: client));
                                  }

                                  asinc();
                                  Navigator.pop(contextAlert);
                                }),
                            SizedBox(
                              height: 10.sp,
                            ),
                          ],
                        )),
                  ],
                )));
      },
    );
  }

  Future TwoAlert(BuildContext context, String description, {String title, Function tap1, Function tap2, bool back, Color color}) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      useRootNavigator: false,
      builder: (BuildContext contextAlert) {
        return AlertDialog(
            insetPadding: EdgeInsets.all(10),
            contentPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    // color: AppColors.mainColor,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                      color: color,
                      /* boxShadow: [
      BoxShadow(color: Colors.green, spreadRadius: 3),
    ],*/
                    ),
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          title.toString(),
                          style: AppStyle().styleText(16, Colors.white, false, bold2: false),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.info_outline_rounded,
                      color: color,
                      size: 60,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      description.toString(),
                      style: AppStyle().styleText(16, Colors.black, false, bold2: false),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10.sp,
                    ),
                    /*  Flexible(
                        child: AppWidget().submitButtomRounded(
                            context: context,
                            text: "Si",
                            colorBackground: Colors.grey,
                            tap: () {
                              tap1();
                            })),*/
                    SizedBox(
                      width: 5.sp,
                    ),
                    /*  Flexible(
                        child: AppWidget().submitButtomRounded(
                            context: context,
                            text: "No",
                            colorBackground: color,
                            tap: () {
                              tap2();
                            })),*/
                    SizedBox(
                      width: 10.sp,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.sp,
                ),
              ],
            )));
      },
    );
  }

  message(BuildContext context, String message) {
    Flushbar(
      //title:  "",
      message: message.toString(),
      duration: Duration(seconds: 3),
    )..show(context);
  }

  DateTime now = DateTime.now();
}
