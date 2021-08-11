import 'package:flutter/material.dart';
import 'package:project/bottom/bottom1/bottom_1_page.dart';
import 'package:project/bottom/bottom10/bottom_10_page.dart';
import 'package:project/bottom/bottom11/bottom_11_page.dart';
import 'package:project/bottom/bottom2/bottom_2_page.dart';
import 'package:project/bottom/bottom3/bottom_3_page.dart';
import 'package:project/bottom/bottom4/bottom_4_page.dart';
import 'package:project/bottom/bottom5/bottom_5_page.dart';
import 'package:project/bottom/bottom6/bottom_6_page.dart';
import 'package:project/bottom/bottom7/bottom_7_page.dart';
import 'package:project/bottom/bottom8/bottom_8_page.dart';
import 'package:project/bottom/bottom9/bottom_9_page.dart';
import 'package:project/widget/my_app_bar.dart';

import 'bottom12/bottom_12_page.dart';

class ButtomBarPage extends StatefulWidget {
  @override
  _ButtomBarPageState createState() => _ButtomBarPageState();
}

class _ButtomBarPageState extends State<ButtomBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Bottom Bar'),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => push(Bottom6Page()),
                child: Text('Flutter 自带菜单'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => push(Bottom1Page()),
                child: Text('右侧展开菜单'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => push(Bottom8Page()),
                child: Text('向上展开菜单'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => push(Bottom5Page()),
                child: Text('半折扇菜单'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => push(Bottom2Page()),
                child: Text('山峦起伏菜单'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => push(Bottom4page()),
                child: Text('中间凹进去的菜单'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => push(Bottom3Page()),
                child: Text('底部菜单 仿B站'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => push(Bottom7Page()),
                child: Text('圆圈圈菜单'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => push(Bottom10Page()),
                child: Text('圆圈圈圈菜单'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => push(Bottom9Page()),
                child: Text('抖音、小红书'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => push(Bottom11Page()),
                child: Text('拉面菜单'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => push(Bottom12Page()),
                child: Text('salomon底部菜单'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  push(page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
