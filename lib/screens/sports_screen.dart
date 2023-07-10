import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/item_tile.dart';
import '../providers/sport_provider.dart';
import '../providers/auth_provider.dart';
import '../screens/sport_screen.dart';

class SportsScreen extends StatelessWidget{
    static const routeName = '/sports';

    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(title: Text('Deportes')),
            body: FutureBuilder(
                future: Provider.of<SportProvider>(
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
                                imageUrl: 'https://special-olympics-api.herokuapp.com/sports/${snapshot.data[i].id}/image',
                                onTap: (){
                                    Navigator.of(context).pushNamed(
                                        SportScreen.routeName,
                                        arguments: {
                                            "id": snapshot.data[i].id,
                                            "name": snapshot.data[i].name
                                        }
                                    );
                                }
                            );
                        }
                    );
                },
            )
        );
    }
}