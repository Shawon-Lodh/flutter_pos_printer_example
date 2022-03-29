/*
    Created by Shawon lodh on 2 January 2022
*/

import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_example/constants/app_colors.dart';
import 'package:flutter_pos_printer_example/constants/app_constants.dart';
import 'package:flutter_pos_printer_example/constants/app_fontWeights.dart';
import 'package:flutter_pos_printer_example/constants/app_images.dart';
import 'package:flutter_pos_printer_example/printTransportPermit/data/data_bluetooth_devices.dart';
import 'package:flutter_pos_printer_example/printTransportPermit/data/data_print_tp.dart';
import 'package:flutter_pos_printer_example/printTransportPermit/presenter_print_tp.dart';
import 'package:flutter_pos_printer_example/utils/app_common_util.dart';
import 'package:flutter_pos_printer_example/utils/app_ui_utils.dart';
import 'package:flutter_pos_printer_example/widgets/widget_ripple_animation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class PrintTpScreen extends StatefulWidget {
  const PrintTpScreen({Key? key}) : super(key: key);
  @override
  _PrintTpScreenState createState() => _PrintTpScreenState();
}

class _PrintTpScreenState extends State<PrintTpScreen>{

  PrintTpScreenData? _printTpScreenData;

  PrintTpScreenPresenter? _printTpScreenPresenter;

  @override
  void initState() {
    _printTpScreenData = PrintTpScreenData(
      isBluetoothOn: ValueNotifier(false),
      isLocationOn: ValueNotifier(false),
      bluetoothDevicesData: BluetoothDevicesData(printerBluetoothManager: PrinterBluetoothManager(),bluetoothDevicesData: ValueNotifier([])),
      printButtonVisible: ValueNotifier(false),
      printStartStatus: ValueNotifier(false),
    );
    _printTpScreenPresenter = PrintTpScreenPresenter(context, _printTpScreenData!);
    _printTpScreenPresenter?.checkBluetoothAndLocationInStarting();
    _printTpScreenPresenter!.listenBluetoothDevices();
  }

  @override
  void dispose() {
    _printTpScreenPresenter!.stopScanBluetoothDevices();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CommonUtil.instance.notificationStatusBarShow(show: true);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Text("Printer Test"),),
        body: ValueListenableBuilder(
          valueListenable: _printTpScreenData!.isBluetoothOnValue,
          builder: (context, bool bluetoothStatusValue, child) {
            return ValueListenableBuilder(
              valueListenable: _printTpScreenData!.isLocationOnValue,
              builder: (context, bool locationStatusValue, child) {
                return Column(
                  children: [
                    !(bluetoothStatusValue && locationStatusValue) ? _getHardwareConnectionPanel(bluetoothStatusValue: bluetoothStatusValue, locationStatusValue: locationStatusValue) : _getAllBlueToothDevicesInformation(),
                  ],
                );
              },
            );
          },
        ),
        floatingActionButton: ValueListenableBuilder(
          valueListenable: _printTpScreenData!.printButtonVisibleValue,
          builder: (context, bool printButtonVisibleValue, child) {
            return Visibility(
              visible: printButtonVisibleValue,
              child: FloatingActionButton(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    AppImages.instance.printButtonImage,
                    width: 64.w,
                    height: 64.w,
                  ),
                ),
                onPressed: (){
                  print("Pressed");
                  _printTpScreenPresenter!.sendDataToPrinterAndCompletePrinting();
                },
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(side: BorderSide(width: 5,color: AppColors.instance.tundora),borderRadius: BorderRadius.circular(100.r)),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getHardwareConnectionPanel({required bool bluetoothStatusValue, required bool locationStatusValue}) {
    return Visibility(
      visible: !(bluetoothStatusValue && locationStatusValue),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 25.h),
        child: Column(
          children: [
            _getHardwareConnectionPanelTitle(),
            _getHardwareConnectionPanelBody(),
            _getTutorialForTurnOnHardwareConnection(bluetoothStatusValue, locationStatusValue),
          ],
        ),
      ),
    );
  }

  Widget _getTutorialForTurnOnHardwareConnection(bool bluetoothStatusValue, bool locationStatusValue) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getTutorialContentItemForTurnOnHardwareConnection(visibilityStatus: bluetoothStatusValue, imageAddress: AppImages.instance.turnOnBluetooth, text: "Please\nTurn on BlueTooth"),
          _getTutorialContentItemForTurnOnHardwareConnection(visibilityStatus: locationStatusValue, imageAddress: AppImages.instance.turnOnGps, text: "Please\nTurn on Gps"),
        ],
      ),
    );
  }

  Widget _getTutorialContentItemForTurnOnHardwareConnection({required bool visibilityStatus, required String imageAddress, required String text}) {
    return Visibility(
      visible: !visibilityStatus,
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
                imageAddress, width: 160.w),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.instance.sunsetOrange,
                  fontSize: 12.sp,
                  fontFamily: 'Raleway',
                  fontWeight: AppFontWeights.instance.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getHardwareConnectionPanelBody() {
    return Visibility(
      visible: !(_printTpScreenData!.isBluetoothOnValue.value && _printTpScreenData!.isLocationOnValue.value),
      child: Padding(
        padding: EdgeInsets.only(top: 15.h, bottom: 25.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getHardwareActiveButton(
              activeImageAddress: AppImages.instance.bluetoothSelectionOnImage,
              nonActiveImageAddress:
                  AppImages.instance.bluetoothSelectionOffImage,
              title: AppConstants.instance.bluetooth,
              buttonStatus: _printTpScreenData!.isBluetoothOnValue,
              buttonStatusChangeFunction: _printTpScreenPresenter!.toggleBluetoothButton,
            ),
            UIUtil.instance.createHorizontalSpace(30.w),
            _getHardwareActiveButton(
              activeImageAddress: AppImages.instance.gpsSelectionOnImage,
              nonActiveImageAddress: AppImages.instance.gpsSelectionOffImage,
              title: AppConstants.instance.location,
              buttonStatus: _printTpScreenData!.isLocationOnValue,
              buttonStatusChangeFunction: _printTpScreenPresenter!.toggleLocationButton,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getHardwareActiveButton(
      {required String activeImageAddress,
      required String nonActiveImageAddress,
      required String title,
      required ValueNotifier<bool> buttonStatus,
      required Function(bool)? buttonStatusChangeFunction}) {
    return Container(
      padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        border: Border.all(
          color: AppColors.instance.tundora,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// active dot circle
          Container(
            margin: EdgeInsets.only(right: 15.w),
            width: 5.h,
            height: 5.h,
            decoration: new BoxDecoration(
              color: AppColors.instance.geebung,
              shape: BoxShape.circle,
            ),
          ),

          /// hardware active button body
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: ValueListenableBuilder(
              valueListenable: buttonStatus,
              builder: (context, bool buttonStatusValue, child) {
                return Column(
                  children: [
                    SvgPicture.asset(
                      buttonStatusValue
                          ? activeImageAddress
                          : nonActiveImageAddress,
                      height: 24.h,
                      width: 24.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        title,
                        style: TextStyle(
                            color: AppColors.instance.tundora,
                            fontSize: 12.sp,
                            fontFamily: 'Raleway',
                            fontWeight: AppFontWeights.instance.bold),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Switch(
                        onChanged: buttonStatusChangeFunction,
                        value: buttonStatusValue,
                        activeColor: AppColors.instance.tundora,
                        activeTrackColor:
                            AppColors.instance.silverChalice.withOpacity(0.5),
                        inactiveTrackColor:
                            AppColors.instance.silverChalice.withOpacity(0.5),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getHardwareConnectionPanelTitle() {
    return Text(
      AppConstants.instance.deviceManagePermission,
      style: TextStyle(
          color: AppColors.instance.silverChalice,
          fontSize: 16.sp,
          fontFamily: 'Raleway',
          fontWeight: AppFontWeights.instance.bold),
    );
  }

  Widget _getAllBlueToothDevicesInformation() {
    return Builder(
      builder: (BuildContext contex){
        _printTpScreenData!.bluetoothDevicesData.bluetoothDevicesDataValue.value.isEmpty ? _printTpScreenPresenter!.startScanBluetoothDevices() : null;
        return StreamBuilder<bool>(
          stream: _printTpScreenData!.bluetoothDevicesData.printerBluetoothManager.isScanningStream,
          initialData: false,
          builder: (c, snapshot) {
            if (snapshot.data!) {
              return Expanded(
                child: Column(
                  children: [
                    Text(
                      AppConstants.instance.searchingDevices,
                      style: TextStyle(
                          color: AppColors.instance.tundora,
                          fontSize: 18.sp,
                          fontFamily: 'Poppins',
                          fontWeight: AppFontWeights.instance.extraBold),
                    ),
                    Text(
                      AppConstants.instance.waitingFewSeconds,
                      style: TextStyle(
                          color: AppColors.instance.silverChalice,
                          fontSize: 16.sp,
                          fontFamily: 'Raleway',
                          fontWeight: AppFontWeights.instance.bold),
                    ),
                    Expanded(child: RippleAnimation(
                      color: AppColors.instance.silverChalice,
                      child: SvgPicture.asset(AppImages.instance.posPrinterImage),)),
                  ],
                ),
              );
            } else {
              return Expanded(
                child: _printTpScreenData!.bluetoothDevicesData.bluetoothDevicesDataValue.value.isNotEmpty ? Column(
                  children: [
                    UIUtil().createVerticalSpace(20.h),
                    _getRetryButton(buttonText: AppConstants.instance.scanMore),
                    Text(
                      AppConstants.instance.totalFoundDevices + _printTpScreenData!.bluetoothDevicesData.bluetoothDevicesDataValue.value.length.toString(),
                      style: TextStyle(
                          color: AppColors.instance.tundora,
                          fontSize: 18.sp,
                          fontFamily: 'Poppins',
                          fontWeight: AppFontWeights.instance.extraBold),
                    ),
                    Text(
                      AppConstants.instance.selectDevices,
                      style: TextStyle(
                          color: AppColors.instance.silverChalice,
                          fontSize: 16.sp,
                          fontFamily: 'Raleway',
                          fontWeight: AppFontWeights.instance.bold),
                    ),
                    UIUtil().createVerticalSpace(20.h),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _printTpScreenData!.bluetoothDevicesData.bluetoothDevicesDataValue.value.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: _selectDeviceForPrint(index),
                              child: _getBlDevicesDetailsCard(
                                deviceName: _printTpScreenData!.bluetoothDevicesData.bluetoothDevicesDataValue.value[index].name.toString(),
                                deviceAddress: _printTpScreenData!.bluetoothDevicesData.bluetoothDevicesDataValue.value[index].address.toString(),
                                selected: _printTpScreenData!.bluetoothDevicesData.allFoundDevicesSelectionStatus![index],
                              ),
                            );
                          }),
                    ),
                  ],
                ) : Column(
                  children: [
                    Text(
                      AppConstants.instance.noDevicesFound,
                      style: TextStyle(
                          color: AppColors.instance.tundora,
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          fontWeight: AppFontWeights.instance.extraBold),
                    ),
                    _getRetryButton(buttonText: AppConstants.instance.retry),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget _getBlDevicesDetailsCard({String? deviceName,String? deviceAddress, bool selected = false}) {
    return Container(
      // constraints: BoxConstraints(minHeight: 0, maxHeight: 90.h),
      padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 20.w),
      alignment: Alignment.center,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [

          Positioned.fill(
            top: 20.h,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: selected ? AppColors.instance.tundora : AppColors.instance.silverChalice,
                  width: 2,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.instance.silverChalice.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.only(left: 90.w,right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: Text(
                            deviceName ?? "",
                            style: TextStyle(
                                color: AppColors.instance.tundora,
                                fontSize: 16.sp,
                                fontFamily: 'Poppins',
                                fontWeight: AppFontWeights.instance.extraBold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            (deviceAddress!= null) ? (AppConstants.instance.address + deviceAddress) : "",
                            style: TextStyle(
                                color: AppColors.instance.tundora,
                                fontSize: 12.sp,
                                fontFamily: 'Poppins',
                                fontWeight: AppFontWeights.instance.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            AppConstants.instance.bluetoothDevice,
                            style: TextStyle(
                                color: AppColors.instance.silverChalice,
                                fontSize: 12.sp,
                                fontFamily: 'Raleway',
                                fontWeight: AppFontWeights.instance.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Visibility(visible: selected, child: FaIcon(FontAwesomeIcons.circleCheck,size: 32.h)),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            left: 20.h,
            bottom: 20.h,
            child: SvgPicture.asset(
              AppImages.instance.posPrinterImage,
              color: AppColors.instance.tundora,
              height: 80.h,
            ),
          ),

          Container(
            height: 110.h,
          )

        ],
      ),
    );
  }

  Widget _getRetryButton({required String buttonText}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: OutlinedButton(
        onPressed: _printTpScreenPresenter!.retryButtonFunctionality,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 75.w,vertical: 12.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.r),),
          side: BorderSide(width: 1.w, color: AppColors.instance.tundora,style: BorderStyle.solid,),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: 'Raleway',
            fontWeight: AppFontWeights.instance.bold,
            color: AppColors.instance.geebung,
          ),
        ),
      ),
    );
  }

  /// functions

  _selectDeviceForPrint(int index){
    return(){
      setState(() {
        _printTpScreenData!.bluetoothDevicesData.allFoundDevicesSelectionStatusValue = List.filled(_printTpScreenData!.bluetoothDevicesData.bluetoothDevicesDataValue.value.length, false);
        _printTpScreenData!.bluetoothDevicesData.allFoundDevicesSelectionStatus![index] = !(_printTpScreenData!.bluetoothDevicesData.allFoundDevicesSelectionStatus![index]);
        _printTpScreenData!.printButtonVisibleValue.value = true;
      });
    };
  }

}
