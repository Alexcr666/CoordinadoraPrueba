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

//import 'package:sign_in_with_apple/sign_in_with_apple.dart';
//import 'package:google_sign_in/google_sign_in.dart';

import 'dart:convert';
import 'dart:math';

import 'dart:math';
import 'dart:ui';

import '../../styles/colors.dart';
class usersListPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  usersListPage({Key key}) : super(key: key);

  @override
  _usersListState createState() => _usersListState();
}

var _store;
class _usersListState extends State<usersListPage> {


 bool servicestatus = false;
  bool haspermission = false;
  LocationPermission permission;
   Position position;
       String long = "", lat = "";
  StreamSubscription<Position> positionStream;

  

  checkGps() async {
      servicestatus = await Geolocator.isLocationServiceEnabled();
      if(servicestatus){
            permission = await Geolocator.checkPermission();
          
            if (permission == LocationPermission.denied) {
                permission = await Geolocator.requestPermission();
                if (permission == LocationPermission.denied) {
                AlertWidget().message(context,'Denegado el permiso de ubicación');
         
                }else if(permission == LocationPermission.deniedForever){
                  AlertWidget().message(context, 'Ubicación apagada');
                }else{
                   haspermission = true;
                }
            }else{
               haspermission = true;
            }

            if(haspermission){
                setState(() {
                  //refresh the UI
                });

                getLocationApp();
            }
      }else{
     AlertWidget().message(context, "Active el gps");
      }

      setState(() {
         //refresh the UI
      });
  }

  getLocationApp() async {
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position.longitude); 
      print(position.latitude); 

      long = position.longitude.toString();
      lat = position.latitude.toString();
_getAddressFromLatLng();
print("prueba60");


      setState(() {
         //refresh UI
      });

      LocationSettings locationSettings = LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 100, 
                                 
      );

      StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
            locationSettings: locationSettings).listen((Position position) {
            print(position.longitude); //Output: 80.24599079
            print(position.latitude); //Output: 29.6593457

            long = position.longitude.toString();
            lat = position.latitude.toString();


            setState(() {
              //refresh UI on update
            });
      });
  }


  Position _currentPosition;
  String _currentAddress;

   _getCurrentLocation()  async {



   /*  location() async {
      LocationPermission permission;
   permission = await Geolocator.requestPermission();
     }location();

    print("location1:");
     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
   print(position.latitude);
   print(position.longitude);
    Geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
      .then((Position position) {
        setState(() {
          _currentPosition = position;
           print("location:"+_currentPosition.latitude.toString());
          _getAddressFromLatLng();
         
        });
      }).catchError((e) {
        print(e);
          print("location2:");
      });*/
  }

  _getAddressFromLatLng() async {
    
      List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(lat),
        double.parse(long),
      );

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
      });
   
  }


  final String apiKey = '6ed5914d0446030f513756c4a11ab46d';
  TextStyle moneyStyle;
  TextStyle titleStyle;
  final bool revealWeather = false;
  String search = "";
  

  @override
  Widget build(BuildContext context) {
    AdaptScreen.initAdapt(context);
    moneyStyle = TextStyle(
        color: AppColors.fontColor,
        fontSize: AdaptScreen.screenWidth() * 0.09,
        fontWeight: FontWeight.bold);
    titleStyle = TextStyle(
        color: AppColors.fontColor, fontSize: AdaptScreen.screenWidth() * 0.05);

    return



      Scaffold(
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
                 Stack(children: <Widget>[
                      Positioned(
                          top: -60.0, right: -35, child: _decorationBox()),
                      Container(
                        padding: EdgeInsets.all(15.0),
                      ),

                      ListView(


                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 40,right:40,top:40,bottom: 20),
                            child: Center(
                              child: Image(
                                image: AssetImage(AssetsRoutes.loginIcon),
                                height: 100.0,
                             //   color: Colors.white,

                              ),
                            ),
                          ),

                          /*  if (_currentPosition != null) Text(
              "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"
            ),

        GestureDetector(onTap: (){
          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => historyPage(),
                              ),
                            );
        },child:    Container(
              width: 100,
              height: 80,
              margin:EdgeInsets.only(right: 250,left: 10),
            decoration: BoxDecoration(
               
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,mainAxisSize: MainAxisSize.min,children: [

Text("Click ver historial", style: AppStyle().styleText(16, Colors.white, false,bold2: true)),
SizedBox(height: 10,),

            ]),
)),*/
SizedBox(height: 10,),

             /* Column(
                children: [ 


                     Text("Longitude: $long", style:TextStyle(fontSize: 18)),
                     Text("Latitude: $lat", style: TextStyle(fontSize: 18),)

                ]
              ),*/
              
              SizedBox(height: 10,),
           /* Row(children: [



         Flexible(child:  Container(margin: EdgeInsets.only(left: 20,right: 20),
     decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                    width: 1.0,
                ),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20.0),
            )
             ,width: double.infinity,height:60,child:
             
             DropdownButtonHideUnderline(child: DropdownButton<String>(isExpanded: true,
  items: <String>['Barranquilla', 'Bogota', 'Medellin', 'Cali'].map((String value) {
    return DropdownMenuItem<String>(
      
      value: value,
    
      child: Text(value),
      
    );
  }).toList(),
  hint: Container(
          width: 150,                      //and here
          child: Text(
           ReduxHome.store.state.postsState.search.toString(),
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.end,
          ),
        ),
        style:
            TextStyle(color: Colors.black, decorationColor: Colors.red),
      
  onChanged: (value) {
  
 ReduxHome.store.dispatch(
          SetPostsStateActionHome( PostsStateHome(
            search: value
          )),
        );

         AppSharedPreference().getDataUser().then((value) 
    {
      print("token: "+value.toString());
      
     String  formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format( DateTime.now());
      HistoryItem data = new HistoryItem(date: formattedDate,id: (value.length+1).toString(),title: ReduxHome.store.state.postsState.search.toString(),body:ReduxHome.store.state.postsState.search.toString());
      List<HistoryItem> list =[];
      list = value;
      list.add(data);

        AppSharedPreference().setDataScan(list);



    });
  
  },
)))),



            ],),*/

          Container(margin: EdgeInsets.only(left: 20,right:20),child:  TextField(
                  onChanged: (text) {
 asinc() async {
      Store<AppState> store =
      await createStore(api: API());


      store.dispatch(getProductAction(
        context,text,
      ));
    }

    asinc();
   
  },
            decoration: InputDecoration(
               prefixIcon: Icon(Icons.search),
                labelText: 'Buscar',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                )),
          )),
          SizedBox(height: 10,),

                        /*Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: TextField(

                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Buscar',
                              ),

                              onChanged: (String text) {
                                search = text;
                                setState(() {

                                });
                              },


                            ),
                          ),*/


                        //  Text( ReduxHome.store.state.postsState.modelInfoProduct.results.length.toString()),
                        ReduxHome.store.state.postsState.modelInfoProduct == null ?
                          
                          Column(children: [
                            SizedBox(height: 40,),
  Text("Cargando datos...", style: AppStyle().styleText(20, Colors.grey, true))

                          ],)
                        : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:  ReduxHome.store.state.postsState.modelInfoProduct.results.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                              
                               ResultInfoProduct dataInfo = ReduxHome.store.state.postsState.modelInfoProduct.results[index];
                                

                                  return AppCard().widgetCardHome(
                                      context, dataInfo);
                               
                                
                              }
                          )
                        ],
                      ),
                    ]);
              })),
      /*floatingActionButton: SpeedDial(
        marginEnd: 18,
        marginBottom: 20,

        icon: Icons.add,
        activeIcon: Icons.close,

        buttonSize: 60.0,
        visible: true,

        closeManually: false,

        renderOverlay: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        // orientation: SpeedDialOrientation.Up,
        // childMarginBottom: 2,
        // childMarginTop: 2,
        children: [
          SpeedDialChild(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.red,
            label: "Cargar Ubicación",
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
         checkGps();
             // _getCurrentLocation();
              //refreshList();
            },
          ),


        ],
      ),*/
    );
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
                AppColors.bgPrimaryColor,
                AppColors.bgPrimaryColor,
              ])),
        ));
  }
  refreshList(){
    asinc() async {
      Store<AppState> store =
      await createStore(api: API());


      store.dispatch(getProductAction(
        context,"Motorola%20G6",
      ));
    }

    asinc();
  }


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshList();
     checkGps();
  }
}



class RefreshItemsAction {
  final Completer<Null> completer;

  RefreshItemsAction({Completer completer})
      : this.completer = completer ?? Completer<Null>();
}
