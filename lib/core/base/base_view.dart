import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/base/base_listener.dart';

abstract class BaseView<T extends BaseController> extends StatefulWidget {
  const BaseView({super.key});

  Widget buildView(BuildContext context, T controller);

  void onInit(T controller) {}
  void onReady(T controller) {}
  void onDispose(T controller) {}

  bool get useDefaultLoader => true;
  Color get loaderBarrierColor => Colors.black26;

  Widget buildLoader(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseController> extends State<BaseView<T>> {
  late final T controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<T>();

    widget.onInit(controller);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      widget.onReady(controller);
    });
  }

  @override
  void dispose() {
    widget.onDispose(controller);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content =
        widget.useDefaultLoader
            ? Stack(
              children: [
                widget.buildView(context, controller),
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
            : widget.buildView(context, controller);

    return BaseListener<T>(controller: controller, child: content);
  }
}
