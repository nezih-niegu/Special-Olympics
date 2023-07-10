import 'package:flutter/foundation.dart';

class StateIndexResponseItem{
    int id;
    String name;

    StateIndexResponseItem({
        @required this.id,
        @required this.name
    });
}

class StateContactShowResponse{
    String email;
    String facebook;
    String instagram;

    StateContactShowResponse({
        @required this.email,
        @required this.facebook,
        @required this.instagram
    });
}