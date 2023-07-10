import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../providers/auth_provider.dart';
import './edit_user_screen.dart';
import './edit_user_password_screen.dart';

class UserScreen extends StatelessWidget{
    static const routeName = '/user';

    @override
    Widget build(BuildContext context){
        return FutureBuilder(
            future: Provider.of<UserProvider>(
                context,
                listen: false
            ).show(Provider.of<AuthProvider>(context).token),
            builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                    return Scaffold(
                        appBar: AppBar(title: Text('Mi perfil')),
                        body: Center(child: CircularProgressIndicator()),
                    );
                }
                if(snapshot.error != null){
                    return Scaffold(
                        appBar: AppBar(title: Text('Mi perfil')),
                        body: Center(child: Text(snapshot.error.toString())),
                    );
                }

                return Consumer<UserProvider>(builder: (context, userProvider, _){
                    return Scaffold(
                        appBar: AppBar(
                            title: Text('Mi perfil'),
                            actions: [
                                IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditUserScreen(
                                            name: userProvider.user.name,
                                            email: userProvider.user.email
                                        )));
                                    }
                                )
                            ]
                        ),
                        body: Padding(
                            padding: EdgeInsets.all(30),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                        'Nombre:',
                                        style: Theme.of(context).textTheme.subtitle2
                                    ),
                                    Text(
                                        userProvider.user.name,
                                        style: Theme.of(context).textTheme.bodyText2
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                        'Correo electrónico:',
                                        style: Theme.of(context).textTheme.subtitle2
                                    ),
                                    Text(
                                        userProvider.user.email,
                                        style: Theme.of(context).textTheme.bodyText2
                                    ),
                                    SizedBox(height: 20),
                                    RaisedButton(
                                        color: Theme.of(context).primaryColor,
                                        child: Text(
                                            'Cambiar contraseña',
                                            style: Theme.of(context).textTheme.button
                                        ),
                                        onPressed: (){
                                            Navigator.of(context).pushNamed(EditUserPasswordScreen.routeName);
                                        }
                                    )
                                ]
                            )
                        )
                    );
                });
            }
        );
    }
}