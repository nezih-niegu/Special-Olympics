import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/gallery_provider.dart';
import '../providers/auth_provider.dart';
import './gallery_screen.dart';

class GalleriesScreen extends StatelessWidget{
    static const routeName = '/galleries';

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(title: Text('Galerías de eventos recientes')),
            body: FutureBuilder(
                future: Provider.of<GalleryProvider>(
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
                        return Center(child: Text(snapshot.error.toString()));
                    }

                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i){
                            return Column(children: [
                                ListTile(
                                    leading: Icon(Icons.photo_library),
                                    title: Text(snapshot.data[i].name),
                                    onTap: (){
                                        Navigator.of(context).pushNamed(
                                            GalleryScreen.routeName,
                                            arguments: {
                                                'id': snapshot.data[i].id,
                                                'name': snapshot.data[i].name
                                            }
                                        );
                                    }
                                ),
                                Divider()
                            ]);
                        }
                    );
                }
            )
        );
    }
}