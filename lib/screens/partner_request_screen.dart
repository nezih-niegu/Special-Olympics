import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/participant.dart';
import '../providers/participant_provider.dart';
import '../providers/auth_provider.dart';

class PartnerRequestScreen extends StatefulWidget{
    static const routeName = '/partner-request';
    
    @override
    _PartnerRequestScreenState createState(){
        return _PartnerRequestScreenState();
    }
}

class _PartnerRequestScreenState extends State<PartnerRequestScreen>{
    final _partnerRequestForm = GlobalKey<FormState>();
     final _ageFocusNode = FocusNode();
    final _phoneFocusNode = FocusNode();
    final _emailFocusNode = FocusNode();
    final _municipalityFocusNode = FocusNode();
    final _sportFocusNode = FocusNode();
    var _partnerRequestSendRequest = PartnerRequestSendRequest(
        name: '',
        age: '',
        phone: '',
        email: '',
        municipality: '',
        sport: ''
    );

    @override
    void dispose(){
        _phoneFocusNode.dispose();
        _ageFocusNode.dispose();
        _emailFocusNode.dispose();
        _municipalityFocusNode.dispose();
        _sportFocusNode.dispose();
        
        super.dispose();
    }

    Future<void> _sendPartnerRequest() async{
        if(!_partnerRequestForm.currentState.validate()){
            return;
        }
        _partnerRequestForm.currentState.save();

        try{
            await Provider.of<ParticipantProvider>(
                context,
                listen: false
            ).sendPartnerRequest(Provider.of<AuthProvider>(
                context,
                listen: false
            ).stateId, _partnerRequestSendRequest);

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
                title: Text('Solicitud: compañero unificado'),
                actions: [
                    IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _sendPartnerRequest
                    )
                ]
            ),
            body: Padding(
                padding: EdgeInsets.all(30),
                child: Form(
                    key: _partnerRequestForm,
                    child: SingleChildScrollView(child: Column(children: [
                        TextFormField(
                            initialValue: _partnerRequestSendRequest.name,
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
                                _partnerRequestSendRequest.name = name;
                            }
                        ),
                        TextFormField(
                            initialValue: _partnerRequestSendRequest.age,
                            decoration: InputDecoration(labelText: 'Edad'),
                            textInputAction: TextInputAction.next,
                            focusNode: _ageFocusNode,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_phoneFocusNode);
                            },
                            validator: (age){
                                if(age.isEmpty){
                                    return 'La edad es requerida';
                                }

                                return null;
                            },
                            onSaved: (age){
                                _partnerRequestSendRequest.age = age;
                            }
                        ),
                        TextFormField(
                            initialValue: _partnerRequestSendRequest.phone,
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
                                _partnerRequestSendRequest.phone = phone;
                            }
                        ),
                        TextFormField(
                            initialValue: _partnerRequestSendRequest.email,
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
                                _partnerRequestSendRequest.email = email;
                            }
                        ),
                        TextFormField(
                            initialValue: _partnerRequestSendRequest.municipality,
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
                                _partnerRequestSendRequest.municipality = municipality;
                            }
                        ),
                        TextFormField(
                            initialValue: _partnerRequestSendRequest.sport,
                            decoration: InputDecoration(labelText: 'Deporte'),
                            textInputAction: TextInputAction.send,
                            focusNode: _sportFocusNode,
                            onFieldSubmitted: (_){
                                _sendPartnerRequest();
                            },
                            validator: (sport){
                                if(sport.isEmpty){
                                    return 'El deporte es requerido';
                                }

                                return null;
                            },
                            onSaved: (sport){
                                _partnerRequestSendRequest.sport = sport;
                            }
                        )
                    ]))
                )
            )
        );
    }
}