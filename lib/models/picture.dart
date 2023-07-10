import 'package:flutter/foundation.dart';

class PictureIndexResponseItem{
    int id;

    PictureIndexResponseItem({
        @required this.id
    });
}

class PictureIndexResponse{
    List<PictureIndexResponseItem> pictures;
    int total;

    PictureIndexResponse({
        @required this.pictures,
        @required this.total
    });
}