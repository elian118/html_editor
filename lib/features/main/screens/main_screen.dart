import 'package:flutter/material.dart';
import 'package:html_editor/common/widgets/block_alert.dart';
import 'package:html_editor/features/editor/screens/html_editor_enhanced_screen.dart';
import 'package:html_editor/features/editor/screens/tiny_mobile_editor_screen.dart';
import 'package:html_editor/features/editor/screens/tiny_react_editor_screen.dart';
import 'package:html_editor/features/editor/screens/tiny_web_editor_screen.dart';
import 'package:html_editor/utils/utils.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('편집기 샘플 선택'),
      ),
      body: Center(
        child: Wrap(
          runSpacing: 10,
          spacing: 10,
          children: [
            ElevatedButton(
              onPressed: () => Utils.isWebScreen(context)
                  ? Utils.navPush(context, const TinyWebEditorScreen())
                  : showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('안내'),
                        content: const Text('모바일에서 제공되지 않습니다.'),
                        actions: [
                          TextButton(
                            onPressed: () => Utils.navPop(context),
                            child: const Text('닫기'),
                          )
                        ],
                      ),
                    ),
              child: const Text('타이니 웹 편집기'),
            ),
            ElevatedButton(
              onPressed: () => Utils.isWebScreen(context)
                  ? showDialog(
                      context: context,
                      builder: (context) => const BlockAlert(),
                    )
                  : Utils.navPush(context, const TinyMobileEditorScreen()),
              child: const Text('타이니 모바일 편집기(웹뷰)'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Utils.navPush(context, const HtmlEditorEnhancedScreen()),
              child: const Text('강화된 HTML 편집기(다트 패키지)'),
            ),
            ElevatedButton(
              onPressed: () => Utils.isWebScreen(context)
                  ? showDialog(
                      context: context,
                      builder: (context) => const BlockAlert(),
                    )
                  : Utils.navPush(context, const TinyReactEditorScreen()),
              child: const Text('리약트 타이니 편집기(웹뷰)'),
            ),
          ],
        ),
      ),
    );
  }
}
