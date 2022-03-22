import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(16),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 30, minHeight: 24),
                hintText: '도로명으로 검색',
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 2.0,
                        color: Theme.of(context).colorScheme.primary))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton.icon(
                  onPressed: () => {},
                  icon: Icon(CupertinoIcons.compass,
                      color: Colors.white, size: 24),
                  label: Text(
                    '현재위치로 찾기',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.all(10)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('address ${index+1}'),
                    subtitle: Text('subtitle ${index + 1}'),
                  );
                },
                itemCount: 20),
          )
        ],
      ),
    );
  }
}
