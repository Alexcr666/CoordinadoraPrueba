import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:pruebaTest/data/models/GeSendModel.dart';
import 'package:pruebaTest/data/networking/api.dart';
import 'package:pruebaTest/generated/l10n.dart';

import 'package:pruebaTest/routes/assets_routes.dart';
import 'package:pruebaTest/sharedPreferences/shared.dart';
import 'package:pruebaTest/styles/colors.dart';
import 'package:pruebaTest/styles/style.dart';
import 'package:pruebaTest/ui/main/infoProductScreen.dart';
import 'package:pruebaTest/utils/adapt_screen.dart';
import 'package:pruebaTest/utils/alert.dart';
import 'package:pruebaTest/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pruebaTest/widget/widget.dart';
import 'package:sizer/sizer.dart';
import 'package:pruebaTest/redux2/app/app_state.dart';
import 'package:pruebaTest/redux2/settingApp/settingsHomeActions.dart';
import 'package:pruebaTest/redux2/settingApp/settingsHomeState.dart';
import 'package:pruebaTest/redux2/settingApp/store.dart';
import 'package:pruebaTest/redux2/store.dart';
import 'package:redux/redux.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  Utils utils = Utils();
  bool changePage = true;
  String email;
  String password;
  Widget _decorationBox() {
    return Transform.rotate(
        angle: -pi / 5.0,
        child: Container(
          height: 360.0,
          width: 370.0,
          child: Container(
            child: Transform.rotate(
              angle: 26,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Center(
                      child: Image(
                        image: AssetImage(AssetsRoutes.loginIcon),
                        height: 200.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80.0),
              gradient: LinearGradient(colors: [
                Colors.white,
                Colors.white,
              ])),
        ));
  }

  final _ediUser = TextEditingController();
  final _ediPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppWidget().appbar(false, context),
        body: StoreProvider<AppStateHome>(
          //ReduxSignUp.store,
          store: ReduxHome.store,
          child: StoreConnector<AppStateHome, dynamic>(
              //distinct: false,
              converter: (store) => store.state.postsState,
              onInit: (store) {
                // _store = store;
              },
              builder: (context, value) {
                return Container(
                    child: Column(children: <Widget>[
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Tracking de envio", style: AppStyle().styleText(20.sp, AppColors.mainColor, true)),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Escriba su número de cédula para buscar sus guias asociadas",
                                textAlign: TextAlign.center, style: AppStyle().styleText(12.sp, Colors.black, false)),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[100]))),
                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(15),
                                  ],
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context).requiredfield;
                                    }
                                    return null;
                                  },
                                  controller: _ediUser,
                                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                                  decoration: InputDecoration(
                                    suffixIcon: Container(
                                        margin: EdgeInsets.only(right: 10.sp),
                                        child: GestureDetector(
                                            onTap: () {
                                              asinc() async {
                                                Store<AppState> store = await createStore(api: API());

                                                store.dispatch(getSendAction(context, _ediUser.text));
                                              }

                                              asinc();
                                            },
                                            child: Icon(
                                              Icons.search,
                                              size: 30.sp,
                                              color: AppColors.mainColor,
                                            ))),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100.0),
                                    ),
                                    filled: true,
                                    hintStyle: TextStyle(color: Colors.grey[800]),
                                    hintText: "Ingrese su cédula",
                                  )),
                            ),

                            /*             Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text("Hello 1"),
            Text("Hello 2"),
          ],
      //  mainAxisAlignment:MainAxisAlignment.spaceBetween
        ),
      ],
    ),*/

                            SizedBox(
                              height: 20,
                            ),

                            SizedBox(
                              height: 5.sp,
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            //Text(ReduxHome.store.state.postsState.getSendModel.clientes["43984605"].guias.toString()),
                            Row(
                              children: [
                                Text(
                                    ReduxHome.store.state.postsState.listSend == null
                                        ? "Envíos encontrados (0)"
                                        : "Envíos encontrados (" + ReduxHome.store.state.postsState.listSend.length.toString() + ")",
                                    style: AppStyle().styleText(20, Colors.black, false)),
                                Expanded(child: SizedBox()),
                                Icon(
                                  Icons.filter_list,
                                  size: 20.sp,
                                ),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      //  AlertWidget().alertInfo(context, title: "", description: "", color: Colors.red);
                                    },
                                    child: Icon(
                                      Icons.filter_list,
                                      size: 20.sp,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 5.sp,
                            ),
                            ReduxHome.store.state.postsState.listSend == null
                                ? AppWidget().noResult()
                                : ListView.builder(
                                    //scrollDirection: Axis.vertical,
                                    key: UniqueKey(),
                                    itemCount: ReduxHome.store.state.postsState.listSend.length,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext ctxt, int Index) {
                                      Guia listSend = ReduxHome.store.state.postsState.listSend[Index];
                                      return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => infoProductPage(
                                                        listSend: listSend,
                                                      )),
                                            );
                                          },
                                          child: Slidable(
                                              // Specify a key if the Slidable is dismissible.
                                              key: const ValueKey(0),

                                              // The start action pane is the one at the left or the top side.
                                              startActionPane: ActionPane(
                                                // A motion is a widget used to control how the pane animates.
                                                motion: const ScrollMotion(),

                                                // A pane can dismiss the Slidable.
                                                dismissible: DismissiblePane(onDismissed: () {}),

                                                // All actions are defined in the children parameter.
                                                children: [
                                                  // A SlidableAction can have an icon and/or a label.
                                                ],
                                              ),

                                              // The end action pane is the one at the right or the bottom side.
                                              endActionPane: ActionPane(
                                                motion: ScrollMotion(),
                                                children: [
                                                  SlidableAction(
                                                    // An action can be bigger than the others.
                                                    flex: 1,
                                                    onPressed: (BuildContext context) {
                                                      AlertWidget().alertInfo(context, _ediUser.text, listSend);
                                                    },
                                                    backgroundColor: Colors.white,
                                                    foregroundColor: Colors.black,
                                                    icon: Icons.person_outline,
                                                    spacing: 0,

                                                    label: 'Revisar Problema',
                                                  ),
                                                ],
                                              ),

                                              // The child of the Slidable is what the user sees when the
                                              // component is not dragged.
                                              child: Column(
                                                children: [
                                                  Container(
                                                    color: Colors.grey.withOpacity(0.2),
                                                    child: Row(children: [
                                                      Column(
                                                        children: [
                                                          AppWidget().track(listSend),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 10.sp,
                                                      ),
                                                      Container(
                                                          child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                width: 80,
                                                              ),
                                                              Container(
                                                                  padding: EdgeInsets.all(6),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.grey.withOpacity(0.5),
                                                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20))),
                                                                  child: Text(
                                                                      DateFormat('yyyy/MM/dd hh:mm').format(listSend.fechaEnvio).toString(),
                                                                      style: AppStyle().styleText(13.sp, Colors.black, false))),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5.sp,
                                                          ),
                                                          Text("Guía de rastreo", style: AppStyle().styleText(20, Colors.black, false)),
                                                          SizedBox(
                                                            height: 5.sp,
                                                          ),
                                                          Text(listSend.guia.toString(),
                                                              style: AppStyle().styleText(30, Colors.black, false)),
                                                          SizedBox(
                                                            height: 5.sp,
                                                          ),
                                                          SizedBox(
                                                            height: 5.sp,
                                                          ),
                                                        ],
                                                      )),
                                                    ]),
                                                  ),
                                                  SizedBox(
                                                    height: 2.sp,
                                                  ),
                                                  Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.only(top: 5.sp, bottom: 5.sp),
                                                      color: Colors.grey.withOpacity(0.2),
                                                      child: Text("Destinatario : " + listSend.destinatario.nombre.toString(),
                                                          style: AppStyle().styleText(20, Colors.black, false))),
                                                  SizedBox(
                                                    height: 2.sp,
                                                  ),
                                                ],
                                              )));
                                    }),
                          ],
                        ),
                      )),
                ]));
              }),
        ));
  }

  Widget _submitButtom(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          //    Navigator.pushNamed(context, 'result');
          /* if (_formKey.currentState.validate()) {
            if (_ediPassword.text == "1234" && _ediUser.text == "admin") {
              Navigator.pushNamed(context, 'result');
            } else {
              AlertWidget().message(context, "Datos incorrectos");
            }
          }*/
        },
        child: Text(
          'Entrar',
          style: AppStyle().styleText(16, Colors.white, false, bold2: true),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0, //Defines Elevation
          primary: AppColors.raisedButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AppSharedPreference().getSend().then((value) {
      print("preference: " + value.toString());
      if (value != false) {
        GetSendModel data = getSendModelFromJson(value.toString());
        print("preference2: " + data.toJson().toString());
        ReduxHome.store.dispatch(
          SetPostsStateActionHome(PostsStateHome(getSendModel: data)),
        );
      }
    });
  }
}
