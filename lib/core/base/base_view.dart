import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_listner.dart';
import 'base_controller.dart';

abstract class BaseView<T extends BaseController> extends StatefulWidget {
  BaseView({super.key});

  /// internal controller storage
  T? _controller;

  /// direct controller access inside child screens
  T get controller => _controller ?? Get.find<T>();

  /// set false if screen does not want default loader overlay
  bool get useDefaultLoader => true;

  /// loader barrier color
  Color get loaderBarrierColor => Colors.black26;

  /// custom loader widget
  Widget buildLoader(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  /// screen ui
  Widget body(BuildContext context);

  /// optional lifecycle hooks
  @protected
  void onInit(T controller) {}

  @protected
  void onReady(T controller) {}

  @protected
  void onDispose(T controller) {}

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseController> extends State<BaseView<T>> {
  late final T controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<T>();
    widget._controller = controller;

    widget.onInit(controller);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      widget.onReady(controller);
    });
  }

  @override
  void dispose() {
    widget.onDispose(controller);
    widget._controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = widget.body(context);

    final child =
        widget.useDefaultLoader
            ? Stack(
              children: [
                screen,
                Obx(() {
                  if (!controller.isLoading.value) {
                    return const SizedBox.shrink();
                  }

                  return Positioned.fill(
                    child: Container(
                      color: widget.loaderBarrierColor,
                      alignment: Alignment.center,
                      child: widget.buildLoader(context),
                    ),
                  );
                }),
              ],
            )
            : screen;

    return BaseListener<T>(controller: controller, child: child);
  }
}
