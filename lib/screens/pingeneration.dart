import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:FinAcc/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/pinbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinGeneration extends StatefulWidget {

  const PinGeneration({
    Key? key}) : super(key: key);


  static const String routeName = '/pingeneration';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => PinGeneration(),
    );
  }
  @override
  State<PinGeneration> createState() => _PinGenerationState();
}

class _PinGenerationState extends State<PinGeneration> {
  @override
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<int> _Pin;

  TextEditingController pinController = new TextEditingController();

  String ToastMsg = "";
  bool errorpin = false;

  Future<void> _UpdatePin(int NewPin) async {
    print (NewPin);

    final SharedPreferences prefs = await _prefs;
    //final int Pin = (prefs.getInt('Pin') ?? 0) + 1;
    setState(() {
      _Pin = prefs.setInt('Pin', NewPin).then((bool success) {
        return NewPin;
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Pin = _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('Pin') ?? 0;
    });


    //print ("Pin" + _Pin.toString());

    // if (StoredPin.length > 0)
    // {
    //   for (var i=0;i<4;i++)
    //   {
    //     controllers[i].text = StoredPin.substring(i,1);
    //   }
    // }


  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Pin Generation"),
        backgroundColor: Colors.white, //background color of app bar
        foregroundColor: Colors.deepOrangeAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(50),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Generate 4 digit Pin here to Login to FinAcc App instead of entering username and password everytime while logging in"),
            ToastMsg == "" ? Text("") :
            AnimatedTextKit(
              animatedTexts: [
                RotateAnimatedText(
                  ToastMsg,
                  textStyle: const TextStyle(
                    color: Colors.green,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),

                ),
              ],
            ),
            errorpin
                ?Text("Pin must be four digits", style: TextStyle(color: Colors.red),)
                :Text(""),
            SizedBox(height: 30,),
            FutureBuilder<int>(
              future: _Pin,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      pinController.text = snapshot.data == 0 ? "" : snapshot.data.toString();
                      return
                        Center(
                          child: TextFormField(
                              controller: pinController,
                              style: TextStyle(color: Colors.grey, fontSize: 40),
                              cursorColor: Colors.purple,
                              textAlign: TextAlign.center,
                              maxLength: 4,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.green.withOpacity(.1),

                                hintText: 'PIN',
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.green,
                                ),

                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                    borderRadius: BorderRadius.circular(30)
                                        .copyWith(topRight: Radius.circular(30))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                    borderRadius: BorderRadius.circular(30)
                                        .copyWith(topRight: Radius.circular(30))),
                                contentPadding: EdgeInsets.all(23),
                              )),
                        );
                    }
                }
              }),

            SizedBox(height: 30,),

            SizedBox.fromSize(
              size: Size(156, 56),
              child: ClipRect(
                child: Material(
                  color: Colors.orange,
                  child: InkWell(
                    splashColor: Colors.green,
                    onTap: () {
                        if (pinController.text.length < 4)
                          {
                            errorpin = true;
                          }
                        else
                          {
                            errorpin = false;
                            _UpdatePin(int.parse(pinController.text)).then((value) => {
                                ToastMsg = "Login Pin updated Sucessfully",
                                Timer(Duration(seconds: 2), () =>  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                return Dashboard();
                                })) )
                            }) ;

                          }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.save,color: Colors.white,), // <-- Icon
                        SizedBox(width: 10,),
                        Text("Update PIN", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),), // <-- Text
                      ],
                    ),
                  ),
                ),
              ),
            )

    ],
        ),
      ),
    );
  }
}
