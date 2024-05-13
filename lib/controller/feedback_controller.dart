import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/application.dart';
import 'package:paghiram_loan/common/common_alert.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/global.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker_ios/image_picker_ios.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

class FeedbackController extends GetxController {
  var isProductItem = true.obs;
  var selectedImageFilePath = ''.obs;
  var imgName = 'Upload photo for specification'.obs;
  var selectedProblems = <String>[].obs;
  var problemInputController = TextEditingController();

  ImagePickerIOS _picker = ImagePickerIOS();

  String? selectedImage;

  @override
  void onInit() {
    super.onInit();
    problemInputController.addListener(() {
      if (problemInputController.text.trim().length > 500) {
        problemInputController.text = problemInputController.text.substring(0, 500);
      }
    });
  }

  void productItemOnTap() {
    imgName.value = 'Upload photo for specification';
    selectedImage = null;
    selectedImageFilePath.value = '';
    problemInputController.text = '';
    isProductItem.value = true;
  }

  void collectionItemOnTap() {
    imgName.value = 'Upload photo for specification';
    selectedImage = null;
    selectedImageFilePath.value = '';
    problemInputController.text = '';
    isProductItem.value = false;
  }

  void go2selectImage() async {
    var status = await Permission.photos.request();
    if (status != PermissionStatus.granted) {
      var result = await CommonAlert.showAlert(title: 'Photo album authorization',message: 'Upload your feedback photo before, Please ensure photo album access is enabled in your system settings.');
      if (result == 'confirm') openAppSettings();
      return;
    }

    var imgFile = await _picker.pickImage(source: ImageSource.gallery);

    if (imgFile == null) return;
    imgName.value = '';
    selectedImageFilePath.value = imgFile.path;
    // encode to base64
    Uint8List bytes = await imgFile.readAsBytes();
    selectedImage = base64Encode(bytes);
  }

  void enlargeImageToSee() {
    Get.toNamed(ApplicationRoutes.feedbackImageEnlarge, arguments: selectedImageFilePath.value);
  }

  void deleteImgAction() {
    selectedImageFilePath.value = '';
    selectedImage = null;
  }

  void go2selectProblemType() async {
    var problems = await  Get.toNamed(ApplicationRoutes.feedbackTypePicker, arguments: selectedProblems.value);
    if(problems == null) return;
    selectedProblems.value = problems;
  }

  void problemBtnDeleteOnTap(int index) {
    List<String> tempList = [];
    selectedProblems.value.forEach((element) {
      tempList.add(element);
    });
    tempList.removeAt(index);
    selectedProblems.value = tempList;
  }

  void submitFeedback() {
    if (problemInputController.text.trim().isEmpty) {
      return CommonSnackBar.showSnackBar('Please enter your problem!');
    }

    String tempCho = isProductItem.value ? 'Produce issue' : 'Problemasa collection';
    if (!isProductItem.value) {
      if (selectedProblems.value.isEmpty) return CommonSnackBar.showSnackBar('Please fill in the content');
      selectedProblems.value.forEach((element) {
        tempCho += '/$element';
      });
    }

    Map<String, dynamic> params = {
      'cho': tempCho,
      'content': problemInputController.text,
      'type': isProductItem.value ? '1' : '2',
      'photo': selectedImage,
      'phone': Global.prefs?.getString(Constant.PHONE_NUMBER_FLAG),
    };

    NetworkService.submitFeedback(params, () {
      Get.back(result: 'success');
    });
  }
}
