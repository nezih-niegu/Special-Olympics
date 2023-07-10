import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/tabs_screen.dart';
import '../screens/state_screen.dart';
import '../screens/create_user_screen.dart';
import '../screens/login_screen.dart';
import '../providers/user_provider.dart';
import '../providers/auth_provider.dart';
import '../screens/user_screen.dart';

class AppDrawer extends StatelessWidget{
    @override
    Widget build(BuildContext context){
        final isAuth = Provider.of<AuthProvider>(
            context,
            listen: false
        ).isAuth();

        return Drawer(child: Column(children: [
            AppBar(
                title: Text('Selecciona una opción'),
                automaticallyImplyLeading: false
            ),
            ListTile(
                leading: Icon(Icons.home),
                title: Text('Inicio'),
                onTap: (){
                    Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
                }
            ),
            Divider(),
            ListTile(
                leading: Icon(Icons.map),
                title: Text('Cambiar entidad federativa'),
                onTap: (){
                    Navigator.of(context).pushNamed(StateScreen.routeName);
                }
            ),
            Divider(),
            if(!isAuth) ...[
                ListTile(
                    leading: Icon(Icons.person_add),
                    title: Text('Solicitar una cuenta'),
                    onTap: (){
                        Navigator.of(context).pushNamed(CreateUserScreen.routeName);
                    }
                ),
                Divider(),
                ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Iniciar sesión'),
                    onTap: (){
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                    }
                ),
                Divider()
            ],
            if(isAuth) ...[
                ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Mi perfil'),
                    onTap: (){
                        Navigator.of(context).pushNamed(UserScreen.routeName);
                    }
                ),
                Divider(),
                ListTile(
                    leading: Icon(Icons.power_settings_new),
                    title: Text('Cerrar sesión'),
                    onTap: () async{
                        try{
                            await Provider.of<UserProvider>(
                                context,
                                listen: false
                            ).logout(Provider.of<AuthProvider>(
                                context,
                                listen: false
                            ).token);
                            await Provider.of<AuthProvider>(
                                context,
                                listen: false
                            ).unsetSession();
                        }catch(error){
                            showDialog(
                                context: context,
                                builder: (context){
                                    return AlertDialog(
                                        title: Text(
                                            'Error',
                                            style: TextStyle(color: Colors.black)
                                        ),
                                        content: Text(error.toString()),
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
                    }
                ),
                Divider()
            ]
        ]));
    }
}