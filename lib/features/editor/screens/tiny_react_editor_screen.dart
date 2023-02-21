import 'package:flutter/material.dart';
import 'package:html_editor/common/constants/rawData/local_url.dart';
import 'package:html_editor/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TinyReactEditorScreen extends StatefulWidget {
  const TinyReactEditorScreen({Key? key}) : super(key: key);

  @override
  State<TinyReactEditorScreen> createState() => _TinyReactEditorScreenState();
}

class _TinyReactEditorScreenState extends State<TinyReactEditorScreen> {
  bool isLoading = false;

  late WebViewController controller = WebViewController()
    ..setNavigationDelegate(NavigationDelegate(
      onProgress: (progress) => setState(() => isLoading = true),
      onWebResourceError: (err) => Utils.errHandler(context, err),
      onPageFinished: (url) => setState(() => isLoading = false),
    ))
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(localUrl));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('리액트 타이니 에디터'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 570,
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : WebViewWidget(controller: controller),
            ),
          ],
        ),
      ),
    );
  }
}
