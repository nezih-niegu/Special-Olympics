import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/municipality_provider.dart';
import '../providers/auth_provider.dart';
import '../models/municipality.dart';
import '../providers/club_provider.dart';
import '../providers/municipality_id_provider.dart';
import './club_screen.dart';
import './create_club_screen.dart';

class ClubsScreen extends StatelessWidget{
    static const routeName = '/clubs';

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(title: Text('Ver clubes')),
            body: ChangeNotifierProvider.value(
                value: MunicipalityIdProvider(),
                child: FutureBuilder(
                    future: Provider.of<MunicipalityProvider>(
                        context,
                        listen: false
                    ).index(Provider.of<AuthProvider>(
                        context,
                        listen: false
                    ).stateId),
                    builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                            return Center(child: CircularProgressIndicator());
                        }
                        if(snapshot.error != null){
                            return Center(child: Text(snapshot.error.toString()));
                        }

                        return Column(children: [
                            Padding(
                                padding: EdgeInsets.all(20),
                                child: DropdownButton<int>(
                                    value: Provider.of<MunicipalityIdProvider>(context).municipalityId,
                                    hint: Text('Selecciona un municipio'),
                                    onChanged: (int municipalityId){
                                        Provider.of<MunicipalityIdProvider>(
                                            context,
                                            listen: false
                                        ).setMunicipality(municipalityId);
                                    },
                                    items: (snapshot.data as List<MunicipalityIndexResponseItem>).map((municipalityIndexResponseItem){
                                        return DropdownMenuItem<int>(
                                            value: municipalityIndexResponseItem.id,
                                            child: Text(municipalityIndexResponseItem.name)
                                        );
                                    }).toList(),
                                )
                            ),
                            Divider(),
                            if(Provider.of<MunicipalityIdProvider>(context).municipalityId != null) FutureBuilder(
                                future: Provider.of<ClubProvider>(
                                    context,
                                    listen: false
                                ).index(Provider.of<MunicipalityIdProvider>(context).municipalityId),
                                builder: (context, snapshot){
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                        return Expanded(child: Center(child: CircularProgressIndicator()));
                                    }
                                    if(snapshot.error != null){
                                        return Expanded(child: Center(child: Text(snapshot.error.toString())));
                                    }

                                    return Expanded(child: ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, i){
                                            return Column(children: [
                                                ListTile(
                                                    leading: Icon(Icons.place),
                                                    title: Text(snapshot.data[i].name),
                                                    onTap: (){
                                                        Navigator.of(context).pushNamed(
                                                            ClubScreen.routeName,
                                                            arguments: {
                                                                'id': snapshot.data[i].id,
                                                                'name': snapshot.data[i].name
                                                            }
                                                        );
                                                    }
                                                ),
                                                Divider()
                                            ]);
                                        }
                                    ));
                                }
                            )
                        ]);
                    }
                )
            )
        );
    }
}