import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/coach_provider.dart';

class CoachesScreen extends StatelessWidget{
    static const routeName = '/coaches';

    @override
    Widget build(BuildContext context){
        final args = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
        final sportId = args['sport_id'];
        final sportName = args['sport_name'];

        return Scaffold(
            appBar: AppBar(title: Text('Entrenadores de: ${sportName}')),
            body: FutureBuilder(
                future: Provider.of<CoachProvider>(
                    context,
                    listen: false
                ).index(sportId),
                builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                    }
                    if(snapshot.error != null){
                        return Center(child: Text(snapshot.error.toString()));
                    }

                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i){
                            return Column(children: [
                                ListTile(
                                    leading: CircleAvatar(backgroundImage: NetworkImage('https://special-olympics-api.herokuapp.com/coaches/${snapshot.data[i].id}/picture')),
                                    title: Text(
                                        snapshot.data[i].name,
                                        style: TextStyle(fontSize: 20),
                                    ),
                                    subtitle: Text(
                                        '${snapshot.data[i].email}\n${snapshot.data[i].phone}',
                                        style: Theme.of(context).textTheme.subtitle1
                                    ),
                                    isThreeLine: true,  
                                ),
                                Divider()
                            ]);
                        },
                    );
                }
            )
        );
    }
}