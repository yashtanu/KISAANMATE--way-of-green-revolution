import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kisaanmate/services/localization/app_translations.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {

  Future _getImage() async {
    Navigator.pop(context);
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (imageFile == null) {
      return;
    }

    print(imageFile.path);
    Navigator.pushNamed(context, '/analysis', arguments: imageFile.path.toString());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black, //or set color with: Color(0xFF0000FF)
    ));
    var _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Container(
        // padding: EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
            color: Color(0xFFF8F8F8)
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.red
                      ),
                      child: Text(AppTranslations.of(context).text('welcome_user'), style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Color(0xff888888)
                      )),
                    )
                  ]
                )
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 20, bottom: 10),
                        child: Container(
                          child: Text(AppTranslations.of(context).text('history'), style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          )),
                        )
                      ),
                      Expanded(
                        flex: 1,
                        child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (context, pos) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                // color: Colors.red
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/images/indiaflag.png')
                                      )
                                    )
                                  ),
                                  Text('Plant name')
                                ],
                              )
                            );
                            // Card(
                            //     color: Colors.red,
                            //     child: Padding(
                            //       padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                            //       child: Text('Data check here', style: TextStyle(
                            //         fontSize: 14.0,
                            //         // height: 1.6,
                            //       )
                            //     ),
                            //   )
                            // );
                          },
                        ) 
                      ),
                      // Container(
                      //   height: double.infinity,
                      //   child: ListView.builder(
                      //     itemCount: 2,
                      //     itemBuilder: (context, pos) {
                      //       return Padding(
                      //         padding: EdgeInsets.only(bottom: 16.0),
                      //         child: Card(
                      //           color: Colors.white,
                      //           child: Padding(
                      //             padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                      //             child: Text('Data check here', style: TextStyle(
                      //               fontSize: 18.0,
                      //               height: 1.6,
                      //             ),),
                      //           ),
                      //         )
                      //       );
                      //     },
                      //   )
                      // ),
                      Container(
                        // margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          // color: Colors.red 
                        ),
                        child: RaisedButton(
                          color: Color(0xff94CD48),
                          elevation: 3,
                          padding: EdgeInsets.symmetric(vertical: 22.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            // side: BorderSide(color: Color(0xff94CD48), width: 1.0)
                          ),
                          onPressed: () async {
                            // _showOTPDialog(context);
                            _settingModalBottomSheet(context, _getImage);
                          },
                          child: Container(
                            width: _screenWidth,
                            child: Text(AppTranslations.of(context).text('check_plant'),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white)
                            ) 
                          )
                        )
                      )
                    ],
                  ) 
                )
              )
            ],
          ),
        )
    );
  }
}

void _settingModalBottomSheet(context, callback) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc){
        return Container(
          child: new Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera),
              title: Text(AppTranslations.of(context).text('camera')),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/camera');
              }          
            ),
            ListTile(
              leading: Icon(Icons.picture_in_picture),
              title: Text(AppTranslations.of(context).text('gallery')),
              onTap: () {
                callback();
              },          
            ),
          ],
        ),
      );
    }
  );
}