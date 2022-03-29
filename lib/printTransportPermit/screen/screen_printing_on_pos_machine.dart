/*
    Created by Shawon Lodh on 02 March 2022
*/

import 'package:flutter_pos_printer_example/constants/app_colors.dart';
import 'package:flutter_pos_printer_example/constants/app_constants.dart';
import 'package:flutter_pos_printer_example/constants/app_fontWeights.dart';
import 'package:flutter_pos_printer_example/constants/app_images.dart';
import 'package:flutter_pos_printer_example/utils/app_navigation_util.dart';
import 'package:flutter_pos_printer_example/utils/app_ui_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class ScreenPrintingOnPosMachineReceiveData extends StatelessWidget {
  const ScreenPrintingOnPosMachineReceiveData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute
        .of(context)!
        .settings
        .arguments as Map;
    return ScreenPrintingOnPosMachine(receiveData: arguments,);
  }

}

class ScreenPrintingOnPosMachine extends StatefulWidget {
  final receiveData;
  ScreenPrintingOnPosMachine({Key? key, this.receiveData}) : super(key: key);
  @override
  _ScreenPrintingOnPosMachineState createState() => _ScreenPrintingOnPosMachineState();
}

class _ScreenPrintingOnPosMachineState extends State<ScreenPrintingOnPosMachine>{

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PrinterBluetoothManager? printerBluetoothManager;
  PrinterBluetooth? selectedPrinter;
  String? tobaccoType;
  String? tobaccoVariety;

  @override
  void initState() {
    printerBluetoothManager = widget.receiveData['printerManager'];
    selectedPrinter = widget.receiveData['selectedPrinter'];
    tobaccoType = widget.receiveData['tobaccoType'];
    tobaccoVariety = widget.receiveData['tobaccoVariety'];
    super.initState();
  }

  @override
  void dispose() {
    printerBluetoothManager = null;
    selectedPrinter = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backButtonPressed,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: FutureBuilder<String>(
            future: _createPrint(selectedPrinter!),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(AppImages.instance.printingContinue,height: 300.h,),
                            FittedBox(
                              child: Text("Please wait...\nprinting process is started...", textAlign: TextAlign.center,
                                style: TextStyle(color: AppColors.instance.tundora,
                                    fontSize: 24.sp,
                                    fontFamily: "Raleway",
                                    fontWeight: AppFontWeights.instance.extraBold),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(AppImages.instance.error,height: 300.h),
                              FittedBox(
                                child: Text(snapshot.error.toString(), textAlign: TextAlign.center,
                                  style: TextStyle(color: AppColors.instance.sunsetOrange,
                                      fontSize: 32.sp,
                                      fontFamily: "Raleway",
                                      fontWeight: AppFontWeights.instance.extraBold),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    if(snapshot.data.toString() == "Success"){
                      NavigatorUtil.instance.goToPreviousPage(context).then((value){
                        NavigatorUtil.instance.goToPreviousPageWithData(context,data: true);
                      });
                      return Container();
                    }else{
                      return Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(AppImages.instance.error,width: 300.h),
                                FittedBox(
                                  child: Text(snapshot.data.toString(), textAlign: TextAlign.center,
                                    style: TextStyle(color: AppColors.instance.sunsetOrange,
                                        fontSize: 32.sp,
                                        fontFamily: "Raleway",
                                        fontWeight: AppFontWeights.instance.extraBold),),
                                ),
                                UIUtil.instance.createVerticalSpace(20.h),
                                _getRetryButton(),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }

                default:
                  return FittedBox(
                    child: Text("Unhandle State", textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.instance.sunsetOrange,
                          fontSize: 32.sp,
                          fontFamily: "Raleway",
                          fontWeight: AppFontWeights.instance.extraBold),),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  ///UI

  Widget _getRetryButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: OutlinedButton(
        onPressed: (){
          NavigatorUtil.instance.goToPreviousPageWithData(context, data: true);
        },
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 15.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.r),),
          side: BorderSide(width: 3.w, color: AppColors.instance.sunsetOrange,style: BorderStyle.solid,),
        ),
        child: Text(
          "Retry",
          style: TextStyle(
            fontSize: 24.sp,
            fontFamily: 'Raleway',
            fontWeight: AppFontWeights.instance.bold,
            color: AppColors.instance.sunsetOrange,
          ),
        ),
      ),
    );
  }

  ///functions

  Future<List<int>> _createReceipt(
      PaperSize paper, CapabilityProfile profile) async {
    final Generator ticket = Generator(paper, profile);
    List<int> bytes = [];

    bytes += ticket.text('GLOBAL LEAF TOBACCO COMPANY LTD',
        styles: PosStyles(align: PosAlign.center));

    bytes += ticket.text('Crop Year ${DateFormat('y').format(DateTime.now())}',
        styles: PosStyles(align: PosAlign.center),
        linesAfter: 1);

    bytes += ticket.text('Tobacco Transport Permit',
        styles: PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold: true,
        ),
        linesAfter: 1);

    // bytes += ticket.qrcode(transportPermitResponseData!.tpQrCode.toString(),
    //     size: QRSize.Size8, align: PosAlign.center);
    // bytes += ticket.feed(1);
    // bytes += ticket.hr();
    // bytes += ticket.feed(1);
    // bytes += ticket.text('Name : ${transportPermitResponseData!.farmerName.toString()}',
    //     styles: const PosStyles(align: PosAlign.center));
    // bytes += ticket.text('Father Name : ${transportPermitResponseData!.farmerFather.toString()}',
    //     styles: const PosStyles(align: PosAlign.center));
    // bytes += ticket.text('Reg No : ${transportPermitResponseData!.registrationNo.toString()}',
    //     styles: const PosStyles(align: PosAlign.center));
    // bytes += ticket.text('Tobacco Type : ${tobaccoType}',
    //     styles: const PosStyles(align: PosAlign.center));
    // bytes += ticket.text('Tobacco Variety : ${tobaccoVariety}',
    //     styles: const PosStyles(align: PosAlign.center));
    // bytes += ticket.text('Ext Center : ${transportPermitResponseData!.extensionCenter.toString()}',
    //     styles: const PosStyles(align: PosAlign.center));
    // bytes += ticket.text('Allowed Bale: ${transportPermitResponseData!.beal.toString()}',
    //     styles: const PosStyles(align: PosAlign.center));
    // bytes += ticket.text('Buying Date : ${increaseOneDayFromReceivedDate(receivedDate: transportPermitResponseData!.date.toString())}',
    //     styles: const PosStyles(align: PosAlign.center));
    // bytes += ticket.hr();

    // final ByteData data = await rootBundle.load('assets/images/default.png');
    // final Uint8List buffer= data.buffer.asUint8List();
    // final  image = decodeImage(buffer);
    //
    // bytes += ticket.image(image!);

    bytes += ticket.feed(2);
    bytes += ticket.text('Thank you!',
        styles: PosStyles(align: PosAlign.center, bold: true));

    final now = DateTime.now();
    final formatter = DateFormat.yMd().add_jm();
    final String timestamp = formatter.format(now);
    bytes += ticket.text(timestamp,
        styles: const PosStyles(align: PosAlign.center), linesAfter: 2);
    bytes += ticket.text("",
        styles: const PosStyles(align: PosAlign.center), linesAfter: 2);
    ticket.feed(2);
    ticket.cut();
    return bytes;
  }

  Future<String> _createPrint(PrinterBluetooth printer) async {
    printerBluetoothManager!.selectPrinter(selectedPrinter!);

    // TODO Don't forget to choose printer's paper
    const PaperSize paper = PaperSize.mm80;

    final profile = await CapabilityProfile.load();

    // Final RECEIPT
    final PosPrintResult res =
    await printerBluetoothManager!.printTicket((await _createReceipt(paper, profile)));

    // UIUtil.instance.showToast(context, res.msg);

    return res.msg;

  }

  String increaseOneDayFromReceivedDate({required String receivedDate}){
    DateTime receivedParsedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(receivedDate);
    DateTime increasedDate = DateTime(receivedParsedDate.year,receivedParsedDate.month, receivedParsedDate.day + 1);
//   var dateFormatterPattern = DateFormat('MM/dd/yyyy hh:mm a');
    var dateFormatterPattern = DateFormat.yMMMMd('en_US');
    return dateFormatterPattern.format(DateTime.parse(increasedDate.toString()));
  }

  /// backPress Dialogs
  Future<bool> _backButtonPressed() async {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState?.openEndDrawer();
    } else {
      // _scaffoldKey.currentState?.openEndDrawer();
      Dialogs.materialDialog(
          msg: AppConstants.instance.wannaBackToPreviousPage,
          color: Colors.white,
          context: context,
          actions: [
            IconsOutlineButton(
              onPressed: () {
                NavigatorUtil.instance.goToPreviousPage(context);
              },
              text: AppConstants.instance.no,
              iconData: Icons.cancel_outlined,
              textStyle: TextStyle(color: Colors.grey),
              iconColor: Colors.grey,
            ),
            IconsButton(
              onPressed: () {
                NavigatorUtil.instance.goToPreviousPage(context);
                NavigatorUtil.instance.goToPreviousPage(context);
              },
              text:AppConstants.instance.exit,
              iconData: Icons.exit_to_app,
              color: Colors.red,
              textStyle: TextStyle(
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
              iconColor: Colors.white,
            ),

          ]);
    }
    return false;
  }

}
