import 'dart:async';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class Camera extends StatefulWidget {
  final CameraDescription camera;

  const Camera({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<Camera> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    changeSystemColors(Colors.white, false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    changeSystemColors(Colors.black, true);
    AppBar appBar;
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: appBar = AppBar(
            backgroundColor: Colors.black,
            brightness: Brightness.dark,
            title: Text(
              'Zrób zdjęcie',
              style: TextStyle(
                  fontFamily: 'IndieFlower', color: Colors.white, fontSize: 32),
            ),
          ),
          // Wait until the controller is initialized before displaying the
          // camera preview. Use a FutureBuilder to display a loading spinner
          // until the controller has finished initializing.
          body: Stack(children: <Widget>[
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the Future is complete, display the preview.
                  return CameraPreview(_controller);
                } else {
                  // Otherwise, display a loading indicator.
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).size.width -
                        appBar.preferredSize.height -
                        kBottomNavigationBarHeight,
                    color: Colors.black))
          ]),
          floatingActionButton: FloatingActionButton(
            child: Container(
              width: 51,
              height: 51,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green[700], width: 2.0)),
              child: Icon(
                Icons.camera,
                color: Colors.green[700],
                size: 45.0,
              ),
            ),
            backgroundColor: Colors.green[300],
            onPressed: () async {
              try {
                await _initializeControllerFuture;
                final path = join(
                  (await getTemporaryDirectory()).path,
                  'lifefullaves${DateTime.now()}.png',
                );
                await _controller.takePicture(path);
                GallerySaver.saveImage(path);
                changeSystemColors(Colors.white, false);
                Navigator.pop(context, path);
              } catch (e) {
                print(e);
              }
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }

  Future<void> changeSystemColors(Color color, bool ifWhite) async {
    await FlutterStatusbarcolor.setNavigationBarColor(color);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(ifWhite);
  }

  Future<bool> _onWillPop() async {
    //sleep(Duration(milliseconds: 200));
    changeSystemColors(Colors.white, false);
    return true;
  }
}
