import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../providers/auth_provider.dart';

class CreateUserScreen extends StatefulWidget{
    static const routeName = '/create-user';

    @override
    _CreateUserScreenState createState(){
        return _CreateUserScreenState();
    }
}

class _CreateUserScreenState extends State<CreateUserScreen>{
    final _createUserForm = GlobalKey<FormState>();
    final _emailFocusNode = FocusNode();
    final _passwordFocusNode = FocusNode();
    final _passwordConfirmationFocusNode = FocusNode();
    var _userStoreRequest = UserStoreRequest(
        name: '',
        email: '',
        password: '',
        passwordConfirmation: ''
    );

    @override
    void dispose(){
        _emailFocusNode.dispose();
        _passwordFocusNode.dispose();
        _passwordConfirmationFocusNode.dispose();
        super.dispose();
    }

    Future<void> storeUser() async{
        if(!_createUserForm.currentState.validate()){
            return;
        }

        _createUserForm.currentState.save();
        int stateId = Provider.of<AuthProvider>(
            context,
            listen: false
        ).stateId;

        try{
            await Provider.of<UserProvider>(
                context,
                listen: false
            ).store(stateId, _userStoreRequest);
            await showDialog(
                context: context,
                builder: (context){
                    return AlertDialog(
                        title: Text(
                            'Solicitud enviada',
                            style: TextStyle(color: Colors.black)
                        ),
                        content: Text('Se le notificará por correo si su solicitud fue aceptada.'),
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
            appBar: AppBar(title: Text('Solicitar una cuenta')),
            body: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                    key: _createUserForm,
                    child: SingleChildScrollView(child: Column(children: [
                        Text('Si eres miembro de Special Olympics México-Puebla y deseas conocer más sobre los deportes y reglamentos que manejamos, te invitamos a solicitar una cuenta para poder acceder a información exclusiva para miembros.'),
                        TextFormField(
                            initialValue: _userStoreRequest.name,
                            decoration: InputDecoration(labelText: 'Nombre'),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_emailFocusNode);
                            },
                            validator: (name){
                                if(name.isEmpty){
                                    return 'El nombre es requerido';
                                }

                                return null;
                            },
                            onSaved: (name){
                                _userStoreRequest.name = name;
                            }
                        ),
                        TextFormField(
                            initialValue: _userStoreRequest.email,
                            decoration: InputDecoration(labelText: 'E-mail'),
                            textInputAction: TextInputAction.next,
                            focusNode: _emailFocusNode,
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
                                _userStoreRequest.email = email;
                            }
                        ),
                        TextFormField(
                            initialValue: _userStoreRequest.password,
                            decoration: InputDecoration(labelText: 'Contraseña'),
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            focusNode: _passwordFocusNode,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_passwordConfirmationFocusNode);
                            },
                            validator: (password){
                                if(password.isEmpty){
                                    return 'La contraseña es requerida';
                                }

                                return null;
                            },
                            onSaved: (password){
                                _userStoreRequest.password = password;
                            }
                        ),
                        TextFormField(
                            initialValue: _userStoreRequest.passwordConfirmation,
                            decoration: InputDecoration(labelText: 'Confirmar contraseña'),
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            focusNode: _passwordConfirmationFocusNode,
                            onFieldSubmitted: (_){
                                storeUser();
                            },
                            validator: (passwordConfirmation){
                                if(passwordConfirmation.isEmpty){
                                    return 'La confirmación de contraseña es requerida';
                                }

                                return null;
                            },
                            onSaved: (passwordConfirmation){
                                _userStoreRequest.passwordConfirmation = passwordConfirmation;
                            }
                        ),
                        SizedBox(height: 20),
                        Container(
                            alignment: Alignment.centerRight,
                            child: RaisedButton(
                                onPressed: storeUser,
                                color: Theme.of(context).primaryColor,
                                child: Text(
                                    'Envíar solicitud',
                                    style: Theme.of(context).textTheme.button
                                )
                            )
                        )
                    ]))
                )
            )
        );
    }
}