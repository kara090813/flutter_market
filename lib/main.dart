import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:market/router/locations.dart';
import 'package:market/screens/auth_page.dart';
import 'package:market/screens/splash_screen.dart';
import 'package:market/states/user_provider.dart';
import 'package:market/utils/logger.dart';
import 'package:provider/provider.dart';

final _routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(beamLocations: [HomeLocation()]),
    guards: [
      BeamGuard(
          pathBlueprints: ['/'],
          check: (context, location) {
            return context.watch<UserProvider>().userState;
          },
          showPage: BeamPage(child: StartScreen()))
    ]);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 1), () => 100),
        builder: (context, snapshot) {
          return AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: _splahLoadingWidget(snapshot));
        });
  }

  StatelessWidget _splahLoadingWidget(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      print("error occur while loading.");
      return Text('Error occur');
    } else if (snapshot.hasData) {
      return TomatoApp();
    } else {
      return SplashScreen();
    }
  }
}

class TomatoApp extends StatelessWidget {
  const TomatoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (BuildContext context) {
        return UserProvider();
      },
      child: MaterialApp.router(
        theme: ThemeData(
          primarySwatch: Colors.red,
          secondaryHeaderColor: Colors.blue,
          hintColor: Colors.grey[350],
          fontFamily: 'DoHyeon',
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  primary: Colors.white,
                  minimumSize: Size(48, 48))),
          textTheme: TextTheme(
              button: TextStyle(color: Colors.white),
              headline5: TextStyle(color: Colors.black),
              subtitle1: TextStyle(height: 2.2, fontSize: 15)),
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 2,
              titleTextStyle: TextStyle(
                  color: Colors.black, fontSize: 22, fontFamily: 'DoHyeon')),
        ),
        routeInformationParser: BeamerParser(),
        routerDelegate: _routerDelegate,
      ),
    );
  }
}
