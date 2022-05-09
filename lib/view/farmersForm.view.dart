import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shivrai_task/common/shared_ui.dart';
import 'package:shivrai_task/controller/dashboard.controller.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Crop {
  String? cropName;
  int? ageOfCrop;
  Crop({this.cropName, this.ageOfCrop});
}

class FarmersForm extends StatelessWidget {
  FarmersForm({Key? key}) : super(key: key);
  final List gender = ["Male", "Female", "Other"];

  final DashboardController dashboardController =
      Get.find<DashboardController>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController ageOfCropController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<DashboardController>(initState: (dController) {
        dashboardController.selectedGender = null;
        dashboardController.selectedCrop = null;
        // dashboardController.update();
      }, builder: (dc) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Form(
            key: dc.farmersFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                      height: 28,
                      width: 28,
                      child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          })),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text('Farmers form',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: SharedUi().sharedDecoration(
                      hintText: 'Full name', labelText: 'Full name'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (value) {
                    dc.farmer.fullName = value;
                  },
                  validator: (value) {
                    return SharedUi()
                        .validation(value, "Full name is required");
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                Text('Gender',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey[700])),
                FormField<bool>(
                  builder: (state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            addRadioButton(context, 0, 'Male'),
                            addRadioButton(context, 1, 'Female'),
                            addRadioButton(context, 2, 'Others'),
                          ],
                        ),
                        dc.selectedGender != null
                            ? const Text('')
                            : state.errorText == null
                                ? const Offstage()
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      state.errorText ?? '',
                                      style: TextStyle(
                                          color: Theme.of(context).errorColor,
                                          fontSize: 12.0),
                                    ),
                                  )
                      ],
                    );
                  },
                  validator: (value) {
                    if (dc.selectedGender == null) {
                      return 'Gender required';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  maxLines: 4,
                  decoration: SharedUi().sharedDecoration(
                      hintText: 'Address', labelText: 'Address'),
                  onSaved: (value) {
                    dc.farmer.address = value;
                  },
                  validator: (value) {
                    return SharedUi().validation(value, "Address is required");
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: TextFormField(
                            decoration: SharedUi().sharedDecoration(
                                hintText: 'Plot Area', labelText: 'Area'),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onSaved: (value) {
                              dc.farmer.plotArea =
                                  double.parse(value!.replaceAll(' ', ''));
                            },
                            validator: (value) {
                              if (value == null || value == '') {
                                return "Plot Area is required";
                              } else if (value.contains(',')) {
                                return "Plot Area is not valid";
                              } else {
                                return null;
                              }
                            }),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: DropdownButtonFormField<Crop>(
                          value: dc.selectedCrop,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // isExpanded: false,
                          hint: const Text("Select Crop"),
                          decoration: SharedUi().sharedDecoration(
                              hintText: "Select Crop",
                              labelText: "Select Crop"),
                          onChanged: (val) {
                            dc.selectedCrop = val;
                            dc.farmer.crop = val!.cropName;
                            dc.update();
                          },
                          validator: (value) =>
                              value == null ? 'Crop required' : null,
                          items: dc.crops.map((value) {
                            return DropdownMenuItem<Crop>(
                              value: value,
                              child: Text(value.cropName!),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  decoration: SharedUi().sharedDecoration(
                      hintText: 'Variety', labelText: 'Variety'),
                  onSaved: (value) {
                    dc.farmer.variety = value;
                  },
                  validator: (value) {
                    return SharedUi().validation(value, "Variety is required");
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: TextFormField(
                      readOnly: true,
                      enabled: dc.selectedCrop == null ? false : true,
                      controller: dateController,
                      onTap: () {
                        datePicker(context);
                      },
                      validator: (value) {
                        return SharedUi().validation(
                            dashboardController.farmer.plantingDate,
                            "Planting date is required");
                      },
                      decoration: const InputDecoration(
                          hintText: "Planting date",
                          isDense: true,
                          contentPadding: EdgeInsets.all(0),
                          alignLabelWithHint: true,
                          prefixIconConstraints: BoxConstraints(
                              maxHeight: 34,
                              maxWidth: 34,
                              minHeight: 34,
                              minWidth: 34),
                          prefixIcon: SizedBox(
                            height: 16,
                            width: 16,
                            child: Icon(Icons.date_range_outlined),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 5.0),
                          )),
                    ),
                  )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: TextFormField(
                        readOnly: true,
                        controller: ageOfCropController,
                        decoration: SharedUi().sharedDecoration(
                            hintText: 'Age of Crop', labelText: 'Age of Crop'),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          dc.addFarmer();
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ))),
                        child: Text("Submit",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 20, color: Colors.white))),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Row addRadioButton(BuildContext context, int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio<String>(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          groupValue: dashboardController.selectedGender,
          onChanged: (value) {
            dashboardController.selectedGender = value!;
            dashboardController.update();
          },
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }

  datePicker(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SfDateRangePicker(
                  onSelectionChanged: _onSelectionChanged,
                  showActionButtons: true,
                  onSubmit: (val) {
                    dashboardController.farmer.plantingDate = val.toString();

                    dashboardController.plantingDate =
                        DateTime.parse(val.toString());
                    dateController.text = DateFormat('d - MMM - y')
                        .format(dashboardController.plantingDate!);
                    dashboardController.farmer.ageOfCrop = dashboardController
                        .plantingDate!
                        .add(Duration(
                            days: dashboardController.selectedCrop!.ageOfCrop!))
                        .toString();
                    ageOfCropController.text = DateFormat('d - MMM - y').format(
                        dashboardController.plantingDate!.add(Duration(
                            days:
                                dashboardController.selectedCrop!.ageOfCrop!)));
                    Navigator.pop(context);
                  },
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  selectionMode: DateRangePickerSelectionMode.single,
                ),
              ],
            ),
          );
        });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {}
}
