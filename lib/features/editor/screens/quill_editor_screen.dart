import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:html_editor/common/constants/rawData/html_text.dart';
import 'package:html_editor/common/widgets/cst_alert.dart';

class QuillEditorScreen extends StatefulWidget {
  const QuillEditorScreen({Key? key}) : super(key: key);

  @override
  State<QuillEditorScreen> createState() => _QuillEditorScreenState();
}

class _QuillEditorScreenState extends State<QuillEditorScreen> {
  final quill.QuillController _controller = quill.QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  void _insertImage(String imageUrl) {
    print('insert image');
    final index = _controller.selection.baseOffset;
    _controller.replaceText(
      index,
      0,
      quill.BlockEmbed.image(imageUrl),
      TextSelection.collapsed(offset: index + 1),
    );
  }

  // Future<void> _pickImage() async {
  //   final pickedFile =
  //       await ImagePicker().getImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     final file = File(pickedFile.path);
  //     final imageUrl = await MyQuillToolbar().onImagePickCallback!(file);
  //     if (imageUrl != null) {
  //       _insertImage(imageUrl);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quill 편집기'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            quill.QuillToolbar(
              customButtons: const [
                quill.QuillCustomButton(icon: Icons.abc_outlined)
              ],
              children: [
                IconButton(
                    icon: const Icon(Icons.format_bold),
                    onPressed: () {
                      _controller.formatSelection(quill.Attribute.bold);
                    }),
                IconButton(
                    icon: const Icon(Icons.format_italic),
                    onPressed: () {
                      _controller.formatSelection(quill.Attribute.italic);
                    }),
                IconButton(
                    icon: const Icon(Icons.format_underline),
                    onPressed: () {
                      _controller.formatSelection(
                        quill.Attribute.underline,
                      );
                    }),
                IconButton(
                    icon: const Icon(Icons.format_list_bulleted),
                    onPressed: () {
                      _controller.formatSelection(quill.Attribute.ul);
                    }),
                IconButton(
                  icon: const Icon(Icons.format_list_numbered),
                  onPressed: () {
                    _controller.formatSelection(quill.Attribute.ol);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.format_quote),
                  onPressed: () {
                    _controller.formatSelection(quill.Attribute.blockQuote);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.code),
                  onPressed: () {
                    _controller.formatSelection(quill.Attribute.codeBlock);
                  },
                ),
                IconButton(icon: const Icon(Icons.link), onPressed: () {}
                    // _showLinkDialog,
                    ),
                IconButton(
                    icon: const Icon(Icons.do_disturb),
                    onPressed: () {
                      _insertImage;
                    }
                    // _pickImage,
                    ),
                IconButton(icon: const Icon(Icons.color_lens), onPressed: () {}
                    // _showColorDialog,
                    ),
                IconButton(icon: const Icon(Icons.highlight), onPressed: () {}
                    //  _showBackgroundColorDialog,
                    ),
              ],
            ),
            SizedBox(
              height: 300,
              child: quill.QuillEditor.basic(
                controller: _controller,
                readOnly: false, // true for view only mode
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
                IconButton(
                    icon: const Icon(Icons.do_disturb),
                    onPressed: () {
                      _insertImage;
                    }
                    // _pickImage,
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getMessageFromEditor() {
    Object contentJson = _controller.document.toDelta().toJson();
    print(contentJson);
    callDial(context, Text(contentJson.toString()));
  }

  // 이 방식은 HTML 콘텐츠를 에디터 안으로 불러올 방법 없음
  void sendMessageToEditor(text) {
    String html = (text);
    // List<dynamic> contentJson = jsonDecode(text);
    print(html);
    // _controller = quill.QuillController(
    //   document: quill.Document.fromJson(contentJson),
    //   selection: const TextSelection.collapsed(offset: 0),
    // );
    setState(() {});
  }
}
