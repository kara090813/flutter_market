import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:market/router/locations.dart';
import 'package:market/screens/auth_screen.dart';
import 'package:market/screens/splash_screen.dart';
import 'package:market/utils/logger.dart';

final _routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(beamLocations:[HomeLocation(),AuthLocation()]),
    guards:[
      BeamGuard(pathPatterns: ['/'], check: (context, location){
        logger.d(location);
        return false;
      },
      beamToNamed: (origin,target)=> '/auth')
    ]
);

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds:3),()=>100),
      builder: (context, snapshot) {
        return AnimatedSwitcher(duration:Duration(milliseconds:300),child: _splahLoadingWidget(snapshot));
      }
    );
  }

  StatelessWidget _splahLoadingWidget(AsyncSnapshot<Object?> snapshot) {
    if(snapshot.hasError){
      print("error occur while loading.");
      return Text('Error occur');
    }else if(snapshot.hasData){
      return TomatoApp();
    }else{
      return SplashScreen();
    }
  }

}

class TomatoApp extends StatelessWidget {
  const TomatoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser:BeamerParser() ,
      routerDelegate: _routerDelegate,
    );
  }
}



