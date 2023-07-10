import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../models/http_exception.dart';

class UserProvider with ChangeNotifier{
    static const url = 'https://special-olympics-api.herokuapp.com/users';
    UserShowResponse _user;

    UserShowResponse get user{
        return _user;
    }

    Future<void> store(int stateId, UserStoreRequest userStoreRequest) async{
        final url = 'https://special-olympics-api.herokuapp.com/states/${stateId}/users';

        try{
            final response = await http.post(
                url,
                headers: {
                    HttpHeaders.contentTypeHeader: 'application/json'
                },
                body: json.encode({
                    'name': userStoreRequest.name,
                    'email': userStoreRequest.email,
                    'password': userStoreRequest.password,
                    'password_confirmation': userStoreRequest.passwordConfirmation
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

    Future<UserLoginResponse> login(UserLoginRequest userLoginRequest) async{
        UserLoginResponse userData;

        try{
            final response = await http.post(
                '${url}/login',
                headers: {
                    HttpHeaders.contentTypeHeader: 'application/json'
                },
                body: json.encode({
                    'email': userLoginRequest.email,
                    'password': userLoginRequest.password
                })
            );
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final userLoginResponse = json.decode(response.body) as Map<String, dynamic>;

            userData = UserLoginResponse(
                user: userLoginResponse['user'],
                token: userLoginResponse['token'],
                expiresIn: int.parse(userLoginResponse['expires_in'])
            );
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return userData;
    }

    Future<void> updateState(UserUpdateStateRequest userUpdateStateRequest, String token) async{
        try{
            final response = await http.patch(
                '${url}/me/state',
                headers: {
                    HttpHeaders.contentTypeHeader: 'application/json',
                    HttpHeaders.authorizationHeader: 'Bearer ${token}'
                },
                body: json.encode({
                    'state_id': userUpdateStateRequest.stateId
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

    Future<void> logout(String token) async{
        try{
            final response = await http.delete(
                '${url}/logout',
                headers: {
                    HttpHeaders.contentTypeHeader: 'application/json',
                    HttpHeaders.authorizationHeader: 'Bearer ${token}'
                }
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

    Future<void> show(String token) async{
        try{
            final response = await http.get(
                '${url}/me',
                headers: {
                    HttpHeaders.authorizationHeader: 'Bearer ${token}'
                }
            );
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final userShowResponse = json.decode(response.body) as Map<String, dynamic>;

            _user = UserShowResponse(
                name: userShowResponse['name'],
                email: userShowResponse['email']
            );
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }
    }

    Future<void> update(String token, UserUpdateRequest userUpdateRequest) async{
        try{
            final response = await http.patch(
                '${url}/me',
                headers: {
                    HttpHeaders.contentTypeHeader: 'application/json',
                    HttpHeaders.authorizationHeader: 'Bearer ${token}'
                },
                body: json.encode({
                    'name': userUpdateRequest.name,
                    'email': userUpdateRequest.email
                })
            );
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }

            _user.name = userUpdateRequest.name;
            _user.email = userUpdateRequest.email;
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }
    }

    Future<void> updatePassword(String token, UserUpdatePasswordRequest userUpdatePasswordRequest) async{
        try{
            final response = await http.patch(
                '${url}/me/password',
                headers: {
                    HttpHeaders.contentTypeHeader: 'application/json',
                    HttpHeaders.authorizationHeader: 'Bearer ${token}'
                },
                body: json.encode({
                    'password': userUpdatePasswordRequest.password,
                    'new_password': userUpdatePasswordRequest.newPassword,
                    'new_password_confirmation': userUpdatePasswordRequest.newPasswordConfirmation
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