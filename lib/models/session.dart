import 'package:flutter/foundation.dart';

class SessionIndexResponseItem{
    String practiceActivity;
    int day;
    String start;
    String end;

    SessionIndexResponseItem({
        @required this.practiceActivity,
        @required this.day,
        @required this.start,
        @required this.end
    });
}