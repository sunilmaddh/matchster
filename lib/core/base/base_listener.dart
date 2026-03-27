import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/routes/app_navigation.dart';

class BaseListener<T extends BaseController> extends StatefulWidget {
  const BaseListener({
    super.key,
    required this.controller,
    required this.child,
  });

  final T controller;
  final Widget child;

  @override
  State<BaseListener<T>> createState() => _BaseListenerState<T>();
}

class _BaseListenerState<T extends BaseController>
    extends State<BaseListener<T>> {
  Worker? _errorWorker;
  Worker? _successWorker;
  Worker? _navigationWorker;

  @override
  void initState() {
    super.initState();

    _errorWorker = ever<String?>(widget.controller.errorMessage, (msg) {
      if (msg != null && msg.isNotEmpty) {
        AppToastMessage.show(title: 'Error', message: msg, isError: true);
        widget.controller.clearError();
      }
    });

    _successWorker = ever<String?>(widget.controller.successMessage, (msg) {
      if (msg != null && msg.isNotEmpty) {
        AppToastMessage.show(title: 'Success', message: msg);
        widget.controller.clearSuccess();
      }
    });

    _navigationWorker = ever<NavigationEvent?>(
      widget.controller.navigationEvent,
      (event) {
        if (event == null) return;

        switch (event.type) {
          case NavigationType.to:
            if (event.route != null) {
              AppNavigation.to(event.route!, arguments: event.arguments);
            }
            break;

          case NavigationType.off:
            if (event.route != null) {
              AppNavigation.off(event.route!, arguments: event.arguments);
            }
            break;

          case NavigationType.offAll:
            if (event.route != null) {
              AppNavigation.offAll(event.route!, arguments: event.arguments);
            }
            break;

          case NavigationType.back:
            Get.back(result: event.result);
            break;
        }

        widget.controller.clearNavigation();
      },
    );
  }

  @override
  void dispose() {
    _errorWorker?.dispose();
    _successWorker?.dispose();
    _navigationWorker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
