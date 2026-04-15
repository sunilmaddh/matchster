import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_font_type.dart';
import 'package:matchster/core/utils/extentions.dart';

class CustomTabBarView extends StatefulWidget {
  const CustomTabBarView({
    super.key,
    required this.tabWidgets,
    required this.tabBarWidgets,
    this.isNotRadius = false,
    this.tabController,
    this.onTabChanged,
  }) : assert(
         tabWidgets.length == tabBarWidgets.length,
         'tabWidgets and tabBarWidgets length must be same',
       );

  final List<Widget> tabWidgets;
  final List<Widget> tabBarWidgets;
  final bool isNotRadius;
  final TabController? tabController;
  final ValueChanged<int>? onTabChanged;

  @override
  State<CustomTabBarView> createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView>
    with SingleTickerProviderStateMixin {
  TabController? _internalController;

  TabController get _controller => widget.tabController ?? _internalController!;

  void _handleTabChanged() {
    if (!_controller.indexIsChanging) {
      widget.onTabChanged?.call(_controller.index);
    }
  }

  void _createInternalController() {
    _internalController = TabController(
      length: widget.tabWidgets.length,
      vsync: this,
    );
  }

  @override
  void initState() {
    super.initState();

    if (widget.tabController == null) {
      _createInternalController();
    }

    _controller.addListener(_handleTabChanged);
  }

  @override
  void didUpdateWidget(covariant CustomTabBarView oldWidget) {
    super.didUpdateWidget(oldWidget);

    final bool controllerChanged =
        oldWidget.tabController != widget.tabController;
    final bool lengthChanged =
        oldWidget.tabWidgets.length != widget.tabWidgets.length;

    if (controllerChanged) {
      oldWidget.tabController?.removeListener(_handleTabChanged);
      _internalController?.removeListener(_handleTabChanged);

      if (widget.tabController == null) {
        _internalController?.dispose();
        _createInternalController();
      } else {
        _internalController?.dispose();
        _internalController = null;
      }

      _controller.addListener(_handleTabChanged);
      return;
    }

    if (widget.tabController == null && lengthChanged) {
      _internalController?.removeListener(_handleTabChanged);
      _internalController?.dispose();
      _createInternalController();
      _internalController?.addListener(_handleTabChanged);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTabChanged);
    _internalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.filterHearderCardColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TabBar(
            controller: _controller,
            tabAlignment: TabAlignment.fill,
            isScrollable: false,
            labelStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              fontFamily: AppFonts.primary,
            ),
            labelPadding: EdgeInsets.zero,
            dividerColor: Colors.transparent,
            labelColor: AppColors.whiteColor,
            unselectedLabelColor: AppColors.whiteColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator:
                widget.isNotRadius
                    ? const BoxDecoration()
                    : BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(30),
                    ),
            tabs:
                widget.tabWidgets.map((tab) {
                  return Tab(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: tab,
                    ),
                  );
                }).toList(),
          ),
        ),
        SizedBox(height: 20.h),
        Expanded(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            children: widget.tabBarWidgets,
          ),
        ),
      ],
    );
  }
}
