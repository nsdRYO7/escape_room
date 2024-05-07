import 'package:flutter/material.dart';

void main() {
  runApp(EscapeGameApp());
}

class EscapeGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EscapeGameScreen(),
    );
  }
}

class EscapeGameScreen extends StatefulWidget {
  @override
  _EscapeGameScreenState createState() => _EscapeGameScreenState();
}

class _EscapeGameScreenState extends State<EscapeGameScreen> {
  int currentRoom = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildRoom(currentRoom),
          buildRoomDoor(),
          buildNavigationButtons(),
          buildClickableArea(),
        ],
      ),
    );
  }

  Widget buildRoom(int roomIndex) {
    List<String> roomImages = [
      'assets/joy_room.jpg',
      'assets/sorrow_room.jpg',
      'assets/anger_room.jpg',
      'assets/fun_room.jpg',
      'assets/special_room.jpg', // 特殊部屋の画像
    ];

    // 特殊部屋にいる場合は、特別なアクションを実行
    if (roomIndex == 4) {
      print('特殊部屋に入った！');
      // 特殊なアクションを実行する処理
      // ...
    }

    return GestureDetector(
      onTap: () {
        // 特殊部屋にいる場合は、何も処理しない
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(roomImages[roomIndex]),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget buildRoomDoor() {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2 - 20,
      left: 10,
      child: GestureDetector(
        onTap: () {
          int prevRoom = currentRoom - 1;
          if (prevRoom < 0) {
            prevRoom = 3; // 部屋の数 - 1
          }
          setState(() {
            currentRoom = prevRoom;
          });
        },
        child: Icon(Icons.arrow_back, color: Colors.red),
      ),
    );
  }

  Widget buildNavigationButtons() {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2 - 20,
      right: 10,
      child: Visibility(
        visible: currentRoom != 4, // 特殊部屋ではない場合は表示
        child: GestureDetector(
          onTap: () {
            int nextRoom = (currentRoom + 1) % 4; // 部屋の数
            setState(() {
              currentRoom = nextRoom;
            });
          },
          child: Icon(Icons.arrow_forward, color: Colors.red),
        ),
      ),
    );
  }

  Widget buildClickableArea() {
    return GestureDetector(
      onTap: () {
        // 画像内の特定の部分をクリックしたときの処理
        // 特殊部屋へ移動
        setState(() {
          currentRoom = 4; // 特殊部屋の番号
        });
      },
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red.withOpacity(0.5),
        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 4, 50, 0, 0), // 画像内のクリック領域
      ),
    );
  }
}
