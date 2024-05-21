import 'package:flutter/material.dart';

class Room extends StatelessWidget {
  final String imageAssetPath;
  final int roomId;

  Room({required this.imageAssetPath, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageAssetPath),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class RoomDoor extends StatelessWidget {
  final int prevRoomId;

  RoomDoor({required this.prevRoomId});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2 - 20,
      left: 10,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back, color: Colors.red),
      ),
    );
  }
}

class NavigationButtons extends StatelessWidget {
  final int currentRoomId;

  NavigationButtons({required this.currentRoomId});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2 - 20,
      right: 10,
      child: Visibility(
        visible: currentRoomId != 4, // 特殊部屋ではない場合は表示
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                int nextRoomId = (currentRoomId + 1) % 4;
                return EscapeGameScreen(currentRoomId: nextRoomId);
              },
            ));
          },
          child: Icon(Icons.arrow_forward, color: Colors.red),
        ),
      ),
    );
  }
}

class ClickableArea extends StatelessWidget {
  final int currentRoomId;

  ClickableArea({required this.currentRoomId});

  @override
  Widget build(BuildContext context) {
    if (currentRoomId != 0) {
      return SizedBox.shrink(); // joy_roomでない場合は何も表示しない
    }
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EscapeGameScreen(
            currentRoomId: 4,
          ),
        ));
      },
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red.withOpacity(0.5),
        margin: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width / 2 - 50, 50, 0, 0), // 画像内のクリック領域を中央の少し左に配置
      ),
    );
  }
}

class EscapeGameScreen extends StatefulWidget {
  final int currentRoomId;

  EscapeGameScreen({required this.currentRoomId});

  @override
  _EscapeGameScreenState createState() => _EscapeGameScreenState();
}

class _EscapeGameScreenState extends State<EscapeGameScreen> {
  @override
  Widget build(BuildContext context) {
    final roomImages = [
      'assets/joy_room.jpg',
      'assets/sorrow_room.jpg',
      'assets/anger_room.jpg',
      'assets/fun_room.jpg',
      'assets/special_room.jpg', // 特殊部屋の画像
    ];

    final room = Room(
      imageAssetPath: roomImages[widget.currentRoomId],
      roomId: widget.currentRoomId,
    );

    final roomDoor = RoomDoor(prevRoomId: widget.currentRoomId - 1);
    final navigationButtons = NavigationButtons(currentRoomId: widget.currentRoomId);
    final clickableArea = ClickableArea(currentRoomId: widget.currentRoomId);

    return Scaffold(
      body: Stack(
        children: [
          room,
          if (widget.currentRoomId > 0) roomDoor, // 部屋が0以外の時にのみ表示
          navigationButtons,
          clickableArea, // joy_roomでのみ表示
          if (widget.currentRoomId == 4) SpecialRoom(), // 特殊部屋用のウィジェット
        ],
      ),
    );
  }
}

class SpecialRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 窓
        Positioned(
          top: 50,
          left: 50,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Image.asset('assets/window.jpg'),
                  );
                },
              );
            },
            child: Text('窓'),
          ),
        ),
        // ポスター
        Positioned(
          top: 50,
          right: 50,
          child: ElevatedButton(
            onPressed: () {
              showPosterDialog(context);
            },
            child: Text('ポスター'),
          ),
        ),
        // ゴミ箱
        Positioned(
          bottom: 50,
          left: 50,
          child: ElevatedButton(
            onPressed: () {
              showTrashDialog(context);
            },
            child: Text('ゴミ箱'),
          ),
        ),
        // ぬいぐるみ
        Positioned(
          bottom: 50,
          right: 50,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Image.asset('assets/teddy_bear.jpg'),
                  );
                },
              );
            },
            child: Text('ぬいぐるみ'),
          ),
        ),
        // 机
        Center(
          child: ElevatedButton(
            onPressed: () {
              showDeskDialog(context);
            },
            child: Text('机'),
          ),
        ),
      ],
    );
  }

  void showPosterDialog(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PosterScreen(),
    ));
  }

  void showTrashDialog(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TrashScreen(),
    ));
  }

  void showDeskDialog(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => DeskScreen(),
    ));
  }
}

class PosterScreen extends StatefulWidget {
  @override
  _PosterScreenState createState() => _PosterScreenState();
}

class _PosterScreenState extends State<PosterScreen> {
  int imageIndex = 0;
  final List<String> posterImages = [
    'assets/poster1.jpg',
    'assets/poster2.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: Image.asset(posterImages[imageIndex])),
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  imageIndex = (imageIndex + 1) % posterImages.length;
                });
              },
              child: Text('次へ'),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TrashScreen extends StatefulWidget {
  @override
  _TrashScreenState createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  int imageIndex = 0;
  final List<String> trashImages = [
    'assets/trash1.jpg',
    'assets/trash2.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: Image.asset(trashImages[imageIndex])),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  imageIndex = (imageIndex + 1) % trashImages.length;
                });
              },
              child: Text('次へ'),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DeskScreen extends StatefulWidget {
  @override
  _DeskScreenState createState() => _DeskScreenState();
}

class _DeskScreenState extends State<DeskScreen> {
  int imageIndex = 0;
  final List<String> deskImages = [
    'assets/desk1.jpg',
    'assets/desk2.jpg',
    'assets/desk3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: Image.asset(deskImages[imageIndex])),
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  imageIndex = (imageIndex == 0) ? 1 : 0;
                });
              },
              child: Text('左へ'),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  imageIndex = (imageIndex == 0) ? 2 : 0;
                });
              },
              child: Text('右へ'),
            ),
          ),
          Positioned(
            bottom: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,  // アプリケーション全体のテーマを設定
      ),
      home: EscapeGameScreen(currentRoomId: 0), // 最初の画面としてEscapeGameScreenを指定
    );
  }
}
