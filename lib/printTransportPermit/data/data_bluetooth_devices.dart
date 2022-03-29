/*
    Created by Shawon Lodh on 03 February 2022
*/

import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';

class BluetoothDevicesData {
  PrinterBluetoothManager printerBluetoothManager;
  ValueNotifier<List<PrinterBluetooth>> bluetoothDevicesData;
  List<bool>? allFoundDevicesSelectionStatus;

  /// Constructor
  BluetoothDevicesData({required this.printerBluetoothManager, required this.bluetoothDevicesData});

  /// Bluetooth Devices Data
  ValueNotifier<List<PrinterBluetooth>> get bluetoothDevicesDataValue{
    return bluetoothDevicesData;
  }

  set bluetoothDevicesDataValue(ValueNotifier<List<PrinterBluetooth>> valueBluetoothDevicesData) {
    bluetoothDevicesData = valueBluetoothDevicesData;
  }

  /// All Found Devices Selection Status
  List<bool>? get allFoundDevicesSelectionStatusValue{
    return allFoundDevicesSelectionStatus;
  }

  set allFoundDevicesSelectionStatusValue(List<bool>? valueAllFoundDevicesSelectionStatus) {
    allFoundDevicesSelectionStatus = valueAllFoundDevicesSelectionStatus;
  }

}