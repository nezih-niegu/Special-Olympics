import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/session.dart';
import '../models/http_exception.dart';

class SessionProvider with ChangeNotifier{
    Future<List<SessionIndexResponseItem>> index(int clubId) async{
        final url = 'https://special-olympics-api.herokuapp.com/clubs/${clubId}/sessions';
        List<SessionIndexResponseItem> sessions = [];

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final sessionIndexResponse = json.decode(response.body) as List<dynamic>;

            sessionIndexResponse.forEach((sessionIndexResponseItem){
                sessions.add(SessionIndexResponseItem(
                    practiceActivity: sessionIndexResponseItem['practice']['activity'],
                    day: sessionIndexResponseItem['day'],
                    start: sessionIndexResponseItem['start'],
                    end: sessionIndexResponseItem['end']
                ));
            });
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return sessions;
    }
}