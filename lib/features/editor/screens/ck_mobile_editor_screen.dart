import 'package:flutter/material.dart';
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
            // Wrap(
            //   alignment: WrapAlignment.center,
            //   spacing: 10,
            //   children: [
            //     ElevatedButton(
            //       onPressed: getMessageFromEditor,
            //       child: const Text("에디터로부터 HTML 콘텐츠 가져오기"),
            //     ),
            //     ElevatedButton(
            //       onPressed: () => sendMessageToEditor(htmlText),
            //       child: const Text("에디터로 HTML 콘텐츠 보내기"),
            //     ),
            //     ElevatedButton(
            //       onPressed: () => sendMessageToEditor(''),
            //       child: const Text("에디터 초기화"),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
