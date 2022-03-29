/*
    Created by Shitab Mir on 18 October 2021
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_example/constants/app_colors.dart';
import 'package:flutter_pos_printer_example/constants/app_fontWeights.dart';
import 'package:flutter_pos_printer_example/constants/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UIUtil {

  static UIUtil instance = UIUtil();

  /// Decorations
  BoxDecoration textFieldDecoration = BoxDecoration(
    shape: BoxShape.rectangle,
    border: Border.all(color: AppColors.instance.appBarColor),
    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
    color: Colors.transparent,
    boxShadow: const [
      BoxShadow(
        color: Colors.white,
        blurRadius: 0.0,
        spreadRadius: 0.0,
        offset: Offset(0.0, 0.0), // shadow direction: bottom right
      ),
    ],
  );

  /// Show Toast
  Future showToast(BuildContext context, String msg) async{
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: Text(msg),
      ),
    );
  }

  dismissToast(BuildContext context) {
    try {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    } catch (e) {
      print(e);
    }
  }

  void errorToast(BuildContext context, String msg, String buttonText, Function()? call) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: AppColors.instance.sunsetOrange,
        action: SnackBarAction(
          label: buttonText,
          textColor: Colors.white,
          onPressed:() => (call==null) ? dismissToast(context) : call,
        ),
      ),
    );
  }

  ///Custom Dialog
  showCustomDialog(BuildContext context,{required Widget? child, double? borderRadius = 10.0}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(borderRadius!)), //this right here
            child: Wrap(
              children: [
                child!,
              ],
            ),
          );
        }
    );
  }

  ///Alert Dialog
  showAlertDialog(BuildContext context,{String? title, String? subTitle , required Function()? actionFunction}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: (title != null) ? Center(child: FittedBox(child: Text(title))) : null,
            content: (subTitle != null) ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    subTitle,
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.instance.sunsetOrange,
                    ),
                  ),
                )
              ],
            ) : null,
            actions: <Widget>[
              ElevatedButton(
                  child: Text('Cancel'),
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.instance.sunsetOrange),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              ElevatedButton(
                child: Text('Ok'),
                style: ElevatedButton.styleFrom(
                    primary: AppColors.instance.silverChalice),
                onPressed: actionFunction,
              ),
            ],
          );
        }
    );
  }

  ///Material Banner
  showMaterialBanner(BuildContext context, {required String bannerText}){
    ScaffoldMessenger.of(context)
      ..removeCurrentMaterialBanner()
      ..showMaterialBanner(MaterialBanner(
        content: Text(bannerText,style: TextStyle(
          fontSize: 12.sp,
          fontFamily: 'Raleway',
          color: AppColors.instance.sunsetOrange,
        ),),
        actions: [
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            child: Text('Dismiss',style: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'Raleway',
              fontWeight: AppFontWeights.instance.extraBold,
              color: AppColors.instance.sunsetOrange,
            ),),
          ),
        ],
      ));
    Timer(Duration(seconds: 10), () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
  }

  ///bottom sheet
  showBottomSheet(BuildContext context,{required Widget? child}){
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (builder) {
          return Wrap(
            children: [
              child!,
            ],
          );
        }
    );
  }

  /// horizontal space
  Widget createHorizontalSpace(var spaceQuantity){
    return SizedBox(width: spaceQuantity);
  }

  /// vertical space
  Widget createVerticalSpace(var spaceQuantity){
    return SizedBox(height: spaceQuantity);
  }

}