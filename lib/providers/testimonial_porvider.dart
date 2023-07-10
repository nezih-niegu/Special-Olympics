import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/testimonial.dart';
import '../models/http_exception.dart';

class TestimonialProvider with ChangeNotifier{
    Future<List<TestimonialIndexResponseItem>> index(int stateId, int type) async{
        final url = 'https://special-olympics-api.herokuapp.com/states/${stateId}/testimonials?type=${type}';
        List<TestimonialIndexResponseItem> testimonials = [];

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final testimonialIndexResponse = json.decode(response.body) as Map<String, dynamic>;

            (testimonialIndexResponse['testimonials'] as List<dynamic>).forEach((testimonialIndexResponseItem){
                testimonials.add(TestimonialIndexResponseItem(
                    id: testimonialIndexResponseItem['id'],
                    title: testimonialIndexResponseItem['title']
                ));
            });
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        print(testimonials);
        return testimonials;
    }

    Future<TestimonialShowResponse> show(int id) async{
        final url = 'https://special-olympics-api.herokuapp.com/testimonials/${id}';
        TestimonialShowResponse testimonial;

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final testimonialShowResponse = json.decode(response.body) as Map<String, dynamic>;

            testimonial = TestimonialShowResponse(
                title: testimonialShowResponse['title'],
                content: testimonialShowResponse['content']
            );
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return testimonial;
    }
}