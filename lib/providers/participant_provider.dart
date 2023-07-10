import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/participant.dart';
import '../models/http_exception.dart';

class ParticipantProvider with ChangeNotifier{
    Future<void> sendVolunteerRequest(int stateId, VolunteerRequestSendRequest volunteerRequestSendRequest) async{
        final url = 'https://special-olympics-api.herokuapp.com/states/${stateId}/participants/volunteers';

        try{
            final response = await http.post(
                url,
                headers: {
                    HttpHeaders.contentTypeHeader: 'application/json'
                },
                body: json.encode({
                    'name': volunteerRequestSendRequest.name,
                    'phone': volunteerRequestSendRequest.phone,
                    'email': volunteerRequestSendRequest.email,
                    'about': volunteerRequestSendRequest.about,
                })
            );

            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                print(error['message']);
                throw HttpException(error['message']);
            }
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }
    }

    Future<void> sendAthleteRequest(int stateId, AthleteRequestSendRequest athleteRequestSendRequest) async{
        final url = 'https://special-olympics-api.herokuapp.com/states/${stateId}/participants/athletes';

        try{
            final response = await http.post(
                url,
                headers: {
                    HttpHeaders.contentTypeHeader: 'application/json'
                },
                body: json.encode({
                    'name': athleteRequestSendRequest.name,
                    'age': athleteRequestSendRequest.age,
                    'disability': athleteRequestSendRequest.disability,
                    'phone': athleteRequestSendRequest.phone,
                    'email': athleteRequestSendRequest.email,
                    'municipality': athleteRequestSendRequest.municipality,
                    'sport': athleteRequestSendRequest.sport
                })
            );

            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                print(error['message']);
                throw HttpException(error['message']);
            }
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }
    }

    Future<void> sendPartnerRequest(int stateId, PartnerRequestSendRequest partnerRequestSendRequest) async{
        final url = 'https://special-olympics-api.herokuapp.com/states/${stateId}/participants/partners';

        try{
            final response = await http.post(
                url,
                headers: {
                    HttpHeaders.contentTypeHeader: 'application/json'
                },
                body: json.encode({
                    'name': partnerRequestSendRequest.name,
                    'age': partnerRequestSendRequest.age,
                    'phone': partnerRequestSendRequest.phone,
                    'email': partnerRequestSendRequest.email,
                    'municipality': partnerRequestSendRequest.municipality,
                    'sport': partnerRequestSendRequest.sport
                })
            );

            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                print(error['message']);
                throw HttpException(error['message']);
            }
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }
    }

    Future<void> sendFamilyRequest(int stateId, FamilyRequestSendRequest familyRequestSendRequest) async{
        final url = 'https://special-olympics-api.herokuapp.com/states/${stateId}/participants/families';

        try{
            final response = await http.post(
                url,
                headers: {
                    HttpHeaders.contentTypeHeader: 'application/json'
                },
                body: json.encode({
                    'name': familyRequestSendRequest.name,
                    'relationship': familyRequestSendRequest.relationship,
                    'disability': familyRequestSendRequest.disability,
                    'phone': familyRequestSendRequest.phone,
                    'email': familyRequestSendRequest.email,
                    'municipality': familyRequestSendRequest.municipality,
                })
            );

            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                print(error['message']);
                throw HttpException(error['message']);
            }
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }
    }

    Future<void> sendProfessionalRequest(int stateId, ProfessionalRequestSendRequest professionalRequestSendRequest) async{
        final url = 'https://special-olympics-api.herokuapp.com/states/${stateId}/participants/professionals';

        try{
            final response = await http.post(
                url,
                headers: {
                    HttpHeaders.contentTypeHeader: 'application/json'
                },
                body: json.encode({
                    'name': professionalRequestSendRequest.name,
                    'phone': professionalRequestSendRequest.phone,
                    'email': professionalRequestSendRequest.email,
                    'about': professionalRequestSendRequest.about,
                    'services': professionalRequestSendRequest.services
                })
            );

            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                print(error['message']);
                throw HttpException(error['message']);
            }
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }
    }

    Future<void> sendCoachRequest(int stateId, CoachRequestSendRequest coachRequestSendRequest) async{
        final url = 'https://special-olympics-api.herokuapp.com/states/${stateId}/participants/coaches';

        try{
            final response = await http.post(
                url,
                headers: {
                    HttpHeaders.contentTypeHeader: 'application/json'
                },
                body: json.encode({
                    'name': coachRequestSendRequest.name,
                    'phone': coachRequestSendRequest.phone,
                    'email': coachRequestSendRequest.email,
                    'about': coachRequestSendRequest.about,
                    'sports': coachRequestSendRequest.sports,
                    'municipalities': coachRequestSendRequest.municipalities
                })
            );

            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                print(error['message']);
                throw HttpException(error['message']);
            }
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }
    }
}