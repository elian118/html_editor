import 'package:flutter/material.dart';
import 'package:html_editor/common/constants/rawData/html_text.dart';
import 'package:html_editor/features/editor/screens/preview_screen.dart';
import 'package:html_editor/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CkMobileEditorScreen extends StatefulWidget {
  const CkMobileEditorScreen({Key? key}) : super(key: key);

  @override
  State<CkMobileEditorScreen> createState() => _CkMobileEditorScreenState();
}

class _CkMobileEditorScreenState extends State<CkMobileEditorScreen> {
  bool isLoading = false;

  late WebViewController controller = WebViewController()
    ..setNavigationDelegate(NavigationDelegate(
      onProgress: (progress) => setState(() => isLoading = true),
      onPageFinished: (url) => setState(() => isLoading = false),
    ))
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadFlutterAsset('assets/html/ck_editor.html');

  // 웹뷰로는 JS 통신에서 기능적 한계 있음
  void getMessageFromEditor() async {
    Object htmlContent =
        await controller.runJavaScriptReturningResult('getContent()');
    // print(htmlContent);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('HTML 원본'),
        content: Text(htmlContent as String),
        actions: [
          TextButton(
            onPressed: () => Utils.navPop(context),
            child: const Text('닫기'),
          )
        ],
      ),
    );
  }

  // 단, 현재 플러터 RichText 패키지들은 테이블 입력 기능이 없는 듯 하다.
  void sendMessageToEditor(String text) async {
    // HTML 문자열 전송 시, 큰 따옴표("") 중복에 주의해야 한다.
    await controller.runJavaScript("""setContent('$text')""");
  }

  void preview() async {
    final String htmlContent =
        await controller.runJavaScriptReturningResult('getContent()') as String;
    Utils.navPush(
      context,
      PreviewScreen(
        htmlString: htmlContent,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CK 에디터(웹뷰)'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 400,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : WebViewWidget(
                        controller: controller,
                      ),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: preview,
                  child: const Text("미리보기"),
                ),
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
