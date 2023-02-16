
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../generated/l10n.dart';
import '../styles/colors.dart';
import '../utils/adapt_screen.dart';

class AppWidget {



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
}
