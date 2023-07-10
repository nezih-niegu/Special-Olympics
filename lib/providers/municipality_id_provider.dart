import 'package:flutter/foundation.dart';

class MunicipalityIdProvider with ChangeNotifier{
    int _municipalityId;

    int get municipalityId{
        return _municipalityId;
    }

    void setMunicipality(int municipalityId){
        _municipalityId = municipalityId;
        notifyListeners();
    }
}