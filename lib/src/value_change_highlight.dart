import 'package:flutter/material.dart';
import 'package:smooth_highlight/smooth_highlight.dart';

/// If you want to highlight the widget only the value changed, [ValueChangeHighlight] is useful.
class ValueChangeHighlight<T> extends StatefulWidget {
  const ValueChangeHighlight({
    super.key,
    required this.value,
    required this.child,
    required this.color,
    this.enabled = true,
    this.disableFromValues,
    this.padding = EdgeInsets.zero,
    this.useInitialHighLight = false,
    this.duration = const Duration(milliseconds: 500),
  });

  /// The value change that triggers the highlight.
  ///
  /// It is implemented based on `operator==`, so it can be any primitive type.
  /// If you use your custom class, you should override `operator==` method.
  final T? value;

  /// The values you don't want to highlight.
  ///
  /// The values you set this property, [child] will not be highlighted when changes from these values.
  /// Ex. `disableValues: const [null, 2]` means that disable highlight if count changes from `null` or `2`.
  final List<T>? disableFromValues;
  final Widget child;
  final Color color;
  final bool enabled;
  final bool useInitialHighLight;
  final EdgeInsets padding;
  final Duration duration;

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
    if (_previousValue == widget.value || !widget.enabled) {
      _valueChanged = false;
      return;
    }

    final disableValues = widget.disableFromValues ?? [];
    _valueChanged = disableValues.contains(_previousValue) == false;
    _previousValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SmoothHighlight(
      enabled: _valueChanged,
      padding: widget.padding,
      color: widget.color,
      duration: widget.duration,
      child: widget.child,
    );
  }
}
