import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/state.dart';
import '../providers/auth_provider.dart';
import '../models/http_exception.dart';

class StateSelector extends StatefulWidget{
    final List<StateIndexResponseItem> states;
    final int selectedState;

    StateSelector({
        this.states,
        this.selectedState
    });

    @override
    _StateSelectorState createState(){
        return _StateSelectorState();
    }
}

class _StateSelectorState extends State<StateSelector>{
    int _stateId;

    @override
    void initState(){
        _stateId = widget.selectedState;
        super.initState();
    }

    @override
    Widget build(BuildContext context){
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                DropdownButton<int>(
                    value: _stateId,
                    hint: Text('Selecciona un estado'),
                    onChanged: (int stateId){
                        setState((){
                            _stateId = stateId;
                        });
                    },
                    items: widget.states.map((stateIndexResponseItem){
                        return DropdownMenuItem<int>(
                            value: stateIndexResponseItem.id,
                            child: Text(stateIndexResponseItem.name),
                        );
                    }).toList()
                ),
                RaisedButton(
                    onPressed: () async{
                        try{
                            if(_stateId == null){
                                throw HttpException('Ingrese un estado');
                            }

                            await Provider.of<AuthProvider>(
                                context,
                                listen: false
                            ).setState(_stateId);

                            Navigator.of(context).pushReplacementNamed('/');
                        }catch(error){
                            showDialog(
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
                    },
                    child: Text('Continuar')
                )
            ]
        );
    }
}