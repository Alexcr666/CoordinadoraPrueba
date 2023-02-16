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
import 'package:redux/redux.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';
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
  infoProductPage({Key key,this.data}) : super(key: key);

  ResultInfoProduct data;

  @override
  _infoProductState createState() => _infoProductState();
}

var _store;
class _infoProductState extends State<infoProductPage> {


 
  @override
  Widget build(BuildContext context) {
    AdaptScreen.initAdapt(context);
   

    return



      Scaffold(
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
              
                        
                     
                 return 
                 
                Container(margin: EdgeInsets.only(left: 20,right: 20),child: SingleChildScrollView(child:
                 Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                   SizedBox(height: 20,),
                   Text(
                          widget.data.title.toString(),
                          style: AppStyle().styleText(18,  AppColors.main2Color, false,bold2: false)),
                   Image.network(widget.data.thumbnail.toString(),height:400,width: double.infinity,fit: BoxFit.cover,)
,

Row(children: [
  Icon(Icons.attach_money_sharp,size: 45, color: AppColors.main2Color,),

 Text(
                     NumberFormat("#,##0", "en_US").format(     double.parse(widget.data.price.toString())),
                          style: AppStyle().styleText(40,  AppColors.main2Color, false,bold2: false)),
],),


   SizedBox(height: 20,),
Container(child:Row(children: [


  Expanded(child:Container(height: 50,child:ElevatedButton(
          onPressed: () {
            _launchURL() async {
  String url = widget.data.permalink.toString();
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
_launchURL();
            
          },
       
          child: Text('Preguntar',style:  AppStyle().styleText(16, Colors.white, false,bold2:true),),
          
           style: ElevatedButton.styleFrom(
                elevation: 0, 
               primary: AppColors.raisedButtonColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5), 
      
      
 
    ),
  ),
         
               
        ),
      )),
      SizedBox(width: 10,),
      Expanded(child:Container(height: 50,child:ElevatedButton(
          onPressed: ()  {
_launchURL() async {
  String url = widget.data.permalink.toString();
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
_launchURL();
           
          },
          
       
          child: Text('Llamar',style:  AppStyle().styleText(16, Colors.white, false,bold2:true),),
          
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
],)),
   SizedBox(height: 20,),




Row(children: [
 
Expanded(child: SizedBox()),
 Text(
                    "¿Tuviste un problema con la publicación?",
                          style: AppStyle().styleText(14,  Colors.grey, false,bold2: false)),

SizedBox(width: 10,),
 Text(
                    "Avisanos",
                          style: AppStyle().styleText(14,  AppColors.raisedButtonColor, false,bold2: false)),
                          Expanded(child: SizedBox()),
],),
   SizedBox(height: 20,),
Row(children: [
 
  Expanded(child: SizedBox()),
Icon( Icons.favorite_border_outlined,color: AppColors.raisedButtonColor,size: 25,),
SizedBox(width: 10,),
 Text(
                    "Agregar a favoritos",
                          style: AppStyle().styleText(14,  AppColors.raisedButtonColor, false,bold2: false)),

                        SizedBox(width: 40,),
                          Icon( Icons.share_outlined,color: AppColors.raisedButtonColor,size: 25,),
SizedBox(width: 10,),
 Text(
                    "Compartir",
                          style: AppStyle().styleText(14,  AppColors.raisedButtonColor, false,bold2: false)),

  Expanded(child: SizedBox()),
],),
SizedBox(height: 20,),
 Text(
                    "Características principales",
                          style: AppStyle().styleText(19, Colors.black, false,bold2: false)),
                             SizedBox(height: 20,),
ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:  widget.data.attributes.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                Attribute data = widget.data.attributes[index];

return Row(children: [
  Expanded(child:Container(height: 50,color: Colors.grey.withOpacity(0.3),child: 
   Center(child: Text(
                   data.name.toString().replaceAll("Name.", ""),
                          style: AppStyle().styleText(12, Colors.black, false,bold2: true))),
  )),

  Expanded(child:Container(height: 50,color: Colors.grey.withOpacity(0.2),child: 
   Center(child:Text(
                    data.valueName.toString(),
                          style: AppStyle().styleText(12, Colors.black, false,bold2: false))),
  )),



]);

                              }),


SizedBox(height: 20,),
 Text(
                    "Descripción",
                          style: AppStyle().styleText(19, Colors.black, false,bold2: false)),

                          SizedBox(height: 10,),
 Text(
                   widget.data.permalink.toString(),
                          style: AppStyle().styleText(14, Colors.black, false,bold2: false)),
SizedBox(height: 20,),
 Text(
                    "Información del vendedor",
                          style: AppStyle().styleText(19, Colors.black, false,bold2: false)),


SizedBox(height: 20,),
 Text(
                    "Para evitar que otras personas tomen control de tu cuenta (o estar preparado para cuando te olvidás la clave), Mercado Libre tiene una serie operaciones para verificar que la cuenta a la que estás ingresando, te pertenece.Como opciones de recuperación, el sitio da la posibilidad de enviar un código por mensaje de texto, WhatsApp o llamada telefónica. Para esto, por supuesto, es necesario haber brindado anteriormente estos datos.",
                          style: AppStyle().styleText(15, Colors.black, false,bold2: false)),
SizedBox(height: 20,),
                 ],))) ;  
       
  
              } )
      
      ));
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

  RefreshItemsAction({Completer completer})
      : this.completer = completer ?? Completer<Null>();
}
