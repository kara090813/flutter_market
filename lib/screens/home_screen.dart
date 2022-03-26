import 'package:flutter/material.dart';
import 'package:market/states/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메인페이지'),
      ),
      body: Column(children: [
        Center(child: TextButton(onPressed: (){
          context.read<UserProvider>().setUserAuth(false);
        }, child:Text('로그아웃')))
      ],),
    );
  }
}
