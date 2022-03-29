/*
    Created by Shawon Lodh on 29 December 2021
*/
import 'package:flutter/material.dart';

class AppFontWeights {

  static AppFontWeights instance = AppFontWeights();

  FontWeight get thin => FontWeight.w100;
  FontWeight get extraLight => FontWeight.w200;
  FontWeight get light => FontWeight.w300;
  FontWeight get regular => FontWeight.w400;
  FontWeight get semiBold => FontWeight.w600;
  FontWeight get medium => FontWeight.w500;
  FontWeight get bold => FontWeight.w700;
  FontWeight get extraBold => FontWeight.w800;
  FontWeight get black => FontWeight.w900;
}