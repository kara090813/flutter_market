import 'dart:developer';
import 'dart:ffi';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:market/states/user_provider.dart';

import '../../constants/common_size.dart';
import '../../utils/logger.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatelessWidget {
  PageController controller;

  IntroPage(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _test = ['a','b'];
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;

        final sizeOfPosImg = (size.width - 32) * 0.14;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: common_padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('토마토마켓',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
                SizedBox(
                  width: size.width - 32,
                  height: size.width - 32,
                  child: Stack(
                    children: [
                      ExtendedImage.asset('assets/imgs/carrot_intro.png'),
                      Positioned(
                          width: sizeOfPosImg,
                          left: (size.width - 32) * 0.43,
                          height: sizeOfPosImg,
                          top: (size.width - 32) * 0.43,
                          child: ExtendedImage.asset(
                            'assets/imgs/carrot_intro_pos.png',
                          )),
                    ],
                  ),
                ),
                Text(
                  '우리 동네 중고 직거래 토마토마켓',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.01),
                ),
                Text(
                  '토마토 마켓은 동네 직거래 마켓이에요.\n내 동네를 설정하고 시작해보세요!',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                        onPressed: () {
                          controller.animateToPage(1,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease);
                        },
                        child: Text('내 동네 설정하고 시작하기',
                            style: Theme.of(context).textTheme.button),
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.all(13),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
