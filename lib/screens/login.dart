import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kisaanmate/services/localization/app_translations.dart';
import 'package:kisaanmate/services/localization/application.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList = application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _searchController;
  String _phoneNo;
  String _verificationId;

  void onLocaleChange(Locale locale) async {
    setState(() {
      AppTranslations.load(locale);
    });
  }

  void _select(String language) {
    onLocaleChange(Locale(languagesMap[language]));
    // setState(() {
    //   if (language == "Hindi") {
    //     label = "हिंदी";
    //   } else {
    //     label = language;
    //   }
    // });
  }

  @override
  void initState() {
    super.initState();
    _searchController = new TextEditingController();
    application.onLocaleChanged = onLocaleChange;
    onLocaleChange(Locale(languagesMap["English"]));
  }

  Future<void> verifyPhoneNo() async {
    this._phoneNo = '+91${_searchController.text}';
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verID) {
      this._verificationId = verID;
    };

    final PhoneCodeSent codeSent = (String verID, [int forceCodeResent]) {
      this._verificationId = verID;
      _showOTPDialog(context, this._verificationId);
    };

    final PhoneVerificationCompleted verificationCompleted = (AuthCredential credentials) {
      //
    };

    final PhoneVerificationFailed verificationFailed = (AuthException exception) {
      final snackBar = new SnackBar(
        content: Text(exception.message),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xffaf3434)
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: this._phoneNo, 
      timeout: const Duration(seconds: 2), 
      verificationCompleted: verificationCompleted, 
      verificationFailed: verificationFailed, 
      codeSent: codeSent, 
      codeAutoRetrievalTimeout: autoRetrieve
    );
  } 

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.black, //or set color with: Color(0xFF0000FF)
    // ));
    var _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        backgroundColor: Color(0xFFF8F8F8),
        elevation: 0,
          title: new Text(
            '',
            style: new TextStyle(color: Colors.red),
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: _select,
              icon: new Icon(Icons.language, color: Color(0xFF808080)),
              itemBuilder: (BuildContext context) {
                return languagesList
                    .map<PopupMenuItem<String>>((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: _screenWidth,
              decoration: BoxDecoration(
                color: Color(0xFFF8F8F8),
                // borderRadius: BorderRadius.only(
                //   bottomLeft: Radius.circular(80),
                //   bottomRight: Radius.circular(80)
                // ) 
              ),
              child: Center(
                child: Container(
                  width: _screenWidth - 80,
                  height: _screenWidth - 80,
                  decoration: BoxDecoration(
                    // color: Colors.green,
                    image: new DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/images/kisaanmate.png')
                    ),
                    borderRadius: BorderRadius.circular(_screenWidth - 80)
                  ),
                ),
              )
            ),
          ),Expanded(
            flex: 1,
            child: Container(
              width: _screenWidth,
              decoration: BoxDecoration(
                // color: Colors.red
                color: Color(0xFFF8F8F8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20, right: 30, left: 30),
                    padding: EdgeInsets.only(right: 10, bottom: 10),
                    decoration: BoxDecoration(
                       border: Border.all(color: Color(0xFFE8E8E8)),
                       borderRadius: BorderRadius.circular(4) 
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                          child: Image(
                            width: 20,
                            image: AssetImage('assets/images/indiaflag.png')
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 16),
                          child: Text('+91 - '),
                        ),
                        Expanded(
                          child: TextField(
                            style: TextStyle(fontSize: 16.0),
                            controller: _searchController,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppTranslations.of(context).text('enter_mobile_no'),
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                  RaisedButton(
                    color: Color(0xff94CD48),
                    elevation: 4,
                    padding: EdgeInsets.symmetric(vertical: 22.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      // side: BorderSide(color: Colors.black, width: 1.0)
                    ),
                    onPressed: () {
                      // _showOTPDialog(context, '');
                      // print(_searchController.text.length);
                      if(_searchController.text.length < 10) {
                       final snackBar = new SnackBar(
                        content: Text(AppTranslations.of(context).text('invalid_mobile_entry')),
                        duration: Duration(seconds: 2),
                        backgroundColor: Color(0xffaf3434)
                      );
                      _scaffoldKey.currentState.showSnackBar(snackBar);
                      } else {
                        verifyPhoneNo();
                      }
                    },
                    child: Container(
                      width: _screenWidth - 60,
                      child: Text(AppTranslations.of(context).text('continue_mobile'),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white)
                      ) 
                    )
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     Icon(Icons.verified_user, color: Colors.red),
                    //     Text('Continue as Guest', style: TextStyle(color: Color(0xffF7395C)))
                    //   ],
                    // ),
                  )
                ],
              )
            ),
          )
        ],
      ),
    );
  }
}


void _showOTPDialog(context, verificationId) {
  var _dialogHeight = MediaQuery.of(context).size.height;
  var _screenWidth = MediaQuery.of(context).size.width;
  var _pinCode = '';
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
          return Container(
            padding: EdgeInsets.only(top: 10),
            height: _dialogHeight / 2,
          decoration: BoxDecoration(
            // color: Colors.red
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  // color: Colors.red
                ),
                child: Text(AppTranslations.of(context).text('enter_otp'), style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xff666666)
                )),
              ),
              PinEntryTextField(
                // showFieldAsBox: true,
                fieldWidth: 40.0,
                fields: 6,
                onSubmit: (String pin){
                  _pinCode = pin;
                  // showDialog(
                  //   context: context,
                  //   builder: (context){
                  //     return AlertDialog(
                  //       title: Text("Pin"),
                  //       content: Text('Pin entered is $pin'),
                  //     );
                  //   }
                  // );
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: RaisedButton(
                  color: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 22.0),
                  shape: RoundedRectangleBorder(
                    // borderRadius: BorderRadius.circular(4.0),
                    side: BorderSide(color: Color(0xff94CD48), width: 1.0)
                  ),
                  onPressed: () async {
                    // Navigator.pushNamed(context, '/otp');
                    // _showOTPDialog(context);
                    // print('_pinCode $_pinCode');

                    if(_pinCode == null || _pinCode == '') {
                      // Navigator.pushNamed(context, '/home');
                    } else {
                      FirebaseAuth.instance.currentUser().then((user) {    
                        if (user != null) {
                          // print('Nav from here:::');
                          Navigator.of(context).pop();    
                          Navigator.of(context).pushReplacementNamed('/home');    
                        } else {
                          // print('Nav from else part');
                          signIn(context, verificationId, _pinCode);
                        }    
                      });
                    }
                  },
                  child: Container(
                    width: _screenWidth - 60,
                    child: Text(AppTranslations.of(context).text('proceed'),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff94CD48))
                    ) 
                  )
                )
              )
            ],
          ),
        );
      }
    );
}


signIn(context, verificationId, smsOTP) async {
  // FirebaseAuth _auth = FirebaseAuth.instance; 
        try {
          // FirebaseAuth.instance.signInWithCredential(creds);
          // PhoneAuthProvider.getCredential(verificationId: null, smsCode: null)
          //   .then(()) 
            final AuthCredential credential = PhoneAuthProvider.getCredential(    
              verificationId: verificationId,    
              smsCode: smsOTP,    
            );
            await FirebaseAuth.instance.signInWithCredential(credential).then((user) => {
              // print('NAv from signin now:::')
              Navigator.of(context).pushReplacementNamed('/home')
              // FirebaseAuth.instance.currentUser().then((currentUser) => {
              //   if(user.uid == currentUser.uid); 
              // })
            });
            // final FirebaseUser user = await FirebaseAuth.instance.signInWithCredential(credential);    
            // final FirebaseUser currentUser = await _auth.currentUser();    
            // assert(user.uid == currentUser.uid); 
            // Navigator.of(context).pop();    
            // Navigator.of(context).pushReplacementNamed('/homepage');    
        } catch (e) {    
            // handleError(e);    
        }    
    }