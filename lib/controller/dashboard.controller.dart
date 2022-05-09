import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shivrai_task/common/file_helper.dart';
import 'package:shivrai_task/common/shared_ui.dart';
import 'package:shivrai_task/model/farmers.model.dart';
import 'package:shivrai_task/view/farmersForm.view.dart';

class DashboardController extends GetxController {
  final GlobalKey<FormState> farmersFormKey = GlobalKey<FormState>();
  FarmersModel farmer = FarmersModel();
  List<FarmersModel> data = [];
  DateTime? plantingDate;
  Crop? selectedCrop;
  List<Crop> crops = [
    Crop(ageOfCrop: 10, cropName: 'Grapes'),
    Crop(ageOfCrop: 18, cropName: 'Onion'),
    Crop(ageOfCrop: 7, cropName: 'Mangoes')
  ];
  String? selectedGender;
  @override
  void onInit() async {
    super.onInit();
    //Change value to name2
    await getData();
  }

  getData() async {
    var dataJson = await FileHelper.readDataFrom("data/farmers.data.json");
    storeData(dataJson);
  }

  storeData(dynamic dataJson) async {
    Hive.init((await getApplicationDocumentsDirectory()).path);
    var box = await Hive.openBox('myBox');
    box.addAll(dataJson);
    for (var farmerData in dataJson) {
      FarmersModel farmer = FarmersModel.fromJson(farmerData);
      data.add(farmer);
    }

    box.close();
    update();
  }

  addFarmer() async {
    var isValid = farmersFormKey.currentState!.validate();
    if (isValid) {
      farmersFormKey.currentState!.save();
      farmer.gender = selectedGender;
      var box = await Hive.openBox('myBox');
      data.add(farmer);
      box.add(farmer.toJson());
      box.close();

      update();

      Navigator.pop(Get.context!);
      SharedUi().showToast("Farmer added");
    } else {
      SharedUi().showToast("All fields are required", isError: true);
    }
  }
}
