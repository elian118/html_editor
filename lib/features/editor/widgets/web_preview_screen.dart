import 'dart:math';

import 'package:flutter/material.dart';
import 'package:html_editor/features/ui/fake_ui.dart'
    if (dart.library.html) 'package:html_editor/features/ui/real_ui.dart' as ui;
import 'package:universal_html/html.dart' as html;

class WebPreviewScreen extends StatefulWidget {
  final String? htmlString;
  const WebPreviewScreen({Key? key, this.htmlString}) : super(key: key);

  @override
  State<WebPreviewScreen> createState() => _WebPreviewScreenState();
}

class _WebPreviewScreenState extends State<WebPreviewScreen> {
  String createdViewId = Random().nextInt(1000).toString();
  late html.IFrameElement element;

  @override
  void initState() {
    element = html.IFrameElement()..src = widget.htmlString;
    ui.platformViewRegistry
        .registerViewFactory(createdViewId, (int viewId) => element);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
