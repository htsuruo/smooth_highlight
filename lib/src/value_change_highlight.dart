import 'package:flutter/material.dart';
import 'package:smooth_highlight/smooth_highlight.dart';

class ValueChangeHighlight<T> extends StatefulWidget {
  const ValueChangeHighlight({
    super.key,
    required this.value,
    required this.child,
    required this.highlightColor,
    this.allowFromNull = true,
    this.padding = EdgeInsets.zero,
    this.useInitialHighLight = false,
  });

  final T? value;
  final bool allowFromNull;
  final Widget child;
  final Color highlightColor;
  final bool useInitialHighLight;
  final EdgeInsets padding;

  @override
  State<ValueChangeHighlight> createState() => _ValueChangeHighlight<T>();
}

class _ValueChangeHighlight<T> extends State<ValueChangeHighlight>
    with SingleTickerProviderStateMixin {
  T? _previousValue;
  bool _valueChanged = false;

  @override
  void initState() {
    super.initState();
    _previousValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant ValueChangeHighlight oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_previousValue != widget.value) {
      if (_previousValue != null || widget.allowFromNull) {
        _valueChanged = true;
      }
      _previousValue = widget.value;
    } else {
      _valueChanged = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmoothHighlight(
      enabled: _valueChanged,
      padding: widget.padding,
      highlightColor: widget.highlightColor,
      child: widget.child,
    );
  }
}
