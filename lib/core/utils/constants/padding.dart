import 'package:expenses/core/extensions/sized_box_extension.dart';
import 'package:flutter/cupertino.dart';

import '../../size_config/app_size_config.dart';

class PaddingHelper {

 static double padding20Horizontal(){
   return 20.setWidth();
  }

 static double padding64Vertical(){
   return 64.setHeight();
 }
 static double padding16Vertical(){
   return 16.setHeight();
 }
 static double padding16Horizontal(){
   return 16.setWidth();
 }
 static double padding22Vertical(){
   return 22.setHeight();
 }
 static double padding22Horizontal(){
   return 22.setWidth();
 }

 static double padding8Vertical(BuildContext context){
   return 8.setHeight();
 }
 static double padding8Horizontal(BuildContext context){
   return 8.setWidth();
 }



}