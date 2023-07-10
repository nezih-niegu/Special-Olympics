import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget{
    static const routeName = '/login';

    @override
    _LoginScreen createState(){
        return _LoginScreen();
    }
}

class _LoginScreen extends State<LoginScreen>{
    final _loginUserForm = GlobalKey<FormState>();
    final _passwordFocusNode = FocusNode();
    var _userLoginRequest = UserLoginRequest(
        email: '',
        password: ''
    );

    @override
    void dispose(){
        _passwordFocusNode.dispose();
        super.dispose();
    }

    Future<void> loginUser() async{
        if(!_loginUserForm.currentState.validate()){
            return;
        }

        _loginUserForm.currentState.save();

        try{
            final userLoginResponse = await Provider.of<UserProvider>(
                context,
                listen: false
            ).login(_userLoginRequest);

            await Provider.of<AuthProvider>(context).setSession(userLoginResponse);
            Navigator.of(context).pop();
        }catch(error){
            await showDialog(
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
    
    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(title: Text('Iniciar sesión')),
            body: Padding(
                padding: EdgeInsets.all(50),
                child: Form(
                    key: _loginUserForm,
                    child: SingleChildScrollView(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Text('Si ya tienes una cuenta registrada, inicia sesión aquí'),
                            TextFormField(
                                initialValue: _userLoginRequest.email,
                                decoration: InputDecoration(labelText: 'Email'),
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_){
                                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                                },
                                validator: (email){
                                    if(email.isEmpty){
                                        return 'El email es requerido';
                                    }

                                    return null;
                                },
                                onSaved: (email){
                                    _userLoginRequest.email = email;
                                }
                            ),
                            TextFormField(
                                initialValue: _userLoginRequest.password,
                                decoration: InputDecoration(labelText: 'Contraseña'),
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                                focusNode: _passwordFocusNode,
                                onFieldSubmitted: (_){
                                    loginUser();
                                },
                                validator: (password){
                                    if(password.isEmpty){
                                        return 'La contraseña es requerida';
                                    }

                                    return null;
                                },
                                onSaved: (password){
                                    _userLoginRequest.password = password;
                                }
                            ),
                            SizedBox(height: 20),
                            RaisedButton(
                                onPressed: loginUser,
                                color: Theme.of(context).primaryColor,
                                child: Text(
                                    'Iniciar sesión',
                                    style: Theme.of(context).textTheme.button
                                )
                            ),
                            SizedBox(height: 20),
                            RichText(text: TextSpan(children: [
                                TextSpan(
                                    text: 'Restablecer contraseña',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                        decoration: TextDecoration.underline
                                    ),
                                    recognizer: TapGestureRecognizer()
                                    ..onTap = () async{
                                        final url = 'https://special-olympics-web.firebaseapp.com/forgot-password';

                                        if(await canLaunch(url)){
                                            await launch(url);
                                        }
                                    }
                                )
                            ]))
                        ]
                    )),
                )
            )
        );
    }
}