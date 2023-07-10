import 'package:flutter/foundation.dart';

class CoachIndexResponseItem{
    int id;
    String name;
    String email;
    String phone;

    CoachIndexResponseItem({
        @required this.id,
        @required this.name,
        @required this.email,
        @required this.phone
    });
}