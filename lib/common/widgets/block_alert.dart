import 'package:flutter/material.dart';
import 'package:html_editor/utils/utils.dart';

class BlockAlert extends StatelessWidget {
  const BlockAlert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('안내'),
      content: const Text('웹에서 제공되지 않습니다.'),
      actions: [
        TextButton(
          onPressed: () => Utils.navPop(context),
          child: const Text('닫기'),
        )
      ],
    );
  }
}
