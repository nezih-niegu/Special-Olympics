import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/gallery.dart';
import '../models/http_exception.dart';

class GalleryProvider with ChangeNotifier{
    Future<List<GalleryIndexResponseItem>> index(int stateId) async{
        final url = 'https://special-olympics-api.herokuapp.com/states/${stateId}/galleries';
        List<GalleryIndexResponseItem> galleries = [];

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final galleryIndexResponse = json.decode(response.body) as Map<String, dynamic>;

            (galleryIndexResponse['galleries'] as List<dynamic>).forEach((galleryIndexResponseItem){
                galleries.add(GalleryIndexResponseItem(
                    id: galleryIndexResponseItem['id'],
                    name: galleryIndexResponseItem['name']
                ));
            });
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return galleries;
    }
}