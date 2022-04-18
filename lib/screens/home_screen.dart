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
        actions:[IconButton(
          icon: Icon(Icons.logout,color: Colors.black,),
          onPressed: (){
          context.read<UserProvider>().setUserAuth(false);
        },)]
      ),
      body: Column(children: [

      ],),
    );
  }
}
