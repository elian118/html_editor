import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html_editor/common/constants/enums/breakpoints.dart';
import 'package:html_editor/common/widgets/web_container.dart';
import 'package:html_editor/utils/utils.dart';

class PreviewScreen extends StatefulWidget {
  final String? htmlString;
  const PreviewScreen({Key? key, this.htmlString}) : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('미리보기'),
      ),
      body: Utils.isWebScreen(context)
          ? WebContainer(
              maxWidth: Breakpoint.lg,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  child: HtmlWidget(
                    widget.htmlString ?? "No data!",
                  ),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                child: HtmlWidget(
                  widget.htmlString ?? "No data!",
                ),
              ),
            ),
    );
  }
}
