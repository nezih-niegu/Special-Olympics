import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/coach.dart';
import '../models/http_exception.dart';

class CoachProvider with ChangeNotifier{
    Future<List<CoachIndexResponseItem>> index(int sportId) async{
        final url = 'https://special-olympics-api.herokuapp.com/sports/${sportId}/coaches';
        List<CoachIndexResponseItem> coaches = [];

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final coachIndexResponse = json.decode(response.body) as List<dynamic>;

            coachIndexResponse.forEach((coachIndexResponseItem){
               coaches.add(CoachIndexResponseItem(
                   id: coachIndexResponseItem['id'],
                   name: coachIndexResponseItem['name'],
                   email: coachIndexResponseItem['email'],
                   phone: coachIndexResponseItem['phone']
               ));
            });

        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return coaches;
    }
}