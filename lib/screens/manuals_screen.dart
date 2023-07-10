import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import './manual_screen.dart';

class ManualsScreen extends StatelessWidget{
    static const routeName = '/manuals';

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(title: Text('Manuales descargados')),
            body: FutureBuilder(
                future: syspaths.getExternalStorageDirectory(),
                builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                    }
                    if(snapshot.error != null){
                        return Center(child: Text(snapshot.error.toString()));
                    }

                    final manuals = Directory(snapshot.data.path).listSync();
                    return manuals.length == 0 ? Center(child: Text('Aún no tienes manuales')) : ListView.builder(
                        itemCount: manuals.length,
                        itemBuilder: (context, i){
                            final name = path.basenameWithoutExtension(manuals[i].path);

                            return Dismissible(
                                key: ValueKey(i),
                                background: Container(
                                    color: Theme.of(context).errorColor,
                                    child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 40
                                    ),
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.only(right: 20)
                                ),
                                direction: DismissDirection.endToStart,
                                onDismissed: (_) async{
                                    await manuals[i].delete();
                                },
                                child: ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(name),
                                    onTap: (){
                                        Navigator.of(context).pushNamed(
                                            ManualScreen.routeName,
                                            arguments: {
                                                'name': name,
                                                'file': manuals[i]
                                            }
                                        );
                                    }
                                )
                            );
                        }
                    );
                }
            )
        );
    }
}