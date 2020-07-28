import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class TakePicturePage extends StatefulWidget {
  //Required argument Camera for taking photos :)
  final CameraDescription camera;
  TakePicturePage({@required this.camera});
  @override
  _TakePicturePageState createState() => _TakePicturePageState();
}

class _TakePicturePageState extends State<TakePicturePage> {
  CameraController _cameraController;
  Future<void> _initializeCameraControllerFuture;

  // Function to initializate camera controller with camera
  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(widget.camera, ResolutionPreset.high);
    _initializeCameraControllerFuture = _cameraController.initialize();
  }

  // Function to take a picture
  void _takePicture(BuildContext context) async {
    try {
      await _initializeCameraControllerFuture;
      final path = join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
      await _cameraController.takePicture(path);
      Navigator.pop(context,path);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      FutureBuilder(
      future: _initializeCameraControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(_cameraController);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ),
      SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              child: Icon(Icons.camera),
              onPressed: () {
                _takePicture(context);
              },
            ),
          ),
        ),
      )
  ]);
  }

}
