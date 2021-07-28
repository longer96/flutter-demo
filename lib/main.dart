import 'package:flutter/material.dart';
import 'package:project/bottom/bottom_bar_page.dart';
import 'package:project/safe/safe_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(primaryColor: Colors.white, primarySwatch: Colors.orange),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: () => push(SafePage()),
            child: Text('拖动验证器'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => push(ButtomBarPage()),
            child: Text('有趣的底部导航'),
          ),
        ]),
      ),
    );
  }

  push(page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
