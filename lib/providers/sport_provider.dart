import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as syspaths;

import '../models/sport.dart';
import '../models/http_exception.dart';

class SportProvider with ChangeNotifier{
    Future<List<SportIndexResponseItem>> index(int stateId) async{
        final url = 'https://special-olympics-api.herokuapp.com/states/${stateId}/sports';
        List<SportIndexResponseItem> sports = [];

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final sportIndexResponse = json.decode(response.body) as Map<String, dynamic>;
            
            (sportIndexResponse['sports'] as List<dynamic>).forEach((sportIndexResponseItem){
                sports.add(SportIndexResponseItem(
                    id: sportIndexResponseItem['id'],
                    name: sportIndexResponseItem['name']
                ));
            });
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return sports;
    }

    Future<SportShowResponse> show(int id) async{
        final url = 'https://special-olympics-api.herokuapp.com/sports/${id}';
        SportShowResponse sport;

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final sportShowResponse = json.decode(response.body) as Map<String, dynamic>;

            sport = SportShowResponse(
                id: sportShowResponse['id'],
                name: sportShowResponse['name'],
                description: sportShowResponse['description'],
                notes: sportShowResponse['notes'],
                contactName: sportShowResponse['contact_name'],
                contactEmail: sportShowResponse['contact_email'],
                contactPhone: sportShowResponse['contact_phone'],
                locations: sportShowResponse['locations'],
                galleryId: sportShowResponse['gallery_id']
            );
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return sport;
    }

    Future<void> showManual(int id, String name) async{
        final url = 'http://special-olympics-api.herokuapp.com/sports/${id}/manual';

        try{
            final response = await http.get(url);
            final appDir = await syspaths.getExternalStorageDirectory();
            final file = File('${appDir.path}/${name}.pdf');
            await file.writeAsBytes(response.bodyBytes);
        }catch(error){
            print(error.toString());
        }
    }
}