/*
    Created by Shawon Lodh on 28 December 2021
*/

import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_example/printTransportPermit/screen/screen_print_tp.dart';
import 'package:flutter_pos_printer_example/printTransportPermit/screen/screen_printing_on_pos_machine.dart';

class AppRoutes {
  /// All pages
  static const String printTpPage = '/printTp';

  static const String printingOnPosMachinePage = '/printingOnPosMachine';

  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case printTpPage:
        return MaterialPageRoute(builder: (BuildContext context) => PrintTpScreen());
      case printingOnPosMachinePage:
        return MaterialPageRoute(
          settings: settings,
          builder: (ctx) => ScreenPrintingOnPosMachineReceiveData(),
          fullscreenDialog: true,
        );
      default:
        return MaterialPageRoute(builder: (BuildContext context) => PrintTpScreen());
    }
  }

}