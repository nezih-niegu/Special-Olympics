import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/picture.dart';
import '../models/http_exception.dart';

class PictureProvider with ChangeNotifier{
    Future<List<PictureIndexResponseItem>> index(int galleryId) async{
        final url = 'https://special-olympics-api.herokuapp.com/galleries/${galleryId}/pictures';
        List<PictureIndexResponseItem> pictures = [];

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final pictureIndexResponse = json.decode(response.body) as Map<String, dynamic>;

            (pictureIndexResponse['pictures'] as List<dynamic>).forEach((pictureIndexResponseItem){
                pictures.add(PictureIndexResponseItem(
                    id: pictureIndexResponseItem['id']
                ));
            });
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return pictures;
    }
}