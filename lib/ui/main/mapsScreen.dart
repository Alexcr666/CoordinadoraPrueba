import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pruebaTest/redux2/settingApp/store.dart';
import 'package:pruebaTest/styles/colors.dart';
import 'package:pruebaTest/styles/style.dart';
import 'package:pruebaTest/utils/adapt_screen.dart';
import 'package:pruebaTest/utils/alert.dart';
import 'package:pruebaTest/widget/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

BuildContext contextGlobal;
CameraPosition position_ini = CameraPosition(
  target: LatLng(10.989121, -74.954960),
  zoom: 15,
);

var currentLocation = null;
var global_context;
double width;
double height;

SharedPreferences prefs;
bool init;

String googleAPIKey = "AIzaSyBwKHqkmEUFUXdHWGzTYZ15Dzufm2V4CBo";
// for my custom icons
BitmapDescriptor sourceIcon;
BitmapDescriptor destinationIcon;
List<LatLng> latlng = [];

final Set<Marker> _markers = {};
final Set<Polyline> _polyline = {};

class mapResumePage extends StatefulWidget {
  mapResumePage({Key key, this.list}) : super(key: key);
  List<double> list;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mapResumePageState();
  }
}

class mapResumePageState extends State<mapResumePage> {
  // Completer<GoogleMapController> _controller = Completer();
  // this set will hold my markers

  double latitudeLocation;
  double longitudeLocation;

  Map<PolylineId, Polyline> _mapPolylines = {};
  int _polylineIdCounter = 1;
  List<LatLng> points = <LatLng>[];
  clearMaps() {
    /* //_mapPolylines.clear();

    _markers.clear();
    _mapPolylines.clear();
    points.clear();
    _add();*/
  }

  void _add() {
    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    _polylineIdCounter++;
    final PolylineId polylineId = PolylineId(polylineIdVal);

    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      color: Colors.red,
      width: 5,
      points: points,
    );

    setState(() {
      _mapPolylines[polylineId] = polyline;
    });
    print("prueba146");
  }

  /*List<LatLng> _createPoints() {
    final List<LatLng> points = <LatLng>[];
    points.add(LatLng(1.875249, 0.845140));
    points.add(LatLng(4.851221, 1.715736));
    points.add(LatLng(8.196142, 2.094979));
    points.add(LatLng(12.196142, 3.094979));
    points.add(LatLng(16.196142, 4.094979));
    points.add(LatLng(20.196142, 5.094979));
    return points;
  }*/

//call this method on button click that will draw a polyline and markers

  void _onAddMarkerButtonPressed() {
    LatLng _center = LatLng(widget.list[0], widget.list[1]);

//add your lat and lng where you wants to draw polyline
    LatLng _lastMapPosition = _center;
    // getDistanceTime();
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      /*_polyline.add(Polyline(
        polylineId: PolylineId(_lastMapPosition.toString()),
        visible: true,
        //latlng is List<LatLng>
        points: latlng,
        color: Colors.blue,
      ));*/
    });
  }

  BuildContext context;
  TextEditingController _controllerSpecific = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();
  TextEditingController _controllerAddressCity = TextEditingController();
  double textSize = 0.038;
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  CameraPosition _position;

  Widget _mapa_inicio(BuildContext context) {
    return Container(
      //height: AdaptScreen.screenHeight(),
      child: Stack(
        children: [
          GoogleMap(
            polylines: Set<Polyline>.of(_mapPolylines.values),
            markers: _markers,
            myLocationEnabled: true,
            onCameraMove: (position) {
              _position = position;
              setState(() {});
            },

            mapType: MapType.normal,
            //  initialCameraPosition: _kGooglePlex,
            initialCameraPosition: CameraPosition(target: LatLng(widget.list[0], widget.list[1]), zoom: 15),

            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);

              permisos();
              //  _goToNewYork();
              _goToTheLake2();
            },
          ),
        ],
      ),
    );
  }

  Iterable markers = [];

  verificar_gps() async {
    ServiceStatus serviceStatus = await PermissionHandler().checkServiceStatus(PermissionGroup.location);
    bool enabled = (serviceStatus == ServiceStatus.enabled);
    if (enabled) {
    } else {
      AlertWidget().message(context, "Active el gps");
    }
  }

  Future permisos() async {
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.location]);

    //  Position position =
    //await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      // currentLocation = position;
      position_ini = CameraPosition(
        target: LatLng(widget.list[0], widget.list[1]),
        zoom: 15,
      );
    });
    // print(position.latitude.toString());

    _goToTheLake2();
  }

  Future<void> _goToTheLake2() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(position_ini));
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'assets/driving_pin.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'assets/destination_map_marker.png');
  }

  double mapPercentaje = 0.45;

  locationBusTake() {
    //init = true;
  }

  @override
  void initState() {
    super.initState();
    init = true;
    Timer.run(() {
      // clearMaps();
    });
    // latitudeLocation = widget.data.getOutLatitude;
    //longitudeLocation = widget.data.getOutLongitude;

    Timer.run(() {
      //  LatLng _new = LatLng(widget.data.takeBusLatitude, widget.data.takeBusLongitude);
      LatLng _news = LatLng(1, 1);
      // latlng.add(_new);
      latlng.add(_news);
      _onAddMarkerButtonPressed();

      // modalMapResume(global_context, widget.data);
      print("prueba103");

      setSourceAndDestinationIcons();
      setState(() {});
    });

    verificar_gps();

    _animateToUser() async {
      /* Position position =
      await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      setState(() {
        currentLocation = position;
      });*/

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(widget.list[0], widget.list[1]),
        zoom: 15,
      )));
    }

    _animateToUser();
    permisos();
    //  _goToNewYork();
    _goToTheLake2();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      global_context = context;
    });

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    // TODO: implement build

    return new WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppWidget().appbar(true, context),
          //  appBar: widgetAppbar(context,"Detalle del recorrido"),
          body: StoreProvider<AppStateHome>(
              store: ReduxHome.store,
              child: StoreConnector<AppStateHome, dynamic>(
                  distinct: true,
                  converter: (store) => ReduxHome.store,
                  onInit: (store) {
                    // _storeHome = store;
                  },
                  builder: (context2, value) {
                    return _mapa_inicio(context);
                  })),
        ));
  }

/*
  Widget modalMapResumeInformation(BuildContext context, String routeId) {
    Timer.run(() {
      clearMaps();
    });
//points.clear();
    endPointApiAddress()
        .getRouteIdService(
        routeId).then((data2) {
      maps() {
        // latitudeLocation = widget.data.getOutLatitude;
        //longitudeLocation = widget.data.getOutLongitude;

        //  print("prueba104" + widget.data.description.toString());
        String line = data2.data.linestring.replaceAll("LINESTRING(", "");
        String line2 = line.replaceAll(")", "");
        List<String> result = line2.split(',');

        print("prueba143: " + result.length.toString());

        //print("prueba145: "+resultLocation.length.toString());
        for (var i = 0; i < result.length; i++) {
          String location = result[i];
          List<String> resultLocation = location.split(' ');

          double latitud = double.parse(resultLocation[0]);
          double longitute = double.parse(resultLocation[1]);
          points.add(LatLng(longitute, latitud));
          if (result.length == i + 1) {
            _add();
            setState(() {

            });
          }
        }
      }
      maps();



    });


    showModalBottomSheet(
        barrierColor: Colors.black.withAlpha(1),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        enableDrag: false,
        isDismissible: false,


        builder: (context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.2,
              maxChildSize: 0.75,
              expand: false,

              builder: (_, controller) {


                      return WillPopScope(
                          onWillPop: () {
                            Navigator.pop(context);
                          },
                          child:


                          Container(
                            color: Colors.white,

                            child: Container(
                              //margin: EdgeInsets.only(left: 20, right: 20),
                              child:


                              FutureBuilder(

                                  future: endPointApiAddress()
                                      .getRouteIdService(
                                      routeId),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {

                                    case ConnectionState.waiting:
                                    return Column(
                                    children: [
                                    SizedBox(height: 40,),
                                    Row(
                                    children: [
                                    Expanded(child: SizedBox()),
                                    CircularProgressIndicator(color: AppColors.primaryColor),
                                    Expanded(child: SizedBox()),
                                    ],
                                    ),
                                    ],
                                    );
                                    default:
                                    if (snapshot.hasError) {
                                    print("prueba57" +
                                    snapshot.error.toString());
                                    return Text(
                                    'Error: ${snapshot.error}');
                                    } else {
                                    try {
                                    var data = snapshot.data;
                                    RouteIdModel data2 = data.data;



                                    return data2 == null
                                    ? Text(
                                    "no result") /*AlertWidget().noResult(context)*/
                                        : Container(

                                    child: ListView(
                                   // controller: controller,
                                                //   mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                    Container(
                                    margin: EdgeInsets.only(
                                    left: 20, right: 20),
                                    child: Column(children: [

                                    SizedBox(
                                    height: AdaptScreen
                                        .screenHeight() *
                                    0.05,),
                                    Text(
                                    data2.nombre
                                        .toUpperCase(),
                                    textAlign: TextAlign
                                        .left,
                                    style:

                                    TextStyle(
                                    letterSpacing: 1.0,
                                    fontSize: AdaptScreen
                                        .screenHeight() *
                                    0.04,
                                    color: AppColors
                                        .secondaryTextColor,
                                    fontWeight: FontWeight
                                        .normal,
                                    ),

                                    ),
                                    SizedBox(
                                    height: AdaptScreen
                                        .screenHeight() *
                                    0.05,),
                                    Text(

                                    data2.descripcion
                                        .toUpperCase(),
                                    textAlign: TextAlign
                                        .left,
                                    style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.grey,
                                    ),
                                    ),
                                    SizedBox(
                                    height: AdaptScreen
                                        .screenHeight() *
                                    0.05,),

                                   /* ClipRRect(
                                    borderRadius: BorderRadius
                                        .circular(8.0),
                                    child:
                                    Image.network(
                                    "https://cdn.pixabay.com/photo/2019/09/07/06/18/bus-4458028__340.jpg",
                                    fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                                        return Text('Your error widget...');
                                      },
                                      width: double
                                          .infinity,
                                      height: 150,),
                                    ),*/
                                    ],),
                                    ),


                                                  data2.frecuencias.length != 0
                                                      ?


                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 7),
                                                    child: Center(
                                                      child: Text(
                                                        "No hay datos de frecuencia",
                                                        textAlign: TextAlign
                                                            .left,
                                                        style: styleText(
                                                            AdaptScreen
                                                                .screenWidth() *
                                                                0.04,
                                                            AppColors.colorGrey,
                                                            false),
                                                      ),
                                                    ),
                                                  )
                                                      : Container(

                                                      child: ListView.builder(


                                                          physics: BouncingScrollPhysics(),
                                                          itemCount: data2
                                                              .frecuencias
                                                              .length,
                                                          shrinkWrap: true,
                                                          padding: EdgeInsets
                                                              .only(
                                                           left: 10,right: 10
                                                          ),
                                                          itemBuilder: (context,
                                                              int index) {
return  Row(

  children: [
    //  SizedBox(
    //width: AdaptScreen.screenWidth() * 0.04,),
    Column(children: [

      index == 0? Row(
        // mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons
              .access_time),
          SizedBox(
            width: AdaptScreen
                .screenWidth() *
                0.02,),
          Container(
            margin: EdgeInsets
                .only(
                bottom: 20),
            child: Text(
              "Horarios",
              textAlign: TextAlign
                  .left,
              style: styleText(
                  AdaptScreen
                      .screenWidth() *
                      0.04,
                  AppColors
                      .secondaryTextColor,
                  false),
            ),
          ),
        ],
      ):SizedBox(),
      SizedBox(
        height: AdaptScreen
            .screenHeight() *
            0.03,),
      Text(
        data2
            .frecuencias[index].horaFin.toString()+" - "+data2
            .frecuencias[index].horaInicio.toString(),
        textAlign: TextAlign
            .left,
        style: styleText(
            AdaptScreen
                .screenWidth() *
                0.04,
            AppColors
                    .mainColor,
            false),
      ),
      SizedBox(
        height: AdaptScreen
            .screenHeight() *
            0.03,),


    ],),
    SizedBox(
      width: AdaptScreen
          .screenWidth() *
          0.02,),
   /* Flexible(
      child: Container(
        margin: EdgeInsets.only(
            top: 10),
        width: 1,
        height: 150,
        color: Colors.grey,),
    ),*/
    SizedBox(
      width: AdaptScreen
          .screenWidth() *
          0.03,),
    Column(
      crossAxisAlignment: CrossAxisAlignment
          .start,
      children: [

        index == 0? Container(
          margin: EdgeInsets
              .only(
              bottom: 7),
          child: Text(
            "Hora",
            textAlign: TextAlign
                .left,
            style: styleText(
                AdaptScreen
                    .screenWidth() *
                    0.04,
                 AppColors
                    .mainColor,
                false),
          ),
        ):SizedBox(),
        SizedBox(
          height: AdaptScreen
              .screenHeight() *
              0.03,),
        Text(
          data2
              .frecuencias[index].frecuencia.toString(),
          textAlign: TextAlign
              .left,
          style: styleText(
              AdaptScreen
                  .screenWidth() *
                  0.04,
              AppColors
                    .mainColor,
              false),
        ),

      ],),
    SizedBox(
      width: AdaptScreen
          .screenWidth() *
          0.02,),
    /*Container(
      margin: EdgeInsets.only(
          top: 10),
      width: 1,
      height: 150,
      color: Colors.grey,),*/
    SizedBox(
      width: AdaptScreen
          .screenWidth() *
          0.03,),
    Column(
      crossAxisAlignment: CrossAxisAlignment
          .start,
      children: [

        index == 0? Container(
          margin: EdgeInsets
              .only(
              bottom: 7),
          child: Text(
            "Frecuencia",
            textAlign: TextAlign
                .left,
            style: styleText(
                AdaptScreen
                    .screenWidth() *
                    0.04,
                AppColors
                    .mainColor,
                false),
          ),
        ):SizedBox(),
        SizedBox(
          height: AdaptScreen
              .screenHeight() *
              0.03,),
        Text(
          data2
              .frecuencias[index].horaInicio.toString()+" - "+data2
              .frecuencias[index].horaFin.toString()+" min",
          textAlign: TextAlign
              .left,
          style: styleText(
              AdaptScreen
                  .screenWidth() *
                  0.04,
              AppColors
                  .mainColor,
              false),
        ),
        SizedBox(
          height: AdaptScreen
              .screenHeight() *
              0.03,),

      ],),

  ],);
                                                          })),





                                    SizedBox(
                                    height: AdaptScreen
                                        .screenHeight() *
                                    0.05,),

                                    ],
                                    ),
                                    );
                                    } catch (e) {
                                      print("prueba148" + e.toString());
                                      return ElementWidget().noResult();
                                    }
                                    }
                                  }
                                  }),


                            ),
                          ));
              });
        });
  }*/
/*
  modalMapResume(BuildContext context, RouteHomeModel data) {
    showModalBottomSheet(
        barrierColor: Colors.black.withAlpha(1),
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: false,
        builder: (context) {

          return StatefulBuilder(
              builder: (BuildContext context,  setState /*You can rename this!*/) {

                String locationPerson = data.getOutAdress;
                String locationTakeBus= data.takeBusAdress;
                refresh(){

                  setState(() {

                  });
                }
                /* search<String>(double latitude,double longitude) async {

                 //    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                   //debugPrint('location: ${position.latitude}');
                  final coordinates = new Coordinates(latitude,longitude);
                  var addresses = await Geocoder.google(AppSettings.googleApiKey).findAddressesFromCoordinates(coordinates);
                  var first = addresses.first;
                  /*  ReduxHome.store.dispatch(SetPostsStateActionHome(
                PostsStateHome(locationUser: first.addressLine.toString()
                )));*/

                  return first.addressLine.toString();
                }
                search(data.getOutLatitude, data.getOutLongitude).then((value) {
                  locationPerson = value;
                  print("prueba142");
                  refresh();
                });
                search(data.takeBusLatitude, data.takeBusLongitude).then((value) {
                  locationTakeBus = value;
                  print("prueba143");
                  refresh();
                });*/


                return  Container(
                  color: Colors.white,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: AdaptScreen.screenHeight() * 0.01,
                        ),
                        Text(
                          "Caminar hasta",
                          style: styleText(AdaptScreen.screenWidth() * 0.05,
                              AppColors.primaryTextColor, true),
                        ),

                        SizedBox(height: AdaptScreen.screenHeight() * 0.02,),
                        GestureDetector(onTap: (){
                          Navigator.pop(context);
                          modalMapResumeInformation(context,data.routeId);
                        },
                          child: Container(
                            width: 220,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: AppColors.primaryColor, // Set border color
                                  width: 1), // Set border width
                              borderRadius: BorderRadius.all(
                                  Radius.circular(50.0)), // Set rounded corner radius
                              // Make rounded corner of border
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(5),
                                  child: SvgPicture.asset(
                                    AssetWidget().assetsPeople,

                                    height: 20,
                                    width: 20,
                                    color: AppColors.primaryColor,

                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: AdaptScreen.screenWidth() * 0.02),

                                Flexible(
                                  child: Text(
                                    widget.data.takeBusAdress,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: AdaptScreen.screenWidth() * 0.04),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: AdaptScreen.screenHeight() * 0.01,),

                        Container(width: double.infinity,
                          color: AppColors.primaryTextColor,
                          height: 0.3,),
                        SizedBox(height: AdaptScreen.screenHeight() * 0.01,),

                        Text(
                          "Tomar el bus",
                          style: styleText(AdaptScreen.screenWidth() * 0.04,
                              AppColors.primaryTextColor,
                              true),
                        ),
                        SizedBox(height: AdaptScreen.screenHeight() * 0.02,),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                            modalMapResumeInformation(context,data.routeId);
                          },
                          child:  Row(

                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  child: SvgPicture.asset(
                                    AssetWidget().assetsPeople,

                                    height: 20,
                                    width: 20,
                                    color: AppColors.colorGrey,

                                    fit: BoxFit.cover,
                                  ),
                                ),

                                SizedBox(width: AdaptScreen.screenWidth() * 0.01),
                                Container(
                                  margin: EdgeInsets.all(5),
                                  child: SvgPicture.asset(
                                    AssetWidget().transport,

                                    height: 20,
                                    width: 20,
                                    color: AppColors.colorGrey,

                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: AdaptScreen.screenWidth() * 0.01),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                    modalMapResumeInformation(context,data.routeId);
                                  },
                                  child: Flexible(
                                    child: Container(

                                      child: Text(
                                        widget.data.routeName+" "+"("+widget.data.plate+")",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 18,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          
                        ),
                        SizedBox(height: AdaptScreen.screenHeight() * 0.01,),


                        Container(width: double.infinity,
                          color: AppColors.primaryTextColor,
                          height: 0.3,),
                        SizedBox(height: AdaptScreen.screenHeight() * 0.01,),

                        Text(
                          "Bajarse",
                          maxLines: 2,
                          style: styleText(AdaptScreen.screenWidth() * 0.04,
                              AppColors.primaryTextColor,
                              true),
                        ),
                        SizedBox(height: AdaptScreen.screenHeight() * 0.01,),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              child: SvgPicture.asset(
                                AssetWidget().transport,

                                height: 20,
                                width: 20,
                                color: AppColors.colorGrey,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 5,),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: SvgPicture.asset(
                                AssetWidget().assetsPeople,
                                color: AppColors.colorGrey,
                                height: 20,
                                width: 20,

                                fit: BoxFit.cover,
                              ),
                            ),
                            

                              Flexible(
                                child: Container(

                                    margin: EdgeInsets.only(bottom: 14),
                                  child: Text(
                                    widget.data.getOutAdress,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: styleText(AdaptScreen.screenWidth() * 0.04,
                                        AppColors.colorGrey,
                                        false),
                                  ),
                                ),

                            ),
                          ],
                        ),
                        SizedBox(height: AdaptScreen.screenHeight() * 0.01,),
                        SizedBox(height: AdaptScreen.screenHeight() * 0.01,),
                        Container(width: double.infinity,
                          color: AppColors.primaryTextColor,
                          height: 0.3,),
                        SizedBox(height: AdaptScreen.screenHeight() * 0.01,),

                        Text(
                          "Caminar al destino",
                          style: styleText(AdaptScreen.screenWidth() * 0.04,
                              AppColors.primaryTextColor,
                              true),
                        ),
                        SizedBox(height: AdaptScreen.screenHeight() * 0.01,),
                        Row(
                          children: [

                            SizedBox(width: 5,),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: SvgPicture.asset(
                                AssetWidget().assetsPeople,

                                height: 20,
                                width: 20,
                                color: AppColors.colorGrey,
                                fit: BoxFit.cover,
                              ),
                            ),
                            

                             Flexible(
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 14),child: Text(
                                    ReduxHome.store.state.postsState.location2[0].toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: styleText(AdaptScreen.screenWidth() * 0.04,
                                        AppColors.colorGrey,
                                        false),
                                  ),
                                ),
                              ),

                          ],
                        ),
                        SizedBox(height: AdaptScreen.screenHeight() * 0.01,),
                        SizedBox(height: AdaptScreen.screenHeight() * 0.01,),
                        Container(width: double.infinity,
                          color: AppColors.primaryTextColor,
                          height: 0.3,),
                        SizedBox(height: AdaptScreen.screenHeight() * 0.01,),
                        SizedBox(height: AdaptScreen.screenHeight() * 0.03,),
                      ],
                    ),
                  ),
                );
              });


        });
  }*/
  Widget _cityField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
          controller: _controllerAddressCity,
          style: styleText(AdaptScreen.screenWidth() * textSize, Colors.black, false),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: "Medillin Colombia",
              labelStyle: TextStyle(color: AppColors.mainColor),
              labelText: 'Ciudad',
              prefixIcon: Icon(
                Icons.map_outlined,
                size: AdaptScreen.screenWidth() * 0.08,
                color: Colors.black,
              ),
              hintStyle: TextStyle(color: Colors.grey))),
    );
  }

  Widget _textFieldWithIcon(IconData icon, String title, String hintText) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  icon,
                  size: AdaptScreen.screenWidth() * 0.06,
                  color: AppColors.mainColor,
                ),
                SizedBox(width: AdaptScreen.screenWidth() * 0.03),
                Text(
                  title,
                  style: TextStyle(color: AppColors.mainColor, fontSize: AdaptScreen.screenWidth() * textSize),
                )
              ],
            ),
            TextField(
              textInputAction: TextInputAction.go,
              controller: _controllerSpecific,
              style: styleText(AdaptScreen.screenWidth() * textSize, Colors.black, false),
              decoration: InputDecoration(
                hintText: hintText,
              ),
              minLines: 2,
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }
}
