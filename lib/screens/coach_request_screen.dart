import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/participant.dart';
import '../providers/participant_provider.dart';
import '../providers/auth_provider.dart';

class CoachRequestScreen extends StatefulWidget{
    static const routeName = '/coach-request';

    @override
    _CoachRequestScreenState createState(){
        return _CoachRequestScreenState();
    }
}

class _CoachRequestScreenState extends State<CoachRequestScreen>{
    final _coachRequestForm = GlobalKey<FormState>();
    var _coachRequestSendRequest = CoachRequestSendRequest(
        name: '',
        phone: '',
        email: '',
        about: '',
        sports: '',
        municipalities: ''
    );
    final _phoneFocusNode = FocusNode();
    final _emailFocusNode = FocusNode();
    final _aboutFocusNode = FocusNode();
    final _sportsFocusNode = FocusNode();
    final _municipalitiesFocusNode = FocusNode();

    @override
    void dispose(){
        _phoneFocusNode.dispose();
        _emailFocusNode.dispose();
        _aboutFocusNode.dispose();
        _sportsFocusNode.dispose();
        _municipalitiesFocusNode.dispose();
        
        super.dispose();
    }

    Future<void> _sendCoachRequest() async{
        if(!_coachRequestForm.currentState.validate()){
            return;
        }
        _coachRequestForm.currentState.save();

        try{
            await Provider.of<ParticipantProvider>(
                context,
                listen: false
            ).sendCoachRequest(Provider.of<AuthProvider>(
                context,
                listen: false
            ).stateId, _coachRequestSendRequest);

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
                title: Text('Solicitud: entrenador voluntario'),
                actions: [
                    IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _sendCoachRequest
                    )
                ]
            ),
            body: Padding(
                padding: EdgeInsets.all(30),
                child: Form(
                    key: _coachRequestForm,
                    child: SingleChildScrollView(child: Column(children: [
                        TextFormField(
                            initialValue: _coachRequestSendRequest.name,
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
                                _coachRequestSendRequest.name = name;
                            }
                        ),
                        TextFormField(
                            initialValue: _coachRequestSendRequest.phone,
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
                                _coachRequestSendRequest.phone = phone;
                            }
                        ),
                        TextFormField(
                            initialValue: _coachRequestSendRequest.email,
                            decoration: InputDecoration(labelText: 'E-mail'),
                            textInputAction: TextInputAction.next,
                            focusNode: _emailFocusNode,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_sportsFocusNode);
                            },
                            validator: (email){
                                if(email.isEmpty){
                                    return 'El email es requerido';
                                }

                                return null;
                            },
                            onSaved: (email){
                                _coachRequestSendRequest.email = email;
                            }
                        ),
                        TextFormField(
                            initialValue: _coachRequestSendRequest.sports,
                            decoration: InputDecoration(labelText: 'Deportes'),
                            textInputAction: TextInputAction.next,
                            focusNode: _sportsFocusNode,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_municipalitiesFocusNode);
                            },
                            validator: (sports){
                                if(sports.isEmpty){
                                    return 'Los deportes son requeridos';
                                }

                                return null;
                            },
                            onSaved: (sports){
                                _coachRequestSendRequest.sports = sports;
                            }
                        ),
                        TextFormField(
                            initialValue: _coachRequestSendRequest.municipalities,
                            decoration: InputDecoration(labelText: 'Municipios'),
                            textInputAction: TextInputAction.next,
                            focusNode: _municipalitiesFocusNode,
                            onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_aboutFocusNode);
                            },
                            validator: (municipalities){
                                if(municipalities.isEmpty){
                                    return 'Los municipios son requeridos';
                                }

                                return null;
                            },
                            onSaved: (municipalities){
                                _coachRequestSendRequest.municipalities = municipalities;
                            }
                        ),
                        TextFormField(
                            initialValue: _coachRequestSendRequest.about,
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
                                _coachRequestSendRequest.about = about;
                            }
                        )
                    ]))
                )
            )
        );
    }
}