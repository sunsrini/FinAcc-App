import 'dart:async';
import 'package:FinAcc/screens/login.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  static const String routeName = '';
  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => Splash(),
    );
  }

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () =>  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Login();
    })) );

    return
      Scaffold(
        body:
      Container(
        margin: EdgeInsets.only(top: 200),
      color: Colors.white,
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.asset("assets/images/FinAcc.ico"),
          ],),
          SizedBox(height: 10,),
          Text("FinAcc", style: TextStyle(fontFamily: "Arial",fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 30),),
          SizedBox(height: 10,),
          Text("Gold Finance Software", style: TextStyle(fontFamily: "Arial",color: Colors.blue, fontSize: 25),),
          SizedBox(height: 150,),
          Text("Initializing...", style: TextStyle(fontSize: 16),)


      ],)

      ,
    )
        ,
      );
  }
}
