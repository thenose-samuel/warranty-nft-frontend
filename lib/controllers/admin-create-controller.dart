

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_warranft/helpers/endpoints.dart';
import 'package:my_warranft/helpers/network-manager.dart';

class AdminCreateController extends GetxController {
  Rx<DateTime> startDate = DateTime(0).obs;
  Rx<DateTime> endDate = DateTime(0).obs;
  RxBool fromInception = false.obs;
  RxBool startDateSet = false.obs;
  RxBool endDateSet = false.obs;
  RxBool minting = false.obs;
  TextEditingController? productId = TextEditingController();
  TextEditingController? walletAddress = TextEditingController();
  TextEditingController? benefits = TextEditingController();



  void pickStartDate(DateTime pickedDate) async {
    if (pickedDate != null) {
      startDate.value = pickedDate;
      startDateSet.value = true;
    } else {
      startDateSet.value = false;
    }
  }

  void pickEndDate(DateTime? pickedDate) async {

    if (pickedDate != null) {
      endDate.value = pickedDate;
      endDateSet.value = true;
    } else {
      endDateSet.value = false;
    }
  }

  String dateTimeToString(DateTime dateTime) {
    String date = DateFormat("dd/MM/yyyy").format(dateTime);
    return date;
  }

  String dateSendApi(DateTime dateTime) {
    String date = DateFormat("yyyy-MM-dd").format(dateTime);
    return date;
  }
  Future<void> createWarrantyToken() async{
    Map<String, dynamic> data = {
      "productId": productId!.value.text,
      "walletAddress": walletAddress!.value.text,
      "warrantyDetails": benefits!.value.text,
      "issueDate": this.startDate.value.toUtc().toString(),
      "expirationDate": this.endDate.value.toUtc().toString(),
    };
    try{
      var response = await postApi(Endpoints.mintToken, data: data);
    } catch(e){

    }
  }
}
