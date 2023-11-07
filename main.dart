import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Escape Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyEscapeRoom(),
    );
  }
}
class MyEscapeRoom extends StatefulWidget {
  const MyEscapeRoom({super.key});

  @override
  _EscapeRoomState createState() => _EscapeRoomState(); // 修正
}

class _EscapeRoomState extends State<MyEscapeRoom> {
  bool ballVisible = true; // ボールの表示状態を管理

  // ボールを取るアクション
  void takeBall() {
    setState(() {
      ballVisible = false; // ボールを非表示にする
    });
  }

  // ボールを置くアクション
  void placeBall() {
    setState(() {
      ballVisible = true; // ボールを表示する
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escape Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (ballVisible)
              GestureDetector(
                onTap: () {
                  // ボールをクリックしたときの処理
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: const Text('アクションを選んでください'),
                        children: <Widget>[
                          SimpleDialogOption(
                            onPressed: () {
                              // "取る" アクション
                              Navigator.pop(context);
                              takeBall();
                            },
                            child: const Text('取る'),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              // "置く" アクション
                              Navigator.pop(context);
                              placeBall();
                            },
                            child: const Text('置く'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  width: 50, // ボールの幅
                  height: 50, // ボールの高さ
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red, // ボールの色
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
