/*
    Created by Shawon Lodh on 01 February 2022
*/

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_pos_printer_example/constants/app_routes.dart';
import 'package:flutter_pos_printer_example/printTransportPermit/data/data_print_tp.dart';
import 'package:flutter_pos_printer_example/utils/app_common_util.dart';
import 'package:flutter_pos_printer_example/utils/app_logger_util.dart';
import 'package:flutter_pos_printer_example/utils/app_navigation_util.dart';
import 'package:location/location.dart';


class PrintTpScreenPresenter {
  BuildContext context;
  PrintTpScreenData _printTpScreenData;

  /// Constructor
  PrintTpScreenPresenter(this.context, this._printTpScreenData);

  ///Navigation
  goToCreateTPPage() {
    return (){
      NavigatorUtil.instance.goToPreviousPage(context);
    };
  }

  Future checkBluetoothAndLocationInStarting() async{
    _printTpScreenData.isBluetoothOnValue.value = await CommonUtil.instance.bluetoothCheck();
    _printTpScreenData.isLocationOnValue.value = await CommonUtil.instance.gpsCheck();
    if(_printTpScreenData.isBluetoothOnValue.value && _printTpScreenData.isLocationOnValue.value){
      startScanBluetoothDevices();
    }
  }

  toggleBluetoothButton(bool value) {
    if (!CommonUtil.instance.isRedundantClick(DateTime.now(), 1)) {
      future() async {
        try {
          if (value) {
            _printTpScreenData.isBluetoothOnValue.value =
            (await FlutterBluetoothSerial.instance.requestEnable())!;
          }
          // else {
          //   _printTpScreenData.isBluetoothOnValue.value =
          //   (await FlutterBluetoothSerial.instance.requestDisable())!;
          // }
        } catch (e) {
          LoggerUtil.instance.printLog(msg : e);
        }
      }
      future().then((_) {});
    }
  }

  toggleLocationButton(bool value) {
    if (!CommonUtil.instance.isRedundantClick(DateTime.now(), 1)) {
      future() async {
        try {
          CommonUtil.instance.gpsCheck().then((value) async {
            if (value) {
              if (_printTpScreenData.isLocationOnValue.value != null) {
                _printTpScreenData.isLocationOnValue.value =
                    _printTpScreenData.isLocationOnValue.value;
              }
            } else {
              // Geolocator.openLocationSettings();
              if(!await Location().serviceEnabled()){
                Location().requestService().then((value){
                  if(value){
                    LoggerUtil.instance.printLog(msg: "SuccessFully Turned on");
                    _printTpScreenData.isLocationOnValue.value = true;
                  }else{
                    LoggerUtil.instance.printLog(msg: "Failed to Turn on");
                    _printTpScreenData.isLocationOnValue.value = false;
                  }
                });
              }else{
                Location().requestService().then((value){
                  if(value){
                    LoggerUtil.instance.printLog(msg: "SuccessFully Turned on");
                    _printTpScreenData.isLocationOnValue.value = true;
                  }else{
                    LoggerUtil.instance.printLog(msg: "Failed to Turn on");
                    _printTpScreenData.isLocationOnValue.value = false;
                  }
                });
              }
            }
          });
        } catch (e) {
          LoggerUtil.instance.printLog(msg : e);
        }
      }
      future().then((_) {});
    }

  }

  listenBluetoothDevices() {
    _printTpScreenData.bluetoothDevicesData.printerBluetoothManager.scanResults.listen((devices) async {
      _printTpScreenData.bluetoothDevicesData.bluetoothDevicesDataValue.value = devices;
      for(int i = 0;i<_printTpScreenData.bluetoothDevicesData.bluetoothDevicesDataValue.value.length;i++){
        print("Name : ${_printTpScreenData.bluetoothDevicesData.bluetoothDevicesDataValue.value[i].name}, Address : ${_printTpScreenData.bluetoothDevicesData.bluetoothDevicesDataValue.value[i].address}, Type : ${_printTpScreenData.bluetoothDevicesData.bluetoothDevicesDataValue.value[i].type}");
      }
      _printTpScreenData.bluetoothDevicesData.allFoundDevicesSelectionStatusValue = List.filled(_printTpScreenData.bluetoothDevicesData.bluetoothDevicesDataValue.value.length, false);
    });
  }

  startScanBluetoothDevices(){
    _printTpScreenData.bluetoothDevicesData.bluetoothDevicesDataValue.value = [];
    _printTpScreenData.bluetoothDevicesData.printerBluetoothManager.startScan(Duration(seconds: 4));
  }

  stopScanBluetoothDevices() {
    _printTpScreenData.bluetoothDevicesData.printerBluetoothManager.stopScan();
  }

  sendDataToPrinterAndCompletePrinting() async {

    if (!CommonUtil.instance.isRedundantClick(DateTime.now(), 3)) {

      for(int i = 0; i< _printTpScreenData.bluetoothDevicesData.allFoundDevicesSelectionStatusValue!.length; i++){
        if(_printTpScreenData.bluetoothDevicesData.allFoundDevicesSelectionStatusValue![i]){
          LoggerUtil.instance.printLog(msg: "no is : $i");
          final data = await NavigatorUtil.instance.goToNextScreenWithData(context,AppRoutes.printingOnPosMachinePage,{'printerManager': _printTpScreenData.bluetoothDevicesData.printerBluetoothManager,'selectedPrinter': _printTpScreenData.bluetoothDevicesData.bluetoothDevicesDataValue.value[i]});
          if(data!=null && data == true){
            retryButtonFunctionality();
          }
        }
      }
    }
  }

  retryButtonFunctionality(){
    _printTpScreenData.printButtonVisibleValue.value = false;
    startScanBluetoothDevices();
  }

}