import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as syspaths;

import '../models/program.dart';
import '../models/http_exception.dart';

class ProgramProvider with ChangeNotifier{
    Future<List<ProgramIndexResponseItem>> index(int stateId) async{
        final url = 'https://special-olympics-api.herokuapp.com/states/${stateId}/programs';
        List<ProgramIndexResponseItem> programs = [];

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final programIndexResponse = json.decode(response.body) as Map<String, dynamic>;

            (programIndexResponse['programs'] as List<dynamic>).forEach((programIndexResponseItem){
                programs.add(ProgramIndexResponseItem(
                    id: programIndexResponseItem['id'],
                    name: programIndexResponseItem['name']
                ));
            });
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return programs;
    }

    Future<ProgramShowResponse> show(int id) async{
        final url = 'https://special-olympics-api.herokuapp.com/programs/${id}';
        ProgramShowResponse program;

        try{
            final response = await http.get(url);
            if(response.statusCode >= 400){
                final error = json.decode(response.body) as Map<String, dynamic>;
                throw HttpException(error['message']);
            }
            final programShowResponse = json.decode(response.body) as Map<String, dynamic>;

            program = ProgramShowResponse(
                name: programShowResponse['name'],
                description: programShowResponse['description']
            );
        }catch(error){
            print(error);
            throw HttpException(error.toString());
        }

        return program;
    }

    Future<void> showManual(int id, String name) async{
        final url = 'http://special-olympics-api.herokuapp.com/programs/${id}/manual';

        try{
            final response = await http.get(url);
            final appDir = await syspaths.getExternalStorageDirectory();
            final file = File('${appDir.path}/${name}.pdf');
            await file.writeAsBytes(response.bodyBytes);
        }catch(error){
            print(error.toString());
        }
    }
}