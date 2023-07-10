import 'package:flutter/foundation.dart';

class ClubIndexResponseItem{
    int id;
    String name;

    ClubIndexResponseItem({
        @required this.id,
        @required this.name
    });
}

class ClubShowResponse{
    int id;
    String name;
    String contactName;
    String contactEmail;
    List<dynamic> availableSports;
    String municipalityName;
    int galleryId;

    ClubShowResponse({
        @required this.id,
        @required this.name,
        @required this.contactName,
        @required this.contactEmail,
        @required this.availableSports,
        @required this.municipalityName,
        @required this.galleryId
    });
}

class ClubRequestSendRequest{
    String name;
    String phone;
    String email;
    String about;

    ClubRequestSendRequest({
        @required this.name,
        @required this.phone,
        @required this.email,
        @required this.about
    });
}