import 'package:flutter/material.dart';
import 'package:html_editor/common/constants/enums/breakpoints.dart';
import 'package:html_editor/common/constants/rawData/local_url.dart';
import 'package:html_editor/common/widgets/block_alert.dart';
import 'package:html_editor/common/widgets/cst_alert.dart';
import 'package:html_editor/common/widgets/web_container.dart';
import 'package:html_editor/features/editor/screens/ck_mobile_editor_screen.dart';
import 'package:html_editor/features/editor/screens/ck_web_editor_screen.dart';
import 'package:html_editor/features/editor/screens/html_editor_enhanced_screen.dart';
import 'package:html_editor/features/editor/screens/quill_editor_screen.dart';
import 'package:html_editor/features/editor/screens/quill_html_editor_screen.dart';
import 'package:html_editor/features/editor/screens/tiny_mobile_editor_screen.dart';
import 'package:html_editor/features/editor/screens/tiny_react_editor_screen.dart';
import 'package:html_editor/features/editor/screens/tiny_web_editor_screen.dart';
import 'package:html_editor/features/main/widgets/editor_type.dart';
import 'package:html_editor/utils/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void showErrorDialog(String errMsg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('에러'),
        content: Text(errMsg),
        actions: [
          TextButton(
              onPressed: () => Utils.navPop(context), child: const Text('닫기')),
        ],
      ),
    );
  }

  void launchBrowser(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        url,
        mode: LaunchMode.inAppWebView,
        webOnlyWindowName: '리액트 타이니 편집기(URL 런처)',
        webViewConfiguration: const WebViewConfiguration(
          enableDomStorage: true,
          enableJavaScript: true,
        ),
      );
    } else {
      showErrorDialog('브라우저에서 $url 열기 실패');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('편집기 샘플 선택'),
      ),
      body: WebContainer(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        maxWidth: Breakpoint.sm,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              runSpacing: 10,
              children: [
                const EditorType(title: 'CK 에디터'),
                ElevatedButton(
                  onPressed: () => Utils.isWebScreen(context)
                      ? Utils.navPush(context, const CkWebEditorScreen())
                      : callDial(context, const Text('모바일에서 제공되지 않습니다.')),
                  child: const Text('CK 웹 편집기'),
                ),
                ElevatedButton(
                  onPressed: () => !Utils.isWebScreen(context)
                      ? Utils.navPush(context, const CkMobileEditorScreen())
                      : callDial(context, const Text('웹에서 제공되지 않습니다.')),
                  child: const Text('CK 모바일 편집기'),
                ),
                const Divider(
                  thickness: 2,
                ),
                const EditorType(title: '타이니 MCE 에디터'),
                ElevatedButton(
                  onPressed: () => Utils.isWebScreen(context)
                      ? Utils.navPush(context, const TinyWebEditorScreen())
                      : callDial(context, const Text('모바일에서 제공되지 않습니다.')),
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
                const Divider(
                  thickness: 2,
                ),
                const EditorType(title: '다트 패키지 엄선 3종'),
                ElevatedButton(
                  onPressed: () =>
                      Utils.navPush(context, const QuillHtmlEditorScreen()),
                  child: const Text('퀼 HTML 편집기(다트 패키지)'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Utils.navPush(context, const HtmlEditorEnhancedScreen()),
                  child: const Text('강화된 HTML 편집기(다트 패키지)'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Utils.navPush(context, const QuillEditorScreen()),
                  child: const Text('퀼 편집기(다트 패키지)'),
                ),
                const Divider(
                  thickness: 2,
                ),
                const EditorType(title: '리액트 연동 사례'),
                ElevatedButton(
                  onPressed: () => Utils.isWebScreen(context)
                      ? showDialog(
                          context: context,
                          builder: (context) => const BlockAlert(),
                        )
                      : Utils.navPush(context, const TinyReactEditorScreen()),
                  child: const Text('리액트 타이니 편집기(웹뷰)'),
                ),
                ElevatedButton(
                  onPressed: () => launchBrowser(localUrl),
                  child: const Text('리액트 타이니 편집기(URL 런처)'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
