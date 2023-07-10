import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/club.dart';
import '../models/http_exception.dart';

class ClubProvider with ChangeNotifier{
    Future<List<ClubIndexResponseItem>> index(int municipalityId) async{
        final url = 'https://special-olympics-api.herokuapp.com/municipalities/${municipalityId}/clubs';
        List<ClubIndexResponseItem> clubs = [];

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final clubIndexResponse = json.decode(response.body) as Map<String, dynamic>;

            (clubIndexResponse['clubs'] as List<dynamic>).forEach((clubIndexResponseItem){
                clubs.add(ClubIndexResponseItem(
                    id: clubIndexResponseItem['id'],
                    name: clubIndexResponseItem['name']
                ));
            });
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return clubs;
    }

    Future<ClubShowResponse> show(int id) async{
        final url = 'https://special-olympics-api.herokuapp.com/clubs/${id}';
        ClubShowResponse club;

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final clubShowResponse = json.decode(response.body) as Map<String, dynamic>;

            club = ClubShowResponse(
                id: clubShowResponse['id'],
                name: clubShowResponse['name'],
                contactName: clubShowResponse['contact_name'],
                contactEmail: clubShowResponse['contact_email'],
                availableSports: clubShowResponse['available_sports'],
                municipalityName: clubShowResponse['municipality_name'],
                galleryId: clubShowResponse['gallery_id']
            );
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return club;
    }

    Future<void> sendRequest(int stateId, ClubRequestSendRequest clubRequestSendRequest) async{
        final url = 'https://special-olympics-api.herokuapp.com/states/${stateId}/clubs';
        
        try{
            final response = await http.post(
                url,
                headers: {
                    HttpHeaders.contentTypeHeader: 'application/json'
                },
                body: json.encode({
                    'name': clubRequestSendRequest.name,
                    'phone': clubRequestSendRequest.phone,
                    'email': clubRequestSendRequest.email,
                    'about': clubRequestSendRequest.about,
                })
            );

            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }
    }
}