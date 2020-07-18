import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Camera extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<Camera> {
  CameraController _controller;
  List<CameraDescription> _cameras;
  int _selectedCameraIndex;
  String _path;

  @override
  void initState() {
    super.initState();
    

    availableCameras().then((availableCams) {
      _cameras = availableCams;

      if(_cameras.length > 0) {
        setState(() {
          _selectedCameraIndex = 0;
        });
        _initCamera(_cameras[_selectedCameraIndex]).then((void v) {});
      } else {
        print('No camera available');
      }
    }).catchError((err){
      print('Error found:' + err.toString());
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initCamera(CameraDescription cameraDescription) async {
    if(_controller != null) {
      await _controller.dispose();
    }

     _controller = CameraController(_cameras[0], ResolutionPreset.medium);

     _controller.addListener(() {
       if(mounted) {
         setState(() {});
       }
     });

     if(_controller.value.hasError) {
       print('Camera error found:' + _controller.value.errorDescription.toString());
     }

     try {
       await _controller.initialize();
     } on CameraException catch(e) {
       String errorText = 'Error ${e.code} and DESCRIPTION: ${e.description}';
       print(errorText);
     }
  }

  Widget _cameraPreview() {
    if(_controller == null || !_controller.value.isInitialized) {
      return Text('Loading', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0));
    }

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: CameraPreview(_controller)
    );
  }

  Widget _cameraControlWidget(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "btn1",
              child: Icon(
                Icons.camera,
                color: Colors.black
              ),
              onPressed: () {
                _onCapture(context);
              },
            )
          ],
        )
      )
    );
  }

  Widget _cameraToggleRowWidget() {
    if(_cameras == null || _cameras.isEmpty) {
      return Spacer();
    }

    CameraDescription selectedCamera = _cameras[_selectedCameraIndex];
    CameraLensDirection cameraLensDirection = selectedCamera.lensDirection;
  }

  void _onCapture(context) async {
    try {
      var text = '';
      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now().toString()}.png'
      );

      print('Capture done:' + path.toString());

      await _controller.takePicture(path);
      // File croppedFile = await ImageCropper.cropImage(
      //   sourcePath: path,
      //   aspectRatioPresets: [
      //     CropAspectRatioPreset.square,
      //     CropAspectRatioPreset.ratio3x2,
      //     CropAspectRatioPreset.original,
      //     CropAspectRatioPreset.ratio4x3,
      //     CropAspectRatioPreset.ratio16x9
      //   ],
      //   androidUiSettings: AndroidUiSettings(
      //       toolbarTitle: '',
      //       toolbarColor: Colors.white,
      //       toolbarWidgetColor: Color(0xffF7395C),
      //       initAspectRatio: CropAspectRatioPreset.original,
      //       lockAspectRatio: false),
      //   iosUiSettings: IOSUiSettings(
      //     minimumAspectRatio: 1.0,
      //   )
      // );

      // visionImage = FirebaseVisionImage.fromFile(croppedFile);
      // var visionText = await textRecognizer.processImage(visionImage);

      // for (TextBlock block in visionText.blocks) {
      //   for (TextLine line in block.lines) {
      //     for (TextElement word in line.elements) {
      //       setState(() {
      //         text = text + word.text + ' ';
      //       });
      //     }
      //     // text = text + '\n';
      //   }
      // }

      // textRecognizer.close();
      print('final image checking now *************************** :' + text.toString());
      // Navigator.pop(context, text.toString());
      Navigator.pop(context);
      Navigator.pushNamed(context, '/analysis', arguments: path.toString());
    } catch(e) {
      print('Error while image capture:::' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height:  MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6)
                ),
                child: Container(
                    // width: MediaQuery.of(context).size.width - 120,
                    // height: MediaQuery.of(context).size.width - 100,
                    // decoration: BoxDecoration(
                    //   color: Colors.red
                    // ),
                    child: RotatedBox(
                      quarterTurns: MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 0,
                      child: _cameraPreview()
                    )
                  )
                ),
              Positioned(
                bottom: 0.0,
                left: (MediaQuery.of(context).size.width / 2) - 92,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 75.0,
                        width: 75.0,
                        margin: EdgeInsets.only(right: 14.0),
                        child: FloatingActionButton(
                          heroTag: "cameraCapture",
                          backgroundColor: Color(0xffF7395C),
                          child: Icon(
                            Icons.camera,
                            color: Colors.white,
                            size: 26.0,
                          ),
                          onPressed: () {
                            _onCapture(context);
                          },
                        ),
                      ),
                      Container(
                        height: 75.0,
                        width: 75.0,
                        child: FloatingActionButton(
                          heroTag: "cancelCapture",
                          backgroundColor: Color(0xffF7395C),
                          child: Icon(
                            Icons.cancel,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          onPressed: () {
                            // _onCapture(context);
                            Navigator.pop(context);
                          },
                        )
                      )
                    ],
                  )
                ),
              )
            ],
          )
        )
      )
    );
  }
}