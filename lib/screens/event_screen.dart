import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart';
import './gallery_screen.dart';

class EventScreen extends StatelessWidget{
    static const routeName = '/event';

    @override
    Widget build(BuildContext context){
        final args = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
        final id = args['id'];
        final name = args['name'];
        final type = ['Deportivo selectivo', 'Deportivo de convivencia', 'Plática de familia', 'Comunidades Saludables', 'Evento social', 'Capacitación a entrenadores voluntarios'];

        return Scaffold(
            appBar: AppBar(title: Text('Evento: ${name}')),
            body: FutureBuilder(
                future: Provider.of<EventProvider>(
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

                    return Padding(
                        padding: EdgeInsets.all(30),
                        child: SingleChildScrollView(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    snapshot.data.name,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                    )
                                ),
                                Text(
                                    snapshot.data.description,
                                    style: Theme.of(context).textTheme.bodyText2
                                ),
                                SizedBox(height: 20),
                                Text(
                                    'Lugar:',
                                    style: Theme.of(context).textTheme.subtitle2
                                ),
                                Text(
                                    snapshot.data.location,
                                    style: Theme.of(context).textTheme.bodyText2
                                ),
                                Text(
                                    'Correo de contacto:',
                                    style: Theme.of(context).textTheme.subtitle2
                                ),
                                Text(
                                    snapshot.data.contactEmail,
                                    style: Theme.of(context).textTheme.bodyText2
                                ),
                                Text(
                                    'Tipo de evento:',
                                    style: Theme.of(context).textTheme.subtitle2
                                ),
                                Text(
                                    type[snapshot.data.type],
                                    style: Theme.of(context).textTheme.bodyText2
                                ),
                                if(snapshot.data.athletes != null) ...[
                                    Text(
                                        'Atletas participantes:',
                                        style: Theme.of(context).textTheme.subtitle2
                                    ),
                                    Text(
                                        snapshot.data.athletes.toString(),
                                        style: Theme.of(context).textTheme.bodyText2
                                    )
                                ],
                                if(snapshot.data.volunteers != null) ...[
                                    Text(
                                        'Voluntarios participantes:',
                                        style: Theme.of(context).textTheme.subtitle2
                                    ),
                                    Text(
                                        snapshot.data.volunteers.toString(),
                                        style: Theme.of(context).textTheme.bodyText2
                                    )
                                ],
                                SizedBox(height: 20),
                                Container(
                                    width: double.infinity,
                                    child: RaisedButton(
                                        color: Theme.of(context).primaryColor,
                                        child: Text(
                                            'Ver galería',
                                            style: Theme.of(context).textTheme.button
                                        ),
                                        onPressed: (){
                                            Navigator.of(context).pushNamed(
                                                GalleryScreen.routeName,
                                                arguments: {
                                                    'id': snapshot.data.galleryId,
                                                    'name': snapshot.data.name
                                                }
                                            );
                                        }
                                    )
                                )
                            ]
                        )
                    ));
                }
            )
        );
    }
}