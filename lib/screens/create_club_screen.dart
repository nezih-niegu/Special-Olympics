import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/club.dart';
import '../providers/auth_provider.dart';
import '../providers/club_provider.dart';

class CreateClubScreen extends StatefulWidget{
    static const routeName = '/create-club';

    @override
    _CreateClubScreenState createState(){
        return _CreateClubScreenState();
    }
}

class _CreateClubScreenState extends State<CreateClubScreen>{
    final _createClubForm = GlobalKey<FormState>();
    final _phoneFocusNode = FocusNode();
    final _emailFocusNode = FocusNode();
    final _aboutFocusNode = FocusNode();
    var _clubRequestSendRequest = ClubRequestSendRequest(
        name: '',
        phone: '',
        email: '',
        about: ''
    );

    @override
    void dispose(){
        _phoneFocusNode.dispose();
        _emailFocusNode.dispose();
        _aboutFocusNode.dispose();
        
        super.dispose();
    }

    Future<void> sendClubRequest() async{
        if(!_createClubForm.currentState.validate()){
            return;
        }

        _createClubForm.currentState.save();
        int stateId = Provider.of<AuthProvider>(
            context,
            listen: false
        ).stateId;

        try{
            await Provider.of<ClubProvider>(
                context,
                listen: false
            ).sendRequest(stateId, _clubRequestSendRequest);

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
            appBar: AppBar(
                title: Text('Quiero abrir un club'),
                actions: [
                    IconButton(
                        icon: Icon(Icons.send),
                        onPressed: sendClubRequest
                    )
                ]
            ),
            body: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                    key: _createClubForm,
                    child: SingleChildScrollView(child: Column(children: [
                        TextFormField(
                            initialValue: _clubRequestSendRequest.name,
                            decoration: InputDecoration(labelText: 'Nombre'),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_phoneFocusNode);
                            },
                            validator: (name){
                                if(name.isEmpty){
                                    return 'El nombre es requerido';
                                }

                                return null;
                            },
                            onSaved: (name){
                                _clubRequestSendRequest.name = name;
                            }
                        ),
                        TextFormField(
                            initialValue: _clubRequestSendRequest.phone,
                            decoration: InputDecoration(labelText: 'Teléfono'),
                            textInputAction: TextInputAction.next,
                            focusNode: _phoneFocusNode,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_emailFocusNode);
                            },
                            validator: (phone){
                                if(phone.isEmpty){
                                    return 'El teléfono es requerido';
                                }

                                return null;
                            },
                            onSaved: (phone){
                                _clubRequestSendRequest.phone = phone;
                            }
                        ),
                        TextFormField(
                            initialValue: _clubRequestSendRequest.email,
                            decoration: InputDecoration(labelText: 'E-mail'),
                            textInputAction: TextInputAction.next,
                            focusNode: _emailFocusNode,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_aboutFocusNode);
                            },
                            validator: (email){
                                if(email.isEmpty){
                                    return 'El email es requerido';
                                }

                                return null;
                            },
                            onSaved: (email){
                                _clubRequestSendRequest.email = email;
                            }
                        ),
                        TextFormField(
                            initialValue: _clubRequestSendRequest.about,
                            decoration: InputDecoration(labelText: 'Acerca de mi'),
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            focusNode: _aboutFocusNode,
                            validator: (about){
                                if(about.isEmpty){
                                    return 'El campo es requerido';
                                }

                                return null;
                            },
                            onSaved: (about){
                                _clubRequestSendRequest.about = about;
                            }
                        )
                    ]))
                )
            )
        );
    }
}