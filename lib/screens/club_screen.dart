import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/club_provider.dart';
import './sessions_screen.dart';
import './gallery_screen.dart';

class ClubScreen extends StatelessWidget{
    static const routeName = '/club';

    @override
    Widget build(BuildContext context){
        final args = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
        final id = args['id'];
        final name = args['name'];

        return Scaffold(
            appBar: AppBar(title: Text('Club: ${name}')),
            body: FutureBuilder(
                future: Provider.of<ClubProvider>(
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
                                    name,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                    )
                                ),
                                Text(
                                    snapshot.data.municipalityName,
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
                                SizedBox(height: 20),
                                Text(
                                    'Deportes disponibles:',
                                    style: Theme.of(context).textTheme.subtitle2,
                                ),
                                ...snapshot.data.availableSports.map((availableSport){
                                    return Column(children: [
                                        RichText(text: TextSpan(children: [
                                            TextSpan(
                                                text: '• ',
                                                style: Theme.of(context).textTheme.bodyText2
                                            ),
                                            TextSpan(
                                                text: '${availableSport['name']}: ',
                                                style: Theme.of(context).textTheme.subtitle2
                                            ),
                                            TextSpan(
                                                text: availableSport['address'],
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 20,
                                                    decoration: TextDecoration.underline
                                                ),
                                                recognizer: TapGestureRecognizer()
                                                ..onTap = () async{
                                                    final address = Uri.encodeComponent(availableSport['address']);
                                                    final url = 'https://www.google.com/maps?q=${address}';

                                                    if(await canLaunch(url)){
                                                        await launch(url);
                                                    }
                                                }
                                            )
                                        ])),
                                    ]);
                                }).toList(),
                                SizedBox(height: 20),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                        RaisedButton(
                                            color: Theme.of(context).primaryColor,
                                            child: Text(
                                                'Ver entrenamientos',
                                                style: Theme.of(context).textTheme.button
                                            ),
                                            onPressed: (){
                                                Navigator.of(context).pushNamed(
                                                    SessionsScreen.routeName,
                                                    arguments: {
                                                        'club_id': id,
                                                        'club_name': name
                                                    }
                                                );
                                            }
                                        )
                                    ]
                                )
                            ]
                        ))
                    );
                }
            )
        );
    }
}