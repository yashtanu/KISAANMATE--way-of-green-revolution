import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class OTP extends StatefulWidget {
  @override
  _OTP createState() => _OTP();
}

class _OTP extends State<OTP> {
  TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.black, //or set color with: Color(0xFF0000FF)
    // ));
    var _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.red
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  // color: Colors.red
                ),
                child: Text('Enter OTP', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xff888888)
                )),
              ),
              PinEntryTextField(
                showFieldAsBox: true,
                fieldWidth: 50.0,
                fields: 6,
                onSubmit: (String pin){
                  showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text("Pin"),
                        content: Text('Pin entered is $pin'),
                      );
                    }
                  );
                },
              )
            ],
          ),
        )
      )  
    );
  }
}