import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/safe/verify_page.dart';

class SafePage extends StatefulWidget {
  @override
  _SafePageState createState() => _SafePageState();
}

class _SafePageState extends State<SafePage> {
  bool success = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('验证码返回结果：$success'),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VerifyPage()));
                if (result == null) {
                  debugPrint('longer   返回结果为 >>> null');
                  return;
                }
                if (result != success) {
                  setState(() {
                    success = result;
                  });
                }
              },
              child: Text('登录'),
            )
          ],
        ),
      ),
    );
  }
}
