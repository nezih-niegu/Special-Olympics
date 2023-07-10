import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/activity.dart';
import '../models/http_exception.dart';

class ActivityProvider with ChangeNotifier{
    Future<List<ActivityIndexResponseItem>> index(int stateId) async{
        final url = 'https://special-olympics-api.herokuapp.com/states/${stateId}/activities';
        List<ActivityIndexResponseItem> activities = [];

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final activityIndexResponse = json.decode(response.body) as Map<String, dynamic>;

            (activityIndexResponse['activities'] as List<dynamic>).forEach((activityIndexResponseItem){
                activities.add(ActivityIndexResponseItem(
                    id: activityIndexResponseItem['id'],
                    name: activityIndexResponseItem['name']
                ));
            });
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return activities;
    }

    Future<ActivityShowResponse> show(int id) async{
        final url = 'https://special-olympics-api.herokuapp.com/activities/${id}';
        ActivityShowResponse activity;

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final activityShowResponse = json.decode(response.body) as Map<String, dynamic>;

            activity = ActivityShowResponse(
                name: activityShowResponse['name'],
                description: activityShowResponse['description']
            );
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return activity;
    }
}