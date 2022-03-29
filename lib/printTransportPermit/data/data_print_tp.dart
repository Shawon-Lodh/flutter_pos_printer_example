/*
    Created by Shawon Lodh on 01 February 2022
*/

import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_example/printTransportPermit/data/data_bluetooth_devices.dart';

class PrintTpScreenData {
  ValueNotifier<bool> isBluetoothOn;
  ValueNotifier<bool> isLocationOn;
  BluetoothDevicesData bluetoothDevicesData;
  ValueNotifier<bool> printButtonVisible;
  ValueNotifier<bool> printStartStatus;

  /// Constructor
  PrintTpScreenData({required this.isBluetoothOn,required this.isLocationOn, required this.bluetoothDevicesData , required this.printButtonVisible, required this.printStartStatus});


  /// Bluetooth On status
  ValueNotifier<bool> get isBluetoothOnValue{
    return isBluetoothOn;
  }

  set isBluetoothOnValue(ValueNotifier<bool> valueIsBluetoothOn) {
    isBluetoothOn = valueIsBluetoothOn;
  }

  /// Location On status
  ValueNotifier<bool> get isLocationOnValue{
    return isLocationOn;
  }

  set isLocationOnValue(ValueNotifier<bool> valueIsLocationOn) {
    isLocationOn = valueIsLocationOn;
  }

  /// Print Button Visible
  ValueNotifier<bool>  get printButtonVisibleValue{
    return printButtonVisible;
  }

  set printButtonVisibleValue(ValueNotifier<bool>  valuePrintButtonVisible) {
    printButtonVisible = valuePrintButtonVisible;
  }

  /// Print Start Status
  ValueNotifier<bool> get printStartStatusValue{
    return printStartStatus;
  }

  set printStartStatusValue(ValueNotifier<bool>  valuePrintStartStatus) {
    printStartStatus = valuePrintStartStatus;
  }

}