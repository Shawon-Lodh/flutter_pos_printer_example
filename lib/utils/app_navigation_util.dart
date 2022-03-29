/*
    Created by Shawon Lodh on 29 December 2021
*/

import 'package:flutter/material.dart';

class NavigatorUtil {

  static NavigatorUtil instance = NavigatorUtil();

  //Push Related

  ///1. Go to Next Screen without Data
  Future goToNextScreen(BuildContext context, String nextScreenAddress, Function? callOnReturn) async {
    return Navigator.pushNamed(context, nextScreenAddress);
    if(callOnReturn != null) callOnReturn();
  }

  ///2. Go to Next Screen with Data
  Future goToNextScreenWithData(BuildContext context, String nextScreenAddress, Object? args) async {
    return Navigator.pushNamed(
      context,
      nextScreenAddress,
      arguments: args,
    );
  }

  ///3. Go to Next Screen without Data after Destroying Previous screen
  Future goToNextScreenDestroyingPrevious(BuildContext context, String nextScreenAddress) async {
    return Navigator.pushReplacementNamed(context, nextScreenAddress);
  }

  ///4. Go to Next Screen without Data after Destroying Previous all screen
  Future goToNextScreenDestroyingPreviousAll(BuildContext context, String nextScreenAddress) async {
    return Navigator.pushNamedAndRemoveUntil(context, nextScreenAddress, (route) => false);
  }


  //Pop Related

  ///1. check any previous screen or not
  Future<bool> checkAnyPreviousScreenOrNot(BuildContext context) async {
    return Navigator.canPop(context);
  }

  ///2. Go to specific Screen without Data Continuously clearing screen until found
  Future goToSpecificScreenDestroyingPreviousUntilFound(BuildContext context, String nextScreenAddress) async {
    return Navigator.popUntil(context, ModalRoute.withName(nextScreenAddress));
  }

  ///3. Destroy present page without clearing data
  Future goToPreviousPage(BuildContext context) async{
    return Navigator.of(context).pop();
  }

  ///3. Destroy present page with data
  Future goToPreviousPageWithData(BuildContext context,{required var data}) async{
    return Navigator.of(context).pop(data);
  }


  //Push & Pop Related

  ///1. Clear only present screen & Go to specific Screen without Data
  Future goToSpecificScreenDestroyingOnlyPresent(BuildContext context, String nextScreenAddress) async {
    return Navigator.restorablePopAndPushNamed(context, nextScreenAddress);
  }


  /// get current route
  String? getCurrentRouteName(BuildContext context) {
    return ModalRoute.of(context)!.settings.name;
  }

}

/// () => AppNavigator.goToNextScreenDestroyingPrevious(context, ScreenName()),
