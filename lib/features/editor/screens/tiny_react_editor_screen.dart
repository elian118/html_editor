import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TinyReactEditorScreen extends StatefulWidget {
  const TinyReactEditorScreen({Key? key}) : super(key: key);

  @override
  State<TinyReactEditorScreen> createState() => _TinyReactEditorScreenState();
}

class _TinyReactEditorScreenState extends State<TinyReactEditorScreen> {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('http://localhost:5173'));

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
              height: MediaQuery.of(context).size.height - 300,
              child: WebViewWidget(controller: controller),
            ),
          ],
        ),
      ),
    );
  }
}
