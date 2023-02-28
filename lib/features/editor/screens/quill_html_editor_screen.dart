import 'package:flutter/material.dart';
import 'package:html_editor/common/constants/rawData/html_text.dart';
import 'package:html_editor/common/widgets/cst_alert.dart';
import 'package:html_editor/features/editor/screens/preview_screen.dart';
import 'package:html_editor/utils/utils.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class QuillHtmlEditorScreen extends StatefulWidget {
  const QuillHtmlEditorScreen({Key? key}) : super(key: key);

  @override
  State<QuillHtmlEditorScreen> createState() => _QuillHtmlEditorScreenState();
}

class _QuillHtmlEditorScreenState extends State<QuillHtmlEditorScreen> {
  late String text = "";
  late bool isEdit = true;
  final QuillEditorController _controller = QuillEditorController();

  void _onTextChange(value) {
    text = value;
    setState(() {});
  }

  void getMessageFromEditor() async {
    String? text = await _controller.getText();
    callDial(context, Text(text));
  }

  void sendMessageToEditor(String htmlText) {
    htmlText.isEmpty ? _controller.clear() : _controller.setText(htmlText);
  }

  void toggleEditMode() {
    isEdit = !isEdit;
    setState(() {});
  }

  // 표가 나타나지 않음, 새창으로 진입시 화면 깨짐
  void preview() async {
    String? text = await _controller.getText();
    if (!mounted) return;
    navPush(
      context,
      PreviewScreen(
        htmlString: text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('퀼 HTML 편집기'),
      ),
      body: Column(
        children: [
          if (isEdit)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ToolBar(
                    // toolBarColor: Colors.amber.withOpacity(0.7),
                    controller: _controller,
                    // iconColor: Colors.grey.shade500,
                    // activeIconColor: Colors.blue,
                  )
                ],
              ),
            ),
          QuillHtmlEditor(
            text: text,
            controller: _controller,
            hintText: '여기에 작성하세요.',
            height: MediaQuery.of(context).size.height - 450,
            isEnabled: isEdit,
            hintTextAlign: TextAlign.start,
            padding: EdgeInsets.zero,
            hintTextPadding: EdgeInsets.zero,
            onFocusChanged: _onTextChange,
            onTextChanged: _onTextChange,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: toggleEditMode,
                  child: Text(isEdit ? '편집모드' : '읽기모드'),
                ),
                ElevatedButton(
                  onPressed: preview,
                  child: const Text('미리보기'),
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
          ),
        ],
      ),
    );
  }
}
