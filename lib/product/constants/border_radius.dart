import 'package:flutter/material.dart';

@immutable
class BorderRadiusConstants {
  BorderRadiusConstants._();
  static BorderRadiusConstants get instance => BorderRadiusConstants._();
  final BorderRadius circularSmallBorderRadius = BorderRadius.all(Radius.circular(10));
}