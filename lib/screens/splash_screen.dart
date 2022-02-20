import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.white,
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ExtendedImage.asset('assets/imgs/carrot_intro_pos.png'),
              Container(height: 50,color: Colors.transparent,),
              CircularProgressIndicator(
                  color:Colors.red
              )
            ],
          )),
    );
  }
}

