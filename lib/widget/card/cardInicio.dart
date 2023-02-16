
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:pruebaTest/data/models/InfoProductModel.dart';

import 'package:pruebaTest/styles/colors.dart';
import 'package:pruebaTest/styles/style.dart';
import 'package:pruebaTest/ui/main/infoProductScreen.dart';

import 'package:pruebaTest/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppCard {
  /*Widget widgetCardHomePost(BuildContext context, PostModel data) {
    return Card(
      elevation: 2,
      child:  Container(
        margin: EdgeInsets.only(left: 20,top: 20,bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data.title,
              style: AppStyle().styleText(18, Colors.black, true),
            ),

                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(data.body.toString(),
                      style: AppStyle().styleText(14, Colors.grey, false)),
                ),



          ],
        ),
      ),
    );
  }*/
  Widget widgetCardHome(BuildContext context, ResultInfoProduct data) {
    return Card(
      elevation: 2,
      child: GestureDetector(
        onTap: () {

           Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => infoProductPage(data: data,),
                              ),
                            );
        },
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(left: 15),
          child: Stack(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: AppWidget().widgetImage(
                    data.thumbnail,
                      80,
                      80,
                    ),
                  ),
                 Flexible(child: Container(
                    margin: EdgeInsets.only(left: 20,top: 20,bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                       Flexible(child: Text(
                          data.title,
                          style: AppStyle().styleText(16,  Colors.black, false,bold2: false),
                        )),
                        SizedBox(height: 10,),
                      
                           Row(children: [
  Icon(Icons.attach_money_sharp,size: 24, color: Colors.black,),

 Text(
                     NumberFormat("#,##0", "en_US").format(     double.parse(data.price.toString())),
                          style: AppStyle().styleText(20,  Colors.black, false,bold2: false)),
],),
 SizedBox(height: 10,),
                            Text( data.catalogProductId.toString(),
                                style: AppStyle().styleText(14, Colors.black, false)),
                   

                        GestureDetector(
                          onTap: (){
                           /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => usersListProfilePage(user: data,),
                              ),
                            );*/
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 40,top: 20,bottom: 15),
                            child: Row(
                              children: [

                            
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

 
}
