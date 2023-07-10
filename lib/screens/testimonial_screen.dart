import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/testimonial_porvider.dart';

class TestimonialScreen extends StatelessWidget{
    static const routeName = '/testimonial';

    @override
    Widget build(BuildContext context){
        final args = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
        final id = args['id'];
        final title = args['title'];

        return Scaffold(
            appBar: AppBar(title: Text('Testimonio: ${title}')),
            body: FutureBuilder(
                future: Provider.of<TestimonialProvider>(
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
                            'https://special-olympics-api.herokuapp.com/testimonials/${id}/image',
                            fit: BoxFit.cover,
                            height: 300,
                            width: double.infinity,
                        ),
                        Padding(
                            padding: EdgeInsets.all(30),
                            child: Text(
                                snapshot.data.content,
                                style: Theme.of(context).textTheme.bodyText2
                            )
                        )
                    ]));
                }
            )
        );
    }
}