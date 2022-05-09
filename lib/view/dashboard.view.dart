import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shivrai_task/controller/dashboard.controller.dart';
import 'package:shivrai_task/model/farmers.model.dart';
import 'package:shivrai_task/view/farmersForm.view.dart';

class DashBoardView extends StatelessWidget {
  DashBoardView({Key? key}) : super(key: key);
  final DashboardController dashboardController =
      Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dc) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: const Text(
            "Farmers",
            style: TextStyle(color: Colors.white),
          )),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                farmerFormDialog(context);
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              )),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  itemBuilder: (context, index) {
                    return farmersCard(context, dc.data[index]);
                  },
                  itemCount: dc.data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  farmersCard(BuildContext context, FarmersModel farmer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: "Full name: ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: farmer.fullName,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: "Address: ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: farmer.address,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: "Gender: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: farmer.gender.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: "Plot Area: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: farmer.plotArea.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: "Crop: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: farmer.crop.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: "Variety: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: farmer.variety.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: "Planting Date :\n  ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: (DateFormat('d - MMM - y')
                                .format(DateTime.parse(farmer.plantingDate!))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: "Age of Crop:\n  ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: (DateFormat('d - MMM - y')
                                .format(DateTime.parse(farmer.ageOfCrop!))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  farmerFormDialog(BuildContext context) {
    return showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        ),
        isScrollControlled: true,
        // barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: FarmersForm(),
          );
        });
  }
}
