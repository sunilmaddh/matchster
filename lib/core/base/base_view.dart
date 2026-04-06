import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_listner.dart';
import 'base_controller.dart';

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
      if (mounted) {
        onReady();
      }
    });
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  Widget _buildContent(BuildContext context) {
    if (!widget.useDefaultLoader) {
      return buildView(context);
    }

    return Stack(
      children: [
        buildView(context),
        Obx(() {
          return controller.isLoading.value
              ? Positioned.fill(
                child: AbsorbPointer(
                  absorbing: true,
                  child: Container(
                    color: widget.loaderBarrierColor,
                    child: widget.buildLoader(context),
                  ),
                ),
              )
              : const SizedBox.shrink();
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseListener<T>(
      controller: controller,
      child: _buildContent(context),
    );
  }
}
