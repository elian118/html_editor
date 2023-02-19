import 'package:flutter/material.dart';
import 'package:html_editor/utils/utils.dart';

class WebContainer extends StatelessWidget {
  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
  final double? maxHeight;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  // final double? heightFactor;
  // final double? widthFactor;
  final AlignmentGeometry? alignment;

  const WebContainer({
    Key? key,
    this.child,
    this.padding,
    this.minWidth = 0,
    this.maxWidth = double.infinity,
    this.minHeight = 0,
    this.maxHeight = double.infinity,
    this.alignment = Alignment.topCenter,
    // this.heightFactor = 1,
    // this.widthFactor = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment!,
      child: Container(
        padding: padding,
        constraints: BoxConstraints(
          maxHeight: Utils.isWebScreen(context) ? maxHeight! : double.infinity,
          maxWidth: Utils.isWebScreen(context) ? maxWidth! : double.infinity,
        ),
        child: child,
      ),
    );
  }
}
