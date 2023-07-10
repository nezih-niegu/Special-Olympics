import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as syspaths;

import '../providers/sport_provider.dart';
import './manual_screen.dart';
import './coaches_screen.dart';
// import './gallery_screen.dart';
import '../providers/auth_provider.dart';

class SportScreen extends StatelessWidget{
    static const routeName = '/sport';

    Widget build(BuildContext context){
        final args = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
        final id = args['id'];
        final name = args['name'];

        return Scaffold(
            appBar: AppBar(title: Text('Deporte: ${name}')),
            body: FutureBuilder(
                future: Provider.of<SportProvider>(
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
                            'https://special-olympics-api.herokuapp.com/sports/${id}/image',
                            fit: BoxFit.cover,
                            height: 300,
                            width: double.infinity
                        ),
                        Padding(
                            padding: EdgeInsets.all(30),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                            RaisedButton(
                                                color: Theme.of(context).primaryColor,
                                                child: Text(
                                                    'Ver Manual',
                                                    style: Theme.of(context).textTheme.button
                                                ),
                                                onPressed: () async{
                                                    final isAuth = Provider.of<AuthProvider>(
                                                        context,
                                                        listen: false
                                                    ).isAuth();
                                                    if(!isAuth){
                                                        return await showDialog(
                                                            context: context,
                                                            builder: (context){
                                                                return AlertDialog(
                                                                    title: Text(
                                                                        'Error',
                                                                        style: TextStyle(color: Colors.black)
                                                                    ),
                                                                    content: Text('Para ver el manual de este deporte deberá solicitar una cuenta.'),
                                                                    actions: [
                                                                        FlatButton(
                                                                            child: Text('Ok'),
                                                                            onPressed: (){
                                                                                Navigator.of(context).pop();
                                                                            }
                                                                        )
                                                                    ]
                                                                );
                                                            }
                                                        );
                                                    }

                                                    final appDir = await syspaths.getExternalStorageDirectory();
                                                    final file = File('${appDir.path}/${name}.pdf');

                                                    if(await file.exists()){
                                                        Navigator.of(context).pushNamed(
                                                            ManualScreen.routeName,
                                                            arguments: {
                                                                'file': file,
                                                                'name': snapshot.data.name
                                                            }
                                                        );
                                                    }else{
                                                        Navigator.of(context).pushNamed(
                                                            ManualScreen.routeName,
                                                            arguments: {
                                                                'id': id,
                                                                'name': snapshot.data.name,
                                                                'type': 'sport'
                                                            }
                                                        );
                                                    }
                                                },
                                            ),
                                            RaisedButton(
                                                color: Theme.of(context).primaryColor,
                                                child: Text(
                                                    'Descargar Manual',
                                                    style: Theme.of(context).textTheme.button
                                                ),
                                                onPressed: () async{
                                                    final isAuth = Provider.of<AuthProvider>(
                                                        context,
                                                        listen: false
                                                    ).isAuth();
                                                    if(!isAuth){
                                                        return await showDialog(
                                                            context: context,
                                                            builder: (context){
                                                                return AlertDialog(
                                                                    title: Text(
                                                                        'Error',
                                                                        style: TextStyle(color: Colors.black)
                                                                    ),
                                                                    content: Text('Para descargar el manual de este deporte deberá solicitar una cuenta.'),
                                                                    actions: [
                                                                        FlatButton(
                                                                            child: Text('Ok'),
                                                                            onPressed: (){
                                                                                Navigator.of(context).pop();
                                                                            }
                                                                        )
                                                                    ]
                                                                );
                                                            }
                                                        );
                                                    }

                                                    showDialog(
                                                        context: context,
                                                        builder: (context){
                                                            return FutureBuilder(
                                                                future: Provider.of<SportProvider>(
                                                                    context,
                                                                    listen: false
                                                                ).showManual(id, snapshot.data.name),
                                                                builder: (context, snapshot){
                                                                    if(snapshot.connectionState == ConnectionState.waiting){
                                                                        return AlertDialog(
                                                                            title: Text(
                                                                                'Descargando...',
                                                                                style: TextStyle(color: Colors.black)
                                                                            ),
                                                                            content: Center(
                                                                                heightFactor: 3,
                                                                                child: CircularProgressIndicator()
                                                                            )
                                                                        );
                                                                    }
                                                                    if(snapshot.error != null){
                                                                        return AlertDialog(
                                                                            title: Text(
                                                                                'Error',
                                                                                style: TextStyle(color: Colors.black)
                                                                            ),
                                                                            content: Text(snapshot.error.toString())
                                                                        );
                                                                    }

                                                                    return AlertDialog(
                                                                        title: Text(
                                                                            'Manual descargado',
                                                                            style: TextStyle(color: Colors.black)
                                                                        ),
                                                                        content: Text('Ahora puedes encontrar el manual en la sección de manuales descargados'),
                                                                        actions: [
                                                                            FlatButton(
                                                                                child: Text('Ok'),
                                                                                onPressed: (){
                                                                                    Navigator.of(context).pop();
                                                                                }
                                                                            )
                                                                        ]
                                                                    );
                                                                }
                                                            );
                                                        }
                                                    );
                                                },
                                            ),
                                            RaisedButton(
                                                color: Theme.of(context).primaryColor,
                                                child: Text(
                                                    'Ver entrenadores',
                                                    style: Theme.of(context).textTheme.button
                                                ),
                                                onPressed: (){
                                                    Navigator.of(context).pushNamed(
                                                        CoachesScreen.routeName,
                                                        arguments: {
                                                            'sport_id': id,
                                                            'sport_name': snapshot.data.name
                                                        }
                                                    );
                                                }
                                            ),
                                            // RaisedButton(
                                            //     color: Theme.of(context).primaryColor,
                                            //     child: Text(
                                            //         'Ver galería',
                                            //         style: Theme.of(context).textTheme.button
                                            //     ),
                                            //     onPressed: (){
                                            //         Navigator.of(context).pushNamed(
                                            //             GalleryScreen.routeName,
                                            //             arguments: {
                                            //                 'id': snapshot.data.galleryId,
                                            //                 'name': snapshot.data.name
                                            //             }
                                            //         );
                                            //     }
                                            // )
                                        ]
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                        snapshot.data.description,
                                        style: Theme.of(context).textTheme.bodyText2
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                        'Notas:',
                                        style: Theme.of(context).textTheme.subtitle2
                                    ),
                                    Text(
                                        snapshot.data.notes,
                                        style: Theme.of(context).textTheme.bodyText2
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                        'Contacto:',
                                        style: Theme.of(context).textTheme.subtitle2
                                    ),
                                    Text(
                                        snapshot.data.contactName,
                                        style: Theme.of(context).textTheme.bodyText2
                                    ),
                                    Text(
                                        snapshot.data.contactEmail,
                                        style: Theme.of(context).textTheme.bodyText2
                                    ),
                                    Text(
                                        snapshot.data.contactPhone,
                                        style: Theme.of(context).textTheme.bodyText2
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                        'Lugares:',
                                        style: Theme.of(context).textTheme.subtitle2
                                    ),
                                    ...snapshot.data.locations.map((location){
                                        return Text(
                                            location['name'].toString(),
                                            style: Theme.of(context).textTheme.bodyText2
                                        );
                                    }).toList()
                                ]
                            )
                        )
                    ]));
                }
            )
        );
    }
}