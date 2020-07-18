import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kisaanmate/data/plants.dart';
import 'package:kisaanmate/services/localization/app_translations.dart';
import 'package:tflite/tflite.dart';

// ignore: must_be_immutable
class Analysis extends StatefulWidget {
  var argument;
  Analysis({ this.argument });
  @override
  _Analysis createState() => _Analysis(image: argument);
}

class _Analysis extends State<Analysis> {
  PlantsDataMapper plantsDataMapper;
  String image;
  _Analysis({ this.image });

  @override
  void initState() {
    super.initState();
    this.getImageResponse();
  }

  Future<dynamic> getImageResponse() async {
    print('Analysis initiated called');
    await Tflite.loadModel(
      model: "assets/models/model.tflite",
      labels: "assets/models/labels.txt",
      // numThreads: 1, // defaults to 1
      // isAsset: true, // defaults to true, set to false to load resources outside assets
      // useGpuDelegate: false // defaults to false, set to true to use GPU delegate
    );
    var output = await Tflite.runModelOnImage(path: image);
    Map map = output.first as Map;
    var label = map["label"];

    PlantsDataMapper res;
    for(var val in plantsList) {
      if(val['id'] == label) {
        res = PlantsDataMapper.fromJson(val);
      }
    }

    setState(() {
      plantsDataMapper = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.black, //or set color with: Color(0xFF0000FF)
    // ));
    // var _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 40, bottom: 20),
              decoration: BoxDecoration(
                color: Color(0xFFF8F8F8)
              ),
              child: image == null ? Text('No image') : Image.file(File(image))
            )
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                // color: Colors.red
              ),
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppTranslations.of(context).text('result'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppTranslations.of(context).text('plant_name_type'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(plantsDataMapper == null ? '' : plantsDataMapper.name)
                      ],
                    )
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppTranslations.of(context).text('disease_detected'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(plantsDataMapper == null ? '' : plantsDataMapper.id)
                      ],
                    )
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppTranslations.of(context).text('symptoms'), 
                          style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16,
                            height: 2
                            )
                          ),
                        Text(plantsDataMapper == null ? '' : plantsDataMapper.symptoms)
                      ],
                    )
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppTranslations.of(context).text('cause_comment'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(plantsDataMapper == null ? '' : '${plantsDataMapper.cause} - ${plantsDataMapper.comments}')
                      ],
                    )
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppTranslations.of(context).text('recommend_remedy'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(plantsDataMapper == null ? '' : plantsDataMapper.management)
                      ],
                    )
                  )
                ],
              ),
              )
            )
          )
        ],
      ),
      // body: Center(
      //   child: image == null ? Text('No image') : Image.file(File(image))
      // )
    );
  }
}