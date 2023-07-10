import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/picture_provider.dart';
import './picture_screen.dart';

class GalleryScreen extends StatelessWidget{
    static const routeName = '/gallery';

    @override
    Widget build(BuildContext context){
        final args = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
        final id = args['id'];
        final name = args['name'];

        return Scaffold(
            appBar: AppBar(title: Text('Galería de: ${name}')),
            body: FutureBuilder(
                future: Provider.of<PictureProvider>(
                    context,
                    listen: false
                ).index(id),
                builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                    }
                    if(snapshot.error != null){
                        return Center(child: Text(snapshot.error.toString()));
                    }

                    return GridView.builder(
                        padding: const EdgeInsets.all(20),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1 / 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i){
                            return Ink.image(
                                image: NetworkImage('https://special-olympics-api.herokuapp.com/pictures/${snapshot.data[i].id}'),
                                fit: BoxFit.cover,
                                child: InkWell(
                                    onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                            return PictureScreen(
                                                pictures: snapshot.data,
                                                galleryName: name,
                                                startingIndex: i
                                            );
                                        }));
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