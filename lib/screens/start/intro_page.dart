import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../utils/logger.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('토마토마켓',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Theme.of(context).colorScheme.primary)),
            ExtendedImage.asset('assets/imgs/carrot_intro.png'),
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
              textAlign:TextAlign.center,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                    onPressed: () => {logger.d('button clicked')},
                    child: Text('내 동네 설정하고 시작하기',
                        style: Theme.of(context).textTheme.button),
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.all(13),
                        backgroundColor: Theme.of(context).colorScheme.primary))
              ],
            )
          ],
        ),
      ),
    );
  }
}
