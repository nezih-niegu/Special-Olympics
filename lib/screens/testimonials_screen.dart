import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/testimonial_porvider.dart';
import '../providers/auth_provider.dart';
import '../widgets/item_tile.dart';
import './testimonial_screen.dart';

class TestimonialsScreen extends StatelessWidget{
    static const routeName = '/testimonials';

    @override
    Widget build(BuildContext context){
        final args = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
        final type = args['type'];
        final typeString = ['familias', 'atletas', 'entrenadores', 'voluntarios', 'compañeros unificados', 'aliados'];

        return Scaffold(
            appBar: AppBar(title: Text('Testimonios de ${typeString[type]}')),
            body: FutureBuilder(
                future: Provider.of<TestimonialProvider>(
                    context,
                    listen: false
                ).index(Provider.of<AuthProvider>(
                    context,
                    listen: false
                ).stateId, type),
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
                                name: snapshot.data[i].title,
                                imageUrl: 'https://special-olympics-api.herokuapp.com/testimonials/${snapshot.data[i].id}/image',
                                onTap: (){
                                    Navigator.of(context).pushNamed(
                                        TestimonialScreen.routeName,
                                        arguments: {
                                            'id': snapshot.data[i].id,
                                            'title': snapshot.data[i].title
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