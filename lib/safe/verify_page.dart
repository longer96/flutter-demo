import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/safe/safe_verify.dart';

class VerifyPage extends StatefulWidget {
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool success = false;

  @override
  Widget build(BuildContext context) {
    /// 禁用侧滑
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress)
          return false;
        else
          return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Text('安全验证', style: TextStyle(fontSize: 30)),
              const SizedBox(height: 20),
              const Text('为了你的账号安全，本次登录需要进行验证'),
              const Text('请将下方的图标移动到圆形区域内'),
              const SizedBox(height: 20),
              Expanded(
                child: DemoVerity(lister: (state) {
                  debugPrint('longer   返回状态>>> $state');
                  if (state) {
                    Navigator.pop(context, true);
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
