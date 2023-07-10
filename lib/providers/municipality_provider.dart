import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/municipality.dart';
import '../models/http_exception.dart';

class MunicipalityProvider with ChangeNotifier{
    Future<List<MunicipalityIndexResponseItem>> index(int stateId) async{
        final url = 'https://special-olympics-api.herokuapp.com/states/${stateId}/municipalities';
        List<MunicipalityIndexResponseItem> municipalities = [];

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final municipalityIndexResponse = json.decode(response.body) as List<dynamic>;

            municipalityIndexResponse.forEach((municipalityIndexResponseItem){
                municipalities.add(MunicipalityIndexResponseItem(
                    id: municipalityIndexResponseItem['id'],
                    name: municipalityIndexResponseItem['name']
                ));
            });
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return municipalities;
    }
}