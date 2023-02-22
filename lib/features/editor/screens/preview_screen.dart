import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
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
          ? SingleChildScrollView(
              child: SizedBox(
                height: 600,
                child: HtmlWidget(
                  widget.htmlString ?? "No data!",
                ),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(
                  widget.htmlString ?? "No data!",
                ),
              ),
            ),
    );
  }
}
