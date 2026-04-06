import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/base/base_listner.dart';

abstract class BaseViewTicker<T extends BaseController> extends StatefulWidget {
  const BaseViewTicker({super.key});

  Widget buildView(
    BuildContext context,
    T controller,
    AnimationController animationController,
  );

  void onInit(T controller, AnimationController animationController) {}
  void onReady(T controller, AnimationController animationController) {}
  void onDispose(T controller, AnimationController animationController) {}

  Duration get animationDuration => const Duration(milliseconds: 400);
  bool get autoStartAnimation => false;

  bool get useDefaultLoader => true;
  Color get loaderBarrierColor => Colors.black26;

  Widget buildLoader(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  @override
  State<BaseViewTicker<T>> createState() => _BaseViewTickerState<T>();
}

class _BaseViewTickerState<T extends BaseController>
    extends State<BaseViewTicker<T>>
    with SingleTickerProviderStateMixin {
  late final T controller;
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();

    controller = Get.find<T>();
    animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    widget.onInit(controller, animationController);

    if (widget.autoStartAnimation) {
      animationController.forward();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      widget.onReady(controller, animationController);
    });
  }

  @override
  void dispose() {
    widget.onDispose(controller, animationController);
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content =
        widget.useDefaultLoader
            ? Stack(
              children: [
                widget.buildView(context, controller, animationController),
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
            : widget.buildView(context, controller, animationController);

    return BaseListener<T>(controller: controller, child: content);
  }
}
