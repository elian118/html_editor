import 'package:flutter/material.dart';
import 'package:html_editor/utils/utils.dart';

void callDial(BuildContext context, Widget content, [bool isConfirm = false]) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('알림'),
      content: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 500,
          child: content,
        ),
      ),
      actions: isConfirm
          ? [
              TextButton(
                onPressed: () => Utils.navPop(context),
                child: const Text('확인'),
              ),
              TextButton(
                onPressed: () => Utils.navPop(context),
                child: const Text('취소'),
              )
            ]
          : [
              TextButton(
                onPressed: () => Utils.navPop(context),
                child: const Text('닫기'),
              )
            ],
    ),
  );
}
