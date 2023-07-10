import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:special_olympics_app/providers/user_provider.dart';

import '../models/user.dart';

class AuthProvider extends ChangeNotifier{
    final UserProvider userProvider;
    int _id;
    String _token;
    DateTime _expiresAt;
    int _stateId;
    Timer _authTimer;

    AuthProvider(this.userProvider);

    Future<void> setState(int stateId) async{
        if(isAuth()){
            final userUpdateStateRequest = UserUpdateStateRequest(
                stateId: stateId
            );

            await userProvider.updateState(userUpdateStateRequest, _token);
        }

        _stateId = stateId;

        final prefs = await SharedPreferences.getInstance();
        final stateData = json.encode({
            'id': stateId
        });
        prefs.setString('stateData', stateData);

        notifyListeners();
    }

    int get stateId{
        return _stateId;
    }

    String get token{
        return _token;
    }

    Future<bool> tryAutoLogin() async{
        final prefs = await SharedPreferences.getInstance();

        if(!prefs.containsKey('stateData')){
            return false;
        }

        if(prefs.containsKey('userData')){
            final userData = json.decode(prefs.getString('userData')) as Map<String, dynamic>;
            _id = userData['id'];
            _token = userData['token'];
            _expiresAt = DateTime.parse(userData['expires_at']);

            if(_expiresAt.isBefore(DateTime.now())){
                unsetSession();
            }else{
                autoLogout();
            }
        }

        final stateData = json.decode(prefs.getString('stateData')) as Map<String, dynamic>;
        _stateId = stateData['id'];

        notifyListeners();
        return true;
    }

    bool isStateSet(){
        return _stateId != null;
    }

    bool isAuth(){
        return _id != null;
    }

    Future<void> setSession(UserLoginResponse userLoginResponse) async{
        _id = userLoginResponse.user['id'];
        _token = userLoginResponse.token;
        _expiresAt = DateTime.now().add(Duration(seconds: userLoginResponse.expiresIn));
        _stateId = userLoginResponse.user['state_id'];
        autoLogout();
        notifyListeners();

        final prefs = await SharedPreferences.getInstance();
        final stateData = json.encode({
            'id': _stateId
        });
        final userData = json.encode({
           'id': _id,
           'token': _token,
           'expires_at': _expiresAt.toIso8601String()
        });

        prefs.setString('stateData', stateData);
        prefs.setString('userData', userData);
    }

    Future<void> unsetSession() async{
        _id = null;
        _token = null;
        _expiresAt = null;

        if(_authTimer != null){
            _authTimer.cancel();
            _authTimer = null;
        }

        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('userData');
    }

    void autoLogout(){
        if(_authTimer != null){
            _authTimer.cancel();
        }

        final timeToExpiry = _expiresAt.difference(DateTime.now()).inSeconds;
        _authTimer = Timer(Duration(seconds: timeToExpiry), unsetSession);
    }
}