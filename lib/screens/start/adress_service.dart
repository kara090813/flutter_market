import 'package:dio/dio.dart';
import 'package:market/constants/keys.dart';
import 'package:market/data/AddressModel.dart';
import 'package:market/data/AddressModelCoord.dart';

import '../../utils/logger.dart';

class AddressService {
  Future<AddressModel> searchAddressByStr(String text) async {
    final formData = {
      'key': VWORLD_KEY,
      'request': 'search',
      'size': 30,
      'query': text,
      'type': 'ADDRESS',
      'category': 'ROAD'
    };
    final response = await Dio()
        .get('http://api.vworld.kr/req/search', queryParameters: formData)
        .catchError((e) {
      logger.e(e.message);
    });

    AddressModel addressModel =
        AddressModel.fromJson(response.data["response"]);
    return addressModel;
  }

  Future<List<AddressModelCoord>> findAddressByCoordinate(
      double log, double lat) async {
    logger.d('$lat,$log');

    final List<Map<String, dynamic>> formDatas = [];

    formDatas.add({
      'service': 'address',
      'request': 'GetAddress',
      'point': "$log,$lat",
      'type': 'BOTH',
      'key': VWORLD_KEY
    });
    formDatas.add({
      'service': 'address',
      'request': 'GetAddress',
      'point': "${log - 0.01},$lat",
      'type': 'BOTH',
      'key': VWORLD_KEY
    });
    formDatas.add({
      'service': 'address',
      'request': 'GetAddress',
      'point': "${log + 0.01},$lat",
      'type': 'BOTH',
      'key': VWORLD_KEY
    });
    formDatas.add({
      'service': 'address',
      'request': 'GetAddress',
      'point': "$log,${lat + 0.01}",
      'type': 'BOTH',
      'key': VWORLD_KEY
    });
    formDatas.add({
      'service': 'address',
      'request': 'GetAddress',
      'point': "$log,${lat - 0.01}",
      'type': 'BOTH',
      'key': VWORLD_KEY
    });

    List<AddressModelCoord> address = [];

    for (Map<String, dynamic> formData in formDatas) {
      final response = await Dio()
          .get('http://api.vworld.kr/req/address', queryParameters: formData)
          .catchError((e) {
        logger.e(e.message);
      });

      if (response.data['status'] != "NOT_FOUND") {
        address.add(AddressModelCoord.fromJson(response.data['response']));
      }
    }

    return address;
  }
}
