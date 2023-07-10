import 'package:flutter/foundation.dart';

class UserStoreRequest{
    String name;
    String email;
    String password;
    String passwordConfirmation;

    UserStoreRequest({
        @required this.name,
        @required this.email,
        @required this.password,
        @required this.passwordConfirmation
    });
}

class UserLoginRequest{
    String email;
    String password;

    UserLoginRequest({
        @required this.email,
        @required this.password
    });
}

class UserLoginResponse{
    Map<String, dynamic> user;
    String token;
    int expiresIn;

    UserLoginResponse({
        @required this.user,
        @required this.token,
        @required this.expiresIn
    });
}

class UserUpdateStateRequest{
    int stateId;

    UserUpdateStateRequest({
        @required this.stateId
    });
}

class UserShowResponse{
    String name;
    String email;

    UserShowResponse({
        @required this.name,
        @required this.email
    });
}

class UserUpdateRequest{
    String name;
    String email;

    UserUpdateRequest({
        @required this.name,
        @required this.email
    });
}

class UserUpdatePasswordRequest{
    String password;
    String newPassword;
    String newPasswordConfirmation;

    UserUpdatePasswordRequest({
        @required this.password,
        @required this.newPassword,
        @required this.newPasswordConfirmation
    });
}