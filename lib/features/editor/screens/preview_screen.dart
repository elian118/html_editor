import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_editor/common/constants/enums/breakpoints.dart';
import 'package:html_editor/common/widgets/web_container.dart';
import 'package:html_editor/utils/utils.dart';

class PreviewScreen extends StatelessWidget {
  final String? htmlString;
  const PreviewScreen({Key? key, this.htmlString}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('미리보기'),
      ),
      body: Utils.isWebScreen(context)
          ? WebContainer(
              padding: const EdgeInsets.symmetric(vertical: 20),
              maxWidth: Breakpoint.xl,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SingleChildScrollView(
                  child: Html(data: htmlString ?? "No data!"),
                ),
              ),
            )
          : SingleChildScrollView(child: Html(data: htmlString ?? "No data!")),
    );
  }
}
