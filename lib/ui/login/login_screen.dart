import 'dart:math';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pruebaTest/generated/l10n.dart';

import 'package:pruebaTest/routes/assets_routes.dart';
import 'package:pruebaTest/styles/colors.dart';
import 'package:pruebaTest/styles/style.dart';
import 'package:pruebaTest/utils/adapt_screen.dart';
import 'package:pruebaTest/utils/alert.dart';
import 'package:pruebaTest/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

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
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.0), // here the desired height
            child: AppBar(
              backgroundColor: Colors.white,
              title: Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                child: Center(
                  child: Image(
                    image: AssetImage(AssetsRoutes.loginIcon),
                    height: 120.0,
                    width: 250,
                  ),
                ),
              ),
            )),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Container(
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
                          style: AppStyle().styleText(20, Colors.grey, false)),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppLocalizations.of(context).requiredfield;
                              }
                              return null;
                            },
                            controller: _ediUser,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
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
                      _submitButtom(context),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Text("Envíos encontrados" + "(4)", style: AppStyle().styleText(20, Colors.grey, false)),
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
                                AlertWidget().alertInfo(context, title: "", description: "", color: Colors.red);
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
                      ListView.builder(
                          //scrollDirection: Axis.vertical,
                          key: UniqueKey(),
                          itemCount: 2,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext ctxt, int Index) {
                            return Slidable(
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
                                    SlidableAction(
                                      onPressed: doNothing,
                                      backgroundColor: Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                    SlidableAction(
                                      onPressed: doNothing,
                                      backgroundColor: Color(0xFF21B7CA),
                                      foregroundColor: Colors.white,
                                      icon: Icons.share,
                                      label: 'Share',
                                    ),
                                  ],
                                ),

                                // The end action pane is the one at the right or the bottom side.
                                endActionPane: ActionPane(
                                  motion: ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      // An action can be bigger than the others.
                                      flex: 2,
                                      onPressed: doNothing,
                                      backgroundColor: Color(0xFF7BC043),
                                      foregroundColor: Colors.white,
                                      icon: Icons.archive,
                                      label: 'Archive',
                                    ),
                                    SlidableAction(
                                      onPressed: doNothing,
                                      backgroundColor: Color(0xFF0392CF),
                                      foregroundColor: Colors.white,
                                      icon: Icons.save,
                                      label: 'Save',
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
                                        Container(
                                          margin: EdgeInsets.only(top: 5.sp),
                                          width: 60.sp,
                                          height: 60.sp,
                                          child: Icon(
                                            Icons.abc,
                                            size: 20.sp,
                                            color: Colors.white,
                                          ),
                                          color: AppColors.mainColor,
                                        ),
                                        SizedBox(
                                          width: 10.sp,
                                        ),
                                        Container(
                                            child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Guía de rastreo", style: AppStyle().styleText(20, Colors.black, false)),
                                            SizedBox(
                                              height: 5.sp,
                                            ),
                                            Text("018600684", style: AppStyle().styleText(30, Colors.black, false)),
                                          ],
                                        )),
                                        Text("012332", style: AppStyle().styleText(20, Colors.black, false)),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 2.sp,
                                    ),
                                    Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.only(top: 5.sp, bottom: 5.sp),
                                        color: Colors.grey.withOpacity(0.2),
                                        child: Text("012332", style: AppStyle().styleText(20, Colors.black, false))),
                                    SizedBox(
                                      height: 2.sp,
                                    ),
                                  ],
                                ));
                          }),
                    ],
                  ),
                )),
          ]),
        ));
  }

  void doNothing(BuildContext context) {}

  Widget _submitButtom(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, 'result');
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
}
