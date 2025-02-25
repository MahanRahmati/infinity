import 'package:flutter/widgets.dart';

/// A lazy-loading version of IndexedStack that only builds children when they
/// are first displayed.
/// This helps improve performance by avoiding building all children upfront.
class ILazyIndexedStack extends StatefulWidget {
  /// Creates a lazy-loading indexed stack.
  ///
  /// [alignment] How to align the non-positioned and partially-positioned
  /// children in the stack.
  /// [textDirection] The text direction to use for [alignment].
  /// [clipBehavior] How to clip children that overflow the stack.
  /// [sizing] How to size the non-positioned children in the stack.
  /// [index] The index of the child to show.
  /// [children] The widgets below this widget in the tree.
  const ILazyIndexedStack({
    super.key,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.clipBehavior = Clip.hardEdge,
    this.sizing = StackFit.loose,
    this.index = 0,
    this.children = const <Widget>[],
  });

  /// How to align the non-positioned and partially-positioned children in the
  /// stack.
  final AlignmentGeometry alignment;

  /// The text direction to use for [alignment].
  final TextDirection? textDirection;

  /// How to clip children that overflow the stack.
  final Clip clipBehavior;

  /// How to size the non-positioned children in the stack.
  final StackFit sizing;

  /// The index of the child to show.
  final int index;

  /// The widgets below this widget in the tree.
  ///
  /// Each child will only be built when it becomes active for the first time.
  final List<Widget> children;

  @override
  ILazyIndexedStackState createState() => ILazyIndexedStackState();
}

/// State for [ILazyIndexedStack].
class ILazyIndexedStackState extends State<ILazyIndexedStack> {
  late List<bool> _activated = _initializeActivatedList();

  List<bool> _initializeActivatedList() {
    return List<bool>.generate(
      widget.children.length,
      (final int i) => i == widget.index,
    );
  }

  @override
  void didUpdateWidget(covariant final ILazyIndexedStack oldWidget) {
    if (oldWidget.children.length != widget.children.length) {
      _activated = _initializeActivatedList();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(final BuildContext context) {
    // Mark current index as active
    _activated[widget.index] = true;
    final List<Widget> children = List<Widget>.generate(_activated.length, (
      final int i,
    ) {
      return _activated[i] ? widget.children[i] : const SizedBox.shrink();
    });
    return IndexedStack(
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      clipBehavior: widget.clipBehavior,
      sizing: widget.sizing,
      index: widget.index,
      children: children,
    );
  }
}
