import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:matchster/core/base/base_stateless_view.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/notification/controller/notification_controller.dart';
import 'package:matchster/routes/app_navigation.dart';

class NotificationScreen extends BaseStatelessView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget buildView(BuildContext context, NotificationController controller) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: AppStrings.notificationString.title,
        onTop: () {
          AppNavigation.back();
        },
      ),
      body: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [],
      ).paddingSymmetric(horizontal: 15.w),
    );
  }
}
