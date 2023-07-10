import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/state.provider.dart';
import '../providers/auth_provider.dart';

class ContactScreen extends StatelessWidget{
    Widget build(BuildContext context){
        return FutureBuilder(
            future: Provider.of<StateProvider>(
                context,
                listen: false
            ).showContact(Provider.of<AuthProvider>(
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
                if(snapshot.data.email == null && snapshot.data.facebook == null && snapshot.data.instagram == null){
                    return Center(child: Text('No hay información de contacto'));
                }
                
                return ListView(children: [
                    if(snapshot.data.email != null) ListTile(
                        leading: Icon(
                            Icons.email,
                            color: Colors.amber,
                            size: 50,
                        ),
                        title: Text(
                            'Correo electrónico',
                            style: Theme.of(context).textTheme.subtitle2,
                        ),
                        subtitle: Text(
                            snapshot.data.email,
                            style: Theme.of(context).textTheme.bodyText2,
                        ),
                        onTap: () async{
                            final url = 'mailto:${snapshot.data.email}?subject=&body=';
                            if(await canLaunch(url)){
                                await launch(url);
                            }
                        }
                    ),
                    if(snapshot.data.facebook != null) ListTile(
                        leading: Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blue,
                            size: 50,
                        ),
                        title: Text(
                            'Facebook',
                            style: Theme.of(context).textTheme.subtitle2,
                        ),
                        subtitle: Text(
                            snapshot.data.facebook,
                            style: Theme.of(context).textTheme.bodyText2,
                        ),
                        onTap: () async{
                            final url = snapshot.data.facebook;
                            if(await canLaunch(url)){
                                await launch(url);
                            }
                        }
                    ),
                    if(snapshot.data.instagram != null) ListTile(
                        leading: Icon(
                            FontAwesomeIcons.instagram,
                            color: Color.fromRGBO(174, 28, 136, 1),
                            size: 50,
                        ),
                        title: Text(
                            'Instagram',
                            style: Theme.of(context).textTheme.subtitle2,
                        ),
                        subtitle: Text(
                            snapshot.data.instagram,
                            style: Theme.of(context).textTheme.bodyText2,
                        ),
                        onTap: () async{
                            final url = snapshot.data.instagram;
                            if(await canLaunch(url)){
                                await launch(url);
                            }
                        }
                    )
                ]);
            }
        );
    }
}