import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/participant.dart';
import '../providers/participant_provider.dart';
import '../providers/auth_provider.dart';

class ProfessionalRequestScreen extends StatefulWidget{
    static const routeName = '/professional-screen';

    @override
    _ProfessionalRequestScreenState createState(){
        return _ProfessionalRequestScreenState();
    }
}

class _ProfessionalRequestScreenState extends State<ProfessionalRequestScreen>{
    final _professionalRequestForm = GlobalKey<FormState>();
    var _professionalRequestSendRequest = ProfessionalRequestSendRequest(
        name: '',
        phone: '',
        email: '',
        about: '',
        services: ''
    );
    final _phoneFocusNode = FocusNode();
    final _emailFocusNode = FocusNode();
    final _aboutFocusNode = FocusNode();
    final _servicesFocusNode = FocusNode();

    @override
    void dispose(){
        _phoneFocusNode.dispose();
        _emailFocusNode.dispose();
        _aboutFocusNode.dispose();
        _servicesFocusNode.dispose();
        
        super.dispose();
    }

    Future<void> _sendProfessionalRequest() async{
        if(!_professionalRequestForm.currentState.validate()){
            return;
        }
        _professionalRequestForm.currentState.save();

        try{
            await Provider.of<ParticipantProvider>(
                context,
                listen: false
            ).sendProfessionalRequest(Provider.of<AuthProvider>(
                context,
                listen: false
            ).stateId, _professionalRequestSendRequest);

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
                title: Text('Solicitud: voluntario profesional'),
                actions: [
                    IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _sendProfessionalRequest
                    )
                ]
            ),
            body: Padding(
                padding: EdgeInsets.all(30),
                child: Form(
                    key: _professionalRequestForm,
                    child: SingleChildScrollView(child: Column(children: [
                        TextFormField(
                            initialValue: _professionalRequestSendRequest.name,
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
                                _professionalRequestSendRequest.name = name;
                            }
                        ),
                        TextFormField(
                            initialValue: _professionalRequestSendRequest.phone,
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
                                _professionalRequestSendRequest.phone = phone;
                            }
                        ),
                        TextFormField(
                            initialValue: _professionalRequestSendRequest.email,
                            decoration: InputDecoration(labelText: 'E-mail'),
                            textInputAction: TextInputAction.next,
                            focusNode: _emailFocusNode,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_servicesFocusNode);
                            },
                            validator: (email){
                                if(email.isEmpty){
                                    return 'El email es requerido';
                                }

                                return null;
                            },
                            onSaved: (email){
                                _professionalRequestSendRequest.email = email;
                            }
                        ),
                        TextFormField(
                            initialValue: _professionalRequestSendRequest.services,
                            decoration: InputDecoration(labelText: 'Servicios ofrecidos'),
                            textInputAction: TextInputAction.next,
                            focusNode: _servicesFocusNode,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_aboutFocusNode);
                            },
                            validator: (services){
                                if(services.isEmpty){
                                    return 'Los servicios son requeridos';
                                }

                                return null;
                            },
                            onSaved: (services){
                                _professionalRequestSendRequest.services = services;
                            }
                        ),
                        TextFormField(
                            initialValue: _professionalRequestSendRequest.about,
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
                                _professionalRequestSendRequest.about = about;
                            }
                        )
                    ]))
                )
            )
        );
    }
}