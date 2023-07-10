import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/participant.dart';
import '../providers/participant_provider.dart';
import '../providers/auth_provider.dart';

class VolunteerRequestScreen extends StatefulWidget{
    static const routeName = '/volunteer-request';

    @override
    _VolunteerRequestScreenState createState(){
        return _VolunteerRequestScreenState();
    }    
}

class _VolunteerRequestScreenState extends State<VolunteerRequestScreen>{
    final _volunteerRequestForm = GlobalKey<FormState>();
    final _phoneFocusNode = FocusNode();
    final _emailFocusNode = FocusNode();
    final _aboutFocusNode = FocusNode();
    var _volunteerRequestSendRequest = VolunteerRequestSendRequest(
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

    Future<void> _sendVolunteerRequest() async{
        if(!_volunteerRequestForm.currentState.validate()){
            return;
        }
        _volunteerRequestForm.currentState.save();

        try{
            await Provider.of<ParticipantProvider>(
                context,
                listen: false
            ).sendVolunteerRequest(Provider.of<AuthProvider>(
                context,
                listen: false
            ).stateId, _volunteerRequestSendRequest);

            await showDialog(
                context: context,
                builder: (context){
                    return AlertDialog(
                        title: Text(
                            'Solicitud enviada',
                            style: TextStyle(color: Colors.black)
                        ),
                        content: Text('Gracias por su solicitud. Se le contactará pronto.'),
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
                title: Text('Solicitud: voluntario en eventos'),
                actions: [
                    IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _sendVolunteerRequest
                    )
                ]
            ),
            body: Padding(
                padding: EdgeInsets.all(30),
                child: Form(
                    key: _volunteerRequestForm,
                    child: SingleChildScrollView(child: Column(children: [
                        TextFormField(
                            initialValue: _volunteerRequestSendRequest.name,
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
                                _volunteerRequestSendRequest.name = name;
                            }
                        ),
                        TextFormField(
                            initialValue: _volunteerRequestSendRequest.phone,
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
                                _volunteerRequestSendRequest.phone = phone;
                            }
                        ),
                        TextFormField(
                            initialValue: _volunteerRequestSendRequest.email,
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
                                _volunteerRequestSendRequest.email = email;
                            }
                        ),
                        TextFormField(
                            initialValue: _volunteerRequestSendRequest.about,
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
                                _volunteerRequestSendRequest.about = about;
                            }
                        )
                    ]))
                )
            )
        );
    }
}