import 'package:flutter/material.dart';
import 'package:html_editor/common/constants/enums/breakpoints.dart';
import 'package:html_editor/common/constants/rawData/html_text.dart';
import 'package:html_editor/common/widgets/web_container.dart';
import 'package:html_editor/features/editor/screens/preview_screen.dart';
import 'package:html_editor/utils/utils.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class HtmlEditorEnhancedScreen extends StatefulWidget {
  const HtmlEditorEnhancedScreen({Key? key}) : super(key: key);

  @override
  State<HtmlEditorEnhancedScreen> createState() =>
      _HtmlEditorEnhancedScreenState();
}

class _HtmlEditorEnhancedScreenState extends State<HtmlEditorEnhancedScreen> {
  HtmlEditorController controller = HtmlEditorController();
  String? htmlString;

  void preview() async {
    String? tempTxt = await controller.getText();
    setState(() {
      htmlString = tempTxt;
    });
    Utils.navPush(context, PreviewScreen(htmlString: htmlString));
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: Text('미리보기'),
    //     content:
    //         SingleChildScrollView(child: Html(data: htmlString ?? "No data!")),
    //   ),
    // );
  }

  void sendMessageToEditor(String htmlText) {
    htmlText.isNotEmpty ? controller.insertHtml(htmlText) : controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('강화된 HTML 편집기'),
      ),
      body: Column(
        children: [
          Utils.isWebScreen(context)
              ? WebContainer(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  maxWidth: Breakpoint.xl,
                  child: HtmlEditor(
                    controller: controller, //required
                    htmlEditorOptions: const HtmlEditorOptions(
                      hint: "여기에 타이핑하세요...",
                      //initialText: "text content initial, if any",
                    ),
                    otherOptions: const OtherOptions(
                      height: 400,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: HtmlEditor(
                    controller: controller, //required
                    htmlEditorOptions: const HtmlEditorOptions(
                      hint: "여기에 타이핑하세요...",
                      //initialText: "text content initial, if any",
                    ),
                    otherOptions: const OtherOptions(
                      height: 400,
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
    );
  }
}
