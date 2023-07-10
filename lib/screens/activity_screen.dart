import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/activity_provider.dart';

class ActivityScreen extends StatelessWidget{
    static const routeName = '/activity';

    @override
    Widget build(BuildContext context){
        final args = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
        final id = args['id'];
        final name = args['name'];

        return Scaffold(
            appBar: AppBar(title: Text('Servicio: ${name}')),
            body: FutureBuilder(
                future: Provider.of<ActivityProvider>(
                    context,
                    listen: false
                ).show(id),
                builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                    }
                    if(snapshot.error != null){
                        return Center(child: Text(snapshot.error.toString()));
                    }

                    return SingleChildScrollView(child: Column(children: [
                        Image.network(
                            'https://special-olympics-api.herokuapp.com/activities/${id}/image',
                            fit: BoxFit.cover,
                            height: 300,
                            width: double.infinity,
                        ),
                        Padding(
                            padding: EdgeInsets.all(30),
                            child: Text(
                                snapshot.data.description,
                                style: Theme.of(context).textTheme.bodyText2
                            )
                        )
                    ]));
                }
            )
        );
    }
}