import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/profile/controller/profile_location_controller.dart';
import 'package:matchster/routes/app_navigation.dart';

class LocationSearchScreen extends BaseView<ProfileLocationController> {
  String title = "";
  String type = "";
  String selectedValue = "";
  RxList<String> dataList = <String>[].obs;
  final TextEditingController searchController = TextEditingController();

  RxList<String> filteredList = <String>[].obs;
  @override
  void onInit(ProfileLocationController controller) {
    super.onInit(controller);
    title = Get.arguments["title"] ?? "";
    type = Get.arguments["type"] ?? "";
    selectedValue = Get.arguments["selectedValue"] ?? "";
    dataList = Get.arguments["list"] ?? [];
    filteredList.value = List.from(dataList);
  }

  void filterSearch(String value) {
    if (value.isEmpty) {
      filteredList.value = dataList;
    } else {
      filteredList.value =
          dataList
              .where((e) => e.toLowerCase().contains(value.toLowerCase()))
              .toList();
    }
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: title,
        onTop: () {
          AppNavigation.back();
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: CustomFormField(
              controller: searchController,
              onChanged: (query) {
                filterSearch(query ?? "");
              },
              label: '',
              hint: "Search $type",
              enableBorder: true.obs,
            ),
          ),
          // 📋 LIST
          Expanded(
            child: Obx(() {
              if (filteredList.isEmpty) {
                return Center(child: Text("No Data Found"));
              }
              return ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final item = filteredList[index];
                  return ListTile(
                    title: Text(item),
                    trailing:
                        item == selectedValue
                            ? Icon(Icons.check, color: Colors.green)
                            : null,
                    onTap: () {
                      Navigator.pop(context, item);
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
