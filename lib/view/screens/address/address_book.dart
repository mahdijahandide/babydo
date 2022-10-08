import 'package:babydoo/services/controller/address_controller.dart';
import 'package:babydoo/services/utils/app_colors.dart';
import 'package:babydoo/view/widgets/texts/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddressBook extends GetView<AddressController> {
  const AddressBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText().createText(
            title: 'Address Book', size: 18, fontWeight: FontWeight.bold),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5),
          child: Divider(
            color: AppColors().green,
            thickness: 1.1,
            indent: 12,
            endIndent: 12,
          ),
        ),
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/svg/shaped_bg.svg',
            width: Get.width,
            fit: BoxFit.fill,
          ),
          Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: 3,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              // An action can be bigger than the others.

                              onPressed: (v) {},
                              backgroundColor: AppColors().blue,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              borderRadius: BorderRadius.circular(8),
                              label: 'Edit',
                            ),
                            SlidableAction(
                              onPressed: (v) {},
                              backgroundColor: AppColors().maroon,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              borderRadius: BorderRadius.circular(8),
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: Container(
                          height: 100,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                              color: AppColors().green,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    offset: const Offset(1, 1),
                                    spreadRadius: 1,
                                    blurRadius: 3)
                              ],
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 1),
                                  shape: BoxShape.circle,
                                  color: const Color(0xff99CA4E),
                                ),
                                child: Center(
                                    child: SvgPicture.asset(
                                        'assets/svg/location.svg')),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText().createText(
                                      title: 'Wafra,Block 2',
                                      color: Colors.white,
                                      size: 18,
                                      fontWeight: FontWeight.bold),
                                  CustomText().createText(
                                      title:
                                          'Avenue W, Street W, House number 2',
                                      color: Colors.white,
                                      size: 12,
                                      fontWeight: FontWeight.w500),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  );
                },
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors().green,
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.black,
            size: 30,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
