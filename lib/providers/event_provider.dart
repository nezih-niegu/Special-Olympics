import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/event.dart';
import '../models/http_exception.dart';

class EventProvider with ChangeNotifier{
    Future<List<EventIndexResponseItem>> index(int stateId) async{
        final url = 'https://special-olympics-api.herokuapp.com/states/${stateId}/events';
        List<EventIndexResponseItem> events =  [];

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final eventIndexResponse = json.decode(response.body) as List<dynamic>;

            eventIndexResponse.forEach((eventIndexResponseItem){
                events.add(EventIndexResponseItem(
                    id: eventIndexResponseItem['id'],
                    name: eventIndexResponseItem['name'],
                    start: DateTime.parse(eventIndexResponseItem['start']),
                    end: DateTime.parse(eventIndexResponseItem['end'])
                ));
            });
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return events;
    }

    Future<EventShowResponse> show(int id) async{
        final url = 'https://special-olympics-api.herokuapp.com/events/${id}';
        EventShowResponse event;

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final eventShowResponse = json.decode(response.body) as Map<String, dynamic>;

            event = EventShowResponse(
                name: eventShowResponse['name'],
                description: eventShowResponse['description'],
                start: DateTime.parse(eventShowResponse['start']),
                end: DateTime.parse(eventShowResponse['end']),
                location: eventShowResponse['location'],
                contactEmail: eventShowResponse['contact_email'],
                type: eventShowResponse['type'],
                athletes: eventShowResponse['athletes'],
                volunteers: eventShowResponse['volunteers'],
                galleryId: eventShowResponse['gallery_id']
            );
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return event;
    }
}