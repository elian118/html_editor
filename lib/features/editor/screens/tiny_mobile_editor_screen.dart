import 'package:flutter/material.dart';
import 'package:html_editor/common/constants/rawData/html_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TinyMobileEditorScreen extends StatefulWidget {
  const TinyMobileEditorScreen({Key? key}) : super(key: key);

  @override
  State<TinyMobileEditorScreen> createState() => _TinyMobileEditorScreenState();
}

class _TinyMobileEditorScreenState extends State<TinyMobileEditorScreen> {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadFlutterAsset('assets/html/tiny_editor.html');

  // 웹뷰로는 JS 통신에서 기능적 한계 있음
  void getMessageFromEditor() async {
    Object htmlContent =
        await controller.runJavaScriptReturningResult('getValue()');
    // print(htmlContent);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('HTML 원본'),
        content: Text(htmlContent as String),
        // actions: [
        //   TextButton(
        //     onPressed: () => Utils.navPop(context),
        //     child: const Text('닫기'),
        //   )
        // ],
      ),
    );
  }

  // 예외 -> 작동 안 됨. 플러터와 상호작용할 수 있는 에디터 사용 바람 ex. flutter quill
  // 단, 현재 플러터 RichText 는 테이블 기능이 없는 듯 하다.
  void sendMessageToEditor(String s) async {
    // print(s);
    controller.runJavaScriptReturningResult('setHtmlContent($s)');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TinyMCE'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 400,
                child: WebViewWidget(
                  controller: controller,
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
