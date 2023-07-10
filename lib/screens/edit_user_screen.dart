import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../providers/auth_provider.dart';

class EditUserScreen extends StatefulWidget{
    static const routeName = '/edit-user';
    final String name;
    final String email;

    EditUserScreen({
        this.name,
        this.email
    });

    @override
    _EditUserScreenState createState(){
        return _EditUserScreenState();
    }    
}

class _EditUserScreenState extends State<EditUserScreen>{
    final _updateUserForm = GlobalKey<FormState>();
    final _emailFocusNode = FocusNode();
    UserUpdateRequest _userUpdateRequest;

    @override initState(){
        _userUpdateRequest = UserUpdateRequest(
            name: widget.name,
            email: widget.email
        );

        super.initState();
    }

    @override
    void dispose(){
        _emailFocusNode.dispose();
        super.dispose();
    }

    Future<void> updateUser() async{
        if(!_updateUserForm.currentState.validate()){
            return;
        }

        _updateUserForm.currentState.save();

        try{
            await Provider.of<UserProvider>(
                context,
                listen: false
            ).update(Provider.of<AuthProvider>(
                context,
                listen: false
            ).token, _userUpdateRequest);

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
            appBar: AppBar(
                title: Text('Editar perfil'),
                actions: [
                    IconButton(
                        icon: Icon(Icons.save),
                        onPressed: updateUser
                    )
                ]
            ),
            body: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                    key: _updateUserForm,
                    child: SingleChildScrollView(child: Column(children: [
                        TextFormField(
                            initialValue: _userUpdateRequest.name,
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
                                _userUpdateRequest.name = name;
                            }
                        ),
                        TextFormField(
                            initialValue: _userUpdateRequest.email,
                            decoration: InputDecoration(labelText: 'E-mail'),
                            textInputAction: TextInputAction.done,
                            focusNode: _emailFocusNode,
                            onFieldSubmitted: (_){
                                updateUser();
                            },
                            validator: (email){
                                if(email.isEmpty){
                                    return 'El email es requerido';
                                }

                                return null;
                            },
                            onSaved: (email){
                                _userUpdateRequest.email = email;
                            }
                        )
                    ]))
                )
            )
        );
    }
}