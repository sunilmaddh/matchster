import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_controller.dart';
import 'base_listener.dart';

abstract class BaseView<T extends BaseController> extends StatefulWidget {
  const BaseView({super.key});

  bool get useDefaultLoader => true;

  Color get loaderBarrierColor => Colors.black26;

  Widget buildLoader(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

abstract class BaseViewState<T extends BaseController, V extends BaseView<T>>
    extends State<V> {
  late final T controller;

  @protected
  Widget buildView(BuildContext context);

  void onInit() {}

  void onReady() {}

  void onDispose() {}

  @override
  void initState() {
    super.initState();
    controller = Get.find<T>();
    onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      onReady();
    });
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content =
        widget.useDefaultLoader
            ? Stack(
              children: [
                buildView(context),
                Obx(() {
                  if (!controller.isLoading.value) {
                    return const SizedBox.shrink();
                  }

                  return Positioned.fill(
                    child: Container(
                      color: widget.loaderBarrierColor,
                      child: widget.buildLoader(context),
                    ),
                  );
                }),
              ],
            )
            : buildView(context);

    return BaseListener<T>(controller: controller, child: content);
  }
}
