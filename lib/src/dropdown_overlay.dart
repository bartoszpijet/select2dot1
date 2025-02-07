import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:select2dot1/src/components/overlay/dropdown_content_overlay.dart';
import 'package:select2dot1/src/controllers/search_controller.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/styles/overlay/dropdown_overlay_settings.dart';
import 'package:select2dot1/src/styles/pillbox_content_multi_settings.dart';
import 'package:select2dot1/src/styles/select_style.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class DropdownOverlay<T> extends StatefulWidget {
  final SelectDataController<T> selectDataController;
  final SearchControllerSelect2dot1<T> searchController;
  final Duration searchDealey;
  final void Function(BuildContext context) closeSelect;
  final AnimationController animationController;
  final LayerLink layerLink;
  final double? appBarMaxHeight;
  final ScrollController? scrollController;
  final PillboxLayout pillboxLayout;
  // Its okay.
  // ignore: prefer-correct-identifier-length
  final ScrollController? itemListScrollController;
  final DropdownContentOverlayBuilder<T>? dropdownContentOverlayBuilder;
  final DropdownOverlaySettings dropdownOverlaySettings;
  final bool isSearchable;
  final SearchBarOverlayBuilder<T>? searchBarOverlayBuilder;
  final LoaderBuilder? loaderBuilder;
  final SearchEmptyInfoBuilder? searchEmptyInfoBuilder;
  final ItemListBuilder<T>? itemListBuilder;
  final CategoryWidgetBuilder<T>? categoryBuilder;
  final ItemWidgetBuilder<T>? itemBuilder;
  final SelectStyle selectStyle;

  const DropdownOverlay({
    super.key,
    required this.selectDataController,
    required this.searchController,
    required this.searchDealey,
    required this.closeSelect,
    required this.animationController,
    required this.layerLink,
    required this.appBarMaxHeight,
    required this.scrollController,
    required this.pillboxLayout,
    required this.itemListScrollController,
    required this.dropdownContentOverlayBuilder,
    required this.dropdownOverlaySettings,
    required this.isSearchable,
    required this.searchBarOverlayBuilder,
    required this.loaderBuilder,
    required this.searchEmptyInfoBuilder,
    required this.itemListBuilder,
    required this.categoryBuilder,
    required this.itemBuilder,
    required this.selectStyle,
  });

  @override
  State<DropdownOverlay<T>> createState() => _DropdownOverlayState<T>();
}

class _DropdownOverlayState<T> extends State<DropdownOverlay<T>> {
  bool isBottomDirectAnchor = true;
  bool isCalcAnchorFinished = false;
  final keyDropdownOverlayContent = GlobalKey();
  Size sizeDropdownOverlayContent = const Size(0, 0);

  @override
  void initState() {
    super.initState();

    _calculateDropdownOverlayContentSize();
    _calculateDirectAnchor();
    widget.scrollController?.addListener(_calculateDirectAnchor);
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_calculateDirectAnchor);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: widget.layerLink.leaderSize?.width,
      child: CompositedTransformFollower(
        showWhenUnlinked: false,
        link: widget.layerLink,
        followerAnchor:
            isBottomDirectAnchor ? Alignment.topLeft : Alignment.bottomLeft,
        targetAnchor:
            isBottomDirectAnchor ? Alignment.bottomLeft : Alignment.topLeft,
        offset: widget.dropdownOverlaySettings.offset,
        child: Visibility(
          visible: isCalcAnchorFinished,
          maintainSize: true,
          maintainAnimation: true,
          maintainInteractivity: true,
          maintainSemantics: true,
          maintainState: true,
          child: NotificationListener<SizeChangedLayoutNotification>(
            // A little less pedantic style - its okey.
            // ignore: prefer-extracting-callbacks
            onNotification: (notification) {
              _calculateDropdownOverlayContentSize();
              _calculateDirectAnchor();

              return true;
            },
            /* child: SizeChangedLayoutNotifier( */
            child: Material(
              color: Colors.transparent,
              child: AnimatedBuilder(
                animation: widget.animationController,
                builder: (context, child) {
                  if (widget.dropdownOverlaySettings.animationBuilder != null) {
                    // Its can be null anyway.
                    // ignore: avoid-non-null-assertion
                    return widget.dropdownOverlaySettings.animationBuilder!(
                      context,
                      child,
                      widget.animationController,
                    );
                  }

                  return ScaleTransition(
                    scale: CurvedAnimation(
                      parent: widget.animationController,
                      curve: widget.dropdownOverlaySettings.sizeAnimationCurve,
                    ),
                    child: FadeTransition(
                      opacity: CurvedAnimation(
                        parent: widget.animationController,
                        curve:
                            widget.dropdownOverlaySettings.fadeAnimationCurve,
                      ),
                      child: child,
                    ),
                  );
                },
                child: TapRegion(
                  onTapOutside: (_) => widget.closeSelect(context),
                  child: DropdownContentOverlay(
                    key: keyDropdownOverlayContent,
                    selectDataController: widget.selectDataController,
                    searchController: widget.searchController,
                    searchDealey: widget.searchDealey,
                    closeSelect: widget.closeSelect,
                    layerLink: widget.layerLink,
                    scrollController: widget.scrollController,
                    appBarMaxHeight: widget.appBarMaxHeight,
                    itemListScrollController: widget.itemListScrollController,
                    dropdownContentOverlayBuilder:
                        widget.dropdownContentOverlayBuilder,
                    isSearchable: widget.isSearchable,
                    searchBarOverlayBuilder: widget.searchBarOverlayBuilder,
                    loaderBuilder: widget.loaderBuilder,
                    searchEmptyInfoBuilder: widget.searchEmptyInfoBuilder,
                    itemListBuilder: widget.itemListBuilder,
                    categoryBuilder: widget.categoryBuilder,
                    itemBuilder: widget.itemBuilder,
                    selectStyle: widget.selectStyle,
                  ),
                ),
              ),
            ),
            /* ), */
          ),
        ),
      ),
    );
  }

  bool _isFitBottom() {
    final offsetPillbox = widget.layerLink.leader?.offset ?? const Offset(0, 0);
    final heightPillbox = widget.layerLink.leaderSize?.height ?? 0;
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final scrolable = Scrollable.of(context);
    final contextOffset =
        (context.findRenderObject() as RenderBox).localToGlobal(Offset.zero);

    final layerOffset = (scrolable.context.findRenderObject() as RenderBox)
        .localToGlobal(Offset.zero);

    double viewDimension =
        widget.scrollController?.position.viewportDimension ??
            (scrolable.position.viewportDimension);
    final bottomSpace = mediaQueryHeight - viewDimension - layerOffset.dy;

    return offsetPillbox.dy +
            heightPillbox +
            sizeDropdownOverlayContent.height +
            contextOffset.dy -
            viewDimension -
            bottomSpace <=
        0;
  }

  bool _isFitTop() {
    final offsetPillbox = widget.layerLink.leader?.offset ?? const Offset(0, 0);
    final layerOffset =
        (Scrollable.of(context).context.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero);

    return offsetPillbox.dy +
            layerOffset.dy -
            sizeDropdownOverlayContent.height >
        0;
  }

  void _changeDirectAnchor() {
    if (mounted) {
      setState(() {
        isBottomDirectAnchor = !isBottomDirectAnchor;
      });
    }
  }

  void _calculateDirectAnchor() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (isBottomDirectAnchor) {
        if (!_isFitBottom() && _isFitTop()) {
          _changeDirectAnchor();
        }
      } else {
        if (!_isFitTop() && _isFitBottom()) {
          _changeDirectAnchor();
        }
      }
      if (!isCalcAnchorFinished) {
        if (mounted) {
          setState(() {
            isCalcAnchorFinished = true;
          });
        }
      }
    });
  }

  void _calculateDropdownOverlayContentSize() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      BuildContext? context = keyDropdownOverlayContent.currentContext;
      if (context != null) {
        if (mounted) {
          setState(() {
            sizeDropdownOverlayContent = context.size ?? const Size(0, 0);
          });
        }
      }
    });
  }
}
