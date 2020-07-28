import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'camera.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projectazo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Initially display FirstPage
      home: MyHomePage(title: "Projectazo Home Page",),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _path = null;

  void _showCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePicturePage(camera: camera)
        )
    );

    setState(() {
      _path = result;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: (){},
            ),
            Text("Projectazo Homepage"),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
            ),
              onPressed: (){}
              ),
          ],
        ),
      ),
      body: Center(
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){ _showCamera();},
        child: Icon(Icons.camera),
      ),
    );
  }
}
