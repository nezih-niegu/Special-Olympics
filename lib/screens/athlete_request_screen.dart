import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/participant.dart';
import '../providers/participant_provider.dart';
import '../providers/auth_provider.dart';

class AthleteRequestScreen extends StatefulWidget{
    static const routeName = '/athlete-request';

    @override
    _AthleteRequestScreenState createState(){
        return _AthleteRequestScreenState();
    }
}

class _AthleteRequestScreenState extends State<AthleteRequestScreen>{
    final _athleteRequestForm = GlobalKey<FormState>();
    final _ageFocusNode = FocusNode();
    final _disabilityFocusNode = FocusNode();
    final _phoneFocusNode = FocusNode();
    final _emailFocusNode = FocusNode();
    final _municipalityFocusNode = FocusNode();
    final _sportFocusNode = FocusNode();
    var _athleteRequestSendRequest = AthleteRequestSendRequest(
        name: '',
        age: '',
        disability: '',
        phone: '',
        email: '',
        municipality: '',
        sport: ''
    );

    @override
    void dispose(){
        _phoneFocusNode.dispose();
        _ageFocusNode.dispose();
        _disabilityFocusNode.dispose();
        _emailFocusNode.dispose();
        _municipalityFocusNode.dispose();
        _sportFocusNode.dispose();
        
        super.dispose();
    }

    Future<void> _sendAthleteRequest() async{
        if(!_athleteRequestForm.currentState.validate()){
            return;
        }
        _athleteRequestForm.currentState.save();

        try{
            await Provider.of<ParticipantProvider>(
                context,
                listen: false
            ).sendAthleteRequest(Provider.of<AuthProvider>(
                context,
                listen: false
            ).stateId, _athleteRequestSendRequest);

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
                title: Text('Solucitud: atleta'),
                actions: [
                    IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _sendAthleteRequest
                    )
                ]
            ),
            body: Padding(
                padding: EdgeInsets.all(30),
                child: Form(
                    key: _athleteRequestForm,
                    child: SingleChildScrollView(child: Column(children: [
                        TextFormField(
                            initialValue: _athleteRequestSendRequest.name,
                            decoration: InputDecoration(labelText: 'Nombre'),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_ageFocusNode);
                            },
                            validator: (name){
                                if(name.isEmpty){
                                    return 'El nombre es requerido';
                                }

                                return null;
                            },
                            onSaved: (name){
                                _athleteRequestSendRequest.name = name;
                            }
                        ),
                        TextFormField(
                            initialValue: _athleteRequestSendRequest.age,
                            decoration: InputDecoration(labelText: 'Edad'),
                            textInputAction: TextInputAction.next,
                            focusNode: _ageFocusNode,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_disabilityFocusNode);
                            },
                            validator: (age){
                                if(age.isEmpty){
                                    return 'La edad es requerida';
                                }

                                return null;
                            },
                            onSaved: (age){
                                _athleteRequestSendRequest.age = age;
                            }
                        ),
                        TextFormField(
                            initialValue: _athleteRequestSendRequest.disability,
                            decoration: InputDecoration(labelText: 'Discapacidad'),
                            textInputAction: TextInputAction.next,
                            focusNode: _disabilityFocusNode,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_phoneFocusNode);
                            },
                            validator: (disability){
                                if(disability.isEmpty){
                                    return 'La discapacidad es requerida';
                                }

                                return null;
                            },
                            onSaved: (disability){
                                _athleteRequestSendRequest.disability = disability;
                            }
                        ),
                        TextFormField(
                            initialValue: _athleteRequestSendRequest.phone,
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
                                _athleteRequestSendRequest.phone = phone;
                            }
                        ),
                        TextFormField(
                            initialValue: _athleteRequestSendRequest.email,
                            decoration: InputDecoration(labelText: 'E-mail'),
                            textInputAction: TextInputAction.next,
                            focusNode: _emailFocusNode,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_municipalityFocusNode);
                            },
                            validator: (email){
                                if(email.isEmpty){
                                    return 'El email es requerido';
                                }

                                return null;
                            },
                            onSaved: (email){
                                _athleteRequestSendRequest.email = email;
                            }
                        ),
                        TextFormField(
                            initialValue: _athleteRequestSendRequest.municipality,
                            decoration: InputDecoration(labelText: 'Municipio'),
                            textInputAction: TextInputAction.next,
                            focusNode: _municipalityFocusNode,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_sportFocusNode);
                            },
                            validator: (municipality){
                                if(municipality.isEmpty){
                                    return 'El municipio es requerido';
                                }

                                return null;
                            },
                            onSaved: (municipality){
                                _athleteRequestSendRequest.municipality = municipality;
                            }
                        ),
                        TextFormField(
                            initialValue: _athleteRequestSendRequest.sport,
                            decoration: InputDecoration(labelText: 'Deporte'),
                            textInputAction: TextInputAction.send,
                            focusNode: _sportFocusNode,
                            onFieldSubmitted: (_){
                                _sendAthleteRequest();
                            },
                            validator: (sport){
                                if(sport.isEmpty){
                                    return 'El deporte es requerido';
                                }

                                return null;
                            },
                            onSaved: (sport){
                                _athleteRequestSendRequest.sport = sport;
                            }
                        )
                    ]))
                )
            )
        );
    }
}