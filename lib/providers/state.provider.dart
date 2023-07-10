import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/state.dart';
import '../models/http_exception.dart';

class StateProvider extends ChangeNotifier{
    Future<List<StateIndexResponseItem>> index() async{
        const url = 'https://special-olympics-api.herokuapp.com/states';
        List<StateIndexResponseItem> states = [];

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final stateIndexResponse = json.decode(response.body) as List<dynamic>;

            stateIndexResponse.forEach((stateIndexResponseItem){
                states.add(StateIndexResponseItem(
                    id: stateIndexResponseItem['id'],
                    name: stateIndexResponseItem['name']
                ));
            });
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return states;
    }

    Future<StateContactShowResponse> showContact(int id) async{
        final url = 'https://special-olympics-api.herokuapp.com/states/${id}/contact';
        StateContactShowResponse state;

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final stateContactShowResponse = json.decode(response.body) as Map<String, dynamic>;

            state = StateContactShowResponse(
                email: evaluateContactString(stateContactShowResponse['email']),
                facebook: evaluateContactString(stateContactShowResponse['facebook']),
                instagram: evaluateContactString(stateContactShowResponse['instagram'])
            );
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return state;
    }

    String evaluateContactString(String contactString){
        if(contactString.length == 0 || contactString == 'null'){
            return null;
        }

        return contactString;
    }
}