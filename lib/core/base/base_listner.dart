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
    _bindListeners();
  }

  @override
  void didUpdateWidget(covariant BaseListener<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      _disposeWorkers();
      _bindListeners();
    }
  }

  void _bindListeners() {
    _errorWorker = ever<String?>(widget.controller.errorMessage, (msg) {
      if (!mounted || msg == null || msg.trim().isEmpty) return;

      AppToastMessage.show(title: 'Error', message: msg, isError: true);
      widget.controller.clearError();
    });

    _successWorker = ever<String?>(widget.controller.successMessage, (msg) {
      if (!mounted || msg == null || msg.trim().isEmpty) return;

      AppToastMessage.show(title: 'Success', message: msg);
      widget.controller.clearSuccess();
    });

    _navigationWorker = ever<NavigationEvent?>(
      widget.controller.navigationEvent,
      (event) {
        if (!mounted || event == null) return;

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

  void _disposeWorkers() {
    _errorWorker?.dispose();
    _errorWorker = null;

    _successWorker?.dispose();
    _successWorker = null;

    _navigationWorker?.dispose();
    _navigationWorker = null;
  }

  @override
  void dispose() {
    _disposeWorkers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
