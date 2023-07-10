import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/state.provider.dart';
import '../widgets/state_selector.dart';
import '../providers/auth_provider.dart';

class StateScreen extends StatelessWidget{
    static const routeName = '/state';

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(title: Text('Selecciona tu estado')),
            body: Center(child: FutureBuilder(
                future: Provider.of<StateProvider>(
                    context,
                    listen: false
                ).index(),
                builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                        return CircularProgressIndicator();
                    }
                    if(snapshot.error != null){
                        print(snapshot.error);
                        return Text(snapshot.error.toString());
                    }
                    
                    return StateSelector(
                        states: snapshot.data,
                        selectedState: Provider.of<AuthProvider>(
                            context,
                            listen: false
                        ).stateId
                    );
                }
            ))
        );
    }
}