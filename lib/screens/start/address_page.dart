import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:market/data/AddressModelCoord.dart';
import 'package:market/screens/start/adress_service.dart';

import '../../constants/common_size.dart';
import '../../data/AddressModel.dart';
import '../../utils/logger.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController _addressController = TextEditingController();

  String _lastinput = 'none';
  AddressModel? _addressModel;
  List<AddressModelCoord>? _addressModelCoord;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(common_padding),
      child: Column(
        children: [
          TextFormField(
            controller: _addressController,
            onChanged: (text) async {
              _addressModel = await AddressService().searchAddressByStr(text);
              _lastinput = 'keyboard';
              setState(() {});
            },
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 30, minHeight: 24),
                hintText: '도로명으로 검색',
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
                  onPressed: () async {

                    Location location = new Location();

                    bool _serviceEnabled;
                    PermissionStatus _permissionGranted;
                    LocationData _locationData;

                    _serviceEnabled = await location.serviceEnabled();
                    if (!_serviceEnabled) {
                      _serviceEnabled = await location.requestService();
                      if (!_serviceEnabled) {
                        return;
                      }
                    }

                    _permissionGranted = await location.hasPermission();
                    if (_permissionGranted == PermissionStatus.denied) {
                      _permissionGranted = await location.requestPermission();
                      if (_permissionGranted != PermissionStatus.granted) {
                        return;
                      }
                    }

                    _locationData = await location.getLocation();
                    _addressModelCoord = await AddressService()
                        .findAddressByCoordinate(
                            _locationData.longitude!, _locationData.latitude!);
                    _lastinput = 'coord';

                    logger.d(_addressModelCoord);

                    setState(() {});
                  },
                  icon: Icon(CupertinoIcons.compass,
                      color: Colors.white, size: 24),
                  label: Text(
                    '현재위치로 찾기',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _lastinput == 'none'
                ? Container()
                : _lastinput == 'keyboard'
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          if (_addressModel == null ||
                              _addressModel!.result == null ||
                              _addressModel!.result!.items == null ||
                              _addressModel!.result!.items![index]!.address ==
                                  null) {
                            return Container();
                          }
                          return ListTile(
                            title: Text(_addressModel!
                                    .result!.items![index]!.address!.road ??
                                ""),
                            subtitle: Text(_addressModel!
                                    .result!.items![index]!.address!.parcel ??
                                ""),
                          );
                        },
                        itemCount: (_addressModel == null ||
                                _addressModel!.result == null ||
                                _addressModel!.result!.items == null)
                            ? 0
                            : _addressModel!.result!.items!.length)
                    : ListView.builder(itemBuilder: (context,index){
                      if(_addressModelCoord == null){
                        return Container(
                          child: Text('결과 없음'),
                        );
                      }
                      return ListTile(
                        title:Text(_addressModelCoord![index].result![0]!.text??""),
                        subtitle:_addressModelCoord![index].result!.length > 1 ? Text(_addressModelCoord![index].result![1]!.text??"") : Text('도로명 주소 없음') ,
                      );
            },itemCount:(_addressModelCoord!.length == 0 ) ? 1 : _addressModelCoord!.length),
          )
        ],
      ),
    );
  }
}
