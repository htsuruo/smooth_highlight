import 'package:flutter/material.dart';

class SmoothHighlight extends StatefulWidget {
  const SmoothHighlight({
    super.key,
    required this.child,
    required this.highlightColor,
    this.enabled = true,
    this.padding = EdgeInsets.zero,
    this.useInitialHighLight = false,
  });

  final Widget child;
  final Color highlightColor;
  final bool enabled;
  final bool useInitialHighLight;
  final EdgeInsets padding;

  @override
  State<SmoothHighlight> createState() => _SmoothHighlightState();
}

class _SmoothHighlightState extends State<SmoothHighlight>
    with SingleTickerProviderStateMixin {
  String? previousValue;
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  late final Animation<Decoration> _animation = _animationController
      .drive(
        CurveTween(curve: Curves.easeInOut),
      )
      .drive(
        DecorationTween(
          begin: const BoxDecoration(),
          end: BoxDecoration(
            color: widget.highlightColor,
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
    if (widget.useInitialHighLight) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animationController.forward();
      });
    }
    _animation.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future<void>.delayed(const Duration(milliseconds: 200));
        await _animationController.reverse();
      }
    });
  }

  @override
  void didUpdateWidget(covariant SmoothHighlight oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = Padding(padding: widget.padding, child: widget.child);

    return widget.enabled
        ? DecoratedBoxTransition(
            decoration: _animation,
            child: child,
          )
        : child;
  }
}
