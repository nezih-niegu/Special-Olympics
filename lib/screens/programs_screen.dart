import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/program_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/item_tile.dart';
import './program_screen.dart';

class ProgramsScreen extends StatelessWidget{
    static const routeName = '/programs';

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(title: Text('Programas')),
            body: FutureBuilder(
                future: Provider.of<ProgramProvider>(
                    context,
                    listen: false
                ).index(Provider.of<AuthProvider>(
                    context,
                    listen: false
                ).stateId),
                builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                    }
                    if(snapshot.error != null){
                        print(snapshot.error);
                        return Center(child: Text(snapshot.error.toString()));
                    }

                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i){
                            return ItemTile(
                                name: snapshot.data[i].name,
                                imageUrl: 'https://special-olympics-api.herokuapp.com/programs/${snapshot.data[i].id}/image',
                                onTap: (){
                                    Navigator.of(context).pushNamed(
                                        ProgramScreen.routeName,
                                        arguments: {
                                            "id": snapshot.data[i].id,
                                            "name": snapshot.data[i].name
                                        }
                                    );
                                }
                            );
                        }
                    );
                }
            )
        );
    }
}