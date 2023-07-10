import 'package:flutter/foundation.dart';

class SportIndexResponseItem{
    final int id;
    final String name;

    SportIndexResponseItem({
        @required this.id,
        @required this.name
    });
}

class SportShowResponse{
    final int id;
    final String name;
    final String description;
    final String notes;
    final String contactName;
    final String contactEmail;
    final String contactPhone;
    final List<dynamic> locations;
    final int galleryId;

    SportShowResponse({
        @required this.id,
        @required this.name,
        @required this.description,
        @required this.notes,
        @required this.contactName,
        @required this.contactEmail,
        @required this.contactPhone,
        @required this.locations,
        @required this.galleryId
    });
}