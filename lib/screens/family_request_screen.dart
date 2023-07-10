import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/participant.dart';
import '../providers/participant_provider.dart';
import '../providers/auth_provider.dart';

class FamilyRequestScreen extends StatefulWidget{
    static const routeName = '/family-request';

    @override
    _FamilyRequestScreenState createState(){
        return _FamilyRequestScreenState();
    }
}

class _FamilyRequestScreenState extends State<FamilyRequestScreen>{
    final _familyRequestForm = GlobalKey<FormState>();
    var _familyRequestSendRequest = FamilyRequestSendRequest(
        name: '',
        relationship: '',
        disability: '',
        phone: '',
        email: '',
        municipality: '',
    );
    final _relationshipFocusNode = FocusNode();
    final _disabilityFocusNode = FocusNode();
    final _phoneFocusNode = FocusNode();
    final _emailFocusNode = FocusNode();
    final _municipalityFocusNode = FocusNode();

    @override
    void dispose(){
        _relationshipFocusNode.dispose();
        _disabilityFocusNode.dispose();
        _phoneFocusNode.dispose();
        _emailFocusNode.dispose();
        _municipalityFocusNode.dispose();
        
        super.dispose();
    }

    Future<void> _sendFamilyRequest() async{
        if(!_familyRequestForm.currentState.validate()){
            return;
        }
        _familyRequestForm.currentState.save();

        try{
            await Provider.of<ParticipantProvider>(
                context,
                listen: false
            ).sendFamilyRequest(Provider.of<AuthProvider>(
                context,
                listen: false
            ).stateId, _familyRequestSendRequest);

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
                title: Text('Solicitud: familia'),
                actions: [
                    IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _sendFamilyRequest
                    )
                ]
            ),
            body: Padding(
                padding: EdgeInsets.all(30),
                child: Form(
                    key: _familyRequestForm,
                    child: SingleChildScrollView(child: Column(children: [
                        TextFormField(
                            initialValue: _familyRequestSendRequest.name,
                            decoration: InputDecoration(labelText: 'Nombre'),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_relationshipFocusNode);
                            },
                            validator: (name){
                                if(name.isEmpty){
                                    return 'El nombre es requerido';
                                }

                                return null;
                            },
                            onSaved: (name){
                                _familyRequestSendRequest.name = name;
                            }
                        ),
                        TextFormField(
                            initialValue: _familyRequestSendRequest.relationship,
                            decoration: InputDecoration(labelText: 'Parentesco'),
                            textInputAction: TextInputAction.next,
                            focusNode: _relationshipFocusNode,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_disabilityFocusNode);
                            },
                            validator: (relationship){
                                if(relationship.isEmpty){
                                    return 'El parentesco es requerido';
                                }

                                return null;
                            },
                            onSaved: (relationship){
                                _familyRequestSendRequest.relationship = relationship;
                            }
                        ),
                        TextFormField(
                            initialValue: _familyRequestSendRequest.disability,
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
                                _familyRequestSendRequest.disability = disability;
                            }
                        ),
                        TextFormField(
                            initialValue: _familyRequestSendRequest.phone,
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
                                _familyRequestSendRequest.phone = phone;
                            }
                        ),
                        TextFormField(
                            initialValue: _familyRequestSendRequest.email,
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
                                _familyRequestSendRequest.email = email;
                            }
                        ),
                        TextFormField(
                            initialValue: _familyRequestSendRequest.municipality,
                            decoration: InputDecoration(labelText: 'Municipio'),
                            textInputAction: TextInputAction.send,
                            focusNode: _municipalityFocusNode,
                            onFieldSubmitted: (_){
                                _sendFamilyRequest();
                            },
                            validator: (municipality){
                                if(municipality.isEmpty){
                                    return 'El municipio es requerido';
                                }

                                return null;
                            },
                            onSaved: (municipality){
                                _familyRequestSendRequest.municipality = municipality;
                            }
                        )
                    ]))
                )
            )
        );
    }
}