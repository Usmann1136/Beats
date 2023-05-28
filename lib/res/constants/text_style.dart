import 'package:beats/res/constants/app_color.dart';
import 'package:flutter/material.dart';

const courgrette = " Poppins Courgrette";
const avenir = " Poppins Avenir";
ourStyle(
    {family = courgrette, double? size = 14.0, color = AppColor.whiteeColor}) {
  return TextStyle(fontSize: size, fontFamily: family, color: color);
}
