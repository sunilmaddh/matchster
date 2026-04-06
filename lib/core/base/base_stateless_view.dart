import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/base/base_listner.dart';

abstract class BaseStatelessView<T extends BaseController>
    extends StatelessWidget {
  const BaseStatelessView({super.key});

  T get controller => Get.find<T>();

  Widget buildView(BuildContext context, T controller);

  bool get useDefaultLoader => true;
  Color get loaderBarrierColor => Colors.black26;

  Widget buildLoader(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    final content =
        useDefaultLoader
            ? Stack(
              children: [
                buildView(context, controller),
                Obx(() {
                  if (!controller.isLoading.value) {
                    return const SizedBox.shrink();
                  }

                  return Positioned.fill(
                    child: Container(
                      color: loaderBarrierColor,
                      child: buildLoader(context),
                    ),
                  );
                }),
              ],
            )
            : buildView(context, controller);

    return BaseListener<T>(controller: controller, child: content);
  }
}
