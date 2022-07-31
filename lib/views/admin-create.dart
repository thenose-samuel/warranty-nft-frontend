import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:get/get.dart';
import 'package:my_warranft/controllers/admin-create-controller.dart';
import 'package:my_warranft/styles/app-text-styles.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late AdminCreateController controller;
  @override
  void initState() {
    controller = Get.put(AdminCreateController());
    super.initState();
  }

  void _showAlertDialog(BuildContext context, bool pickStart) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Pick a Date'),
        content: Container(
          width: 250,
          height: 300,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: SfDateRangePicker(
            backgroundColor: Colors.white,
            rangeSelectionColor: Colors.white,
            view: DateRangePickerView.month,
            monthViewSettings:
                const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
            selectionMode: DateRangePickerSelectionMode.single,
            onSelectionChanged: (date) {
              if (pickStart)
                controller.pickStartDate(date.value);
              else
                controller.pickEndDate(date.value);
            },
          ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Done'),
          )
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Success'),
        content: Text('NFT has been sent to ${controller.walletAddress?.text}'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'View',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          defaultTitle: 'admin',
          builder: (BuildContext context) {
            RxBool _switchValue = false.obs;
            return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                width: Get.width * 0.02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Row(
                    children: [
                      const Text('Admin Panel', style: AppTextStyles.header),
                      SizedBox(
                        width: Get.width * 0.44,
                      ),
                      const Text(
                        'Wallet Address: ',
                        style: TextStyle(color: Colors.white),
                      ),
                      const Text(
                        '0xFdC9B9F1e5Ec6c9FaB8874cf9D3656F7E158cFbD',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  const Text(
                    'Product ID',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  SizedBox(
                      width: Get.width * 0.4,
                      child:  CupertinoTextField(
                        controller: controller.productId,
                        placeholder: 'Enter Product ID',
                      )),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  const Text(
                    'Wallet Address',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  SizedBox(
                    width: Get.width * 0.4,
                    child: CupertinoTextField(
                      controller: controller.walletAddress,
                      placeholder: 'Enter Customer Wallet Address',
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  const Text(
                    'Warranty benefits',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  SizedBox(
                    width: Get.width * 0.4,
                    child: CupertinoTextField(
                      controller: controller.benefits,
                      maxLines: 5,
                      placeholder: 'Enter benefits or provide a link to it',
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        (controller.startDateSet.value)
                            ? controller
                                .dateTimeToString(controller.startDate.value)
                            : 'XX-XX-XXX',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Obx(
                        () => CupertinoButton(
                            child: Text(
                              'Select Issue Date',
                            ),
                            onPressed: (controller.minting.value)
                                ? null
                                : () async {
                              _showAlertDialog(context, true);
                            }),
                      ),
                      // Obx(() => CupertinoSwitch(
                      //     value: _switchValue.value,
                      //     onChanged: (value) {
                      //       if (value) {
                      //         controller.startDate.value = DateTime.now();
                      //         controller.startDateSet.value = true;
                      //         _switchValue.value = value;
                      //       } else {
                      //         _switchValue.value = value;
                      //       }
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        (controller.endDateSet.value)
                            ? controller
                                .dateTimeToString(controller.endDate.value)
                            : 'XX-XX-XXX',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Obx(
                        () => CupertinoButton(
                            child: Text(
                              'Select Expiry Date',
                            ),
                            onPressed: (controller.minting.value)
                                ? null
                                : () async {
                              _showAlertDialog(context, false);
                              //     }))`
                            },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Obx(
                    () => CupertinoButton.filled(
                        child: (controller.minting.value)
                            ? const CupertinoActivityIndicator(
                                color: Colors.black)
                            : const Text('Mint'),
                        onPressed: () async{
                          controller.minting.value = !controller.minting.value;
                            await controller.createWarrantyToken();
                            controller.minting.value = !controller.minting.value;
                            _showSuccessDialog(context);
                        }),
                  ),
                ],
              ),
            ]);
          },
        );
      },
    );
  }
}
