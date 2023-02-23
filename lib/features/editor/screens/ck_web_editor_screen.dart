import 'dart:math';

import 'package:flutter/material.dart';
import 'package:html_editor/common/constants/rawData/html_text.dart';
import 'package:html_editor/features/ui/fake_ui.dart'
    if (dart.library.html) 'package:html_editor/features/ui/real_ui.dart' as ui;
import 'package:html_editor/utils/utils.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_html/js.dart' as js;

class CkWebEditorScreen extends StatefulWidget {
  const CkWebEditorScreen({Key? key}) : super(key: key);

  @override
  State<CkWebEditorScreen> createState() => _CkWebEditorScreenState();
}

class _CkWebEditorScreenState extends State<CkWebEditorScreen> {
  late js.JsObject connector;
  String createdViewId = Random().nextInt(1000).toString();
  late html.IFrameElement element;

  void getMessageFromEditor() {
    final String htmlContent = connector.callMethod(
      'getContent',
    ) as String;
    // print(str);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('HTML 원본'),
        content: Text(htmlContent),
        actions: [
          TextButton(
            onPressed: () => Utils.navPop(context),
            child: const Text('닫기'),
          )
        ],
      ),
    );
  }

  void sendMessageToEditor(String data) {
    element.contentWindow!.postMessage({
      'id': 'value',
      'msg': data,
    }, "*");
  }

  @override
  void initState() {
    js.context["connect_content_to_flutter"] = (js.JsObject content) {
      connector = content;
    };
    element = html.IFrameElement()
      // ..src = "/assets/editor.html"
      ..src = "/assets/html/ck_editor.html"
      ..style.border = 'none';

    ui.platformViewRegistry
        .registerViewFactory(createdViewId, (int viewId) => element);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CK 웹 편집기'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: getMessageFromEditor,
                    child: const Text("에디터로부터 HTML 콘텐츠 가져오기"),
                  ),
                  ElevatedButton(
                    onPressed: () => sendMessageToEditor(htmlText),
                    child: const Text("에디터로 HTML 콘텐츠 보내기"),
                  ),
                  ElevatedButton(
                    onPressed: () => sendMessageToEditor(''),
                    child: const Text("에디터 초기화"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                // height: 340,
                height: 600,
                child: HtmlElementView(
                  viewType: createdViewId,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}