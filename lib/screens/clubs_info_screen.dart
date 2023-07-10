import 'package:flutter/material.dart';

import './clubs_screen.dart';
import './create_club_screen.dart';

class ClubsInfoScreen extends StatelessWidget{
    static const routeName = '/clubs-info';

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(title: Text('Clubes')),
            body: SingleChildScrollView(child: Column(children: [
                Image.asset(
                    'assets/images/clubs.jpg',
                    fit: BoxFit.cover,
                    height: 300,
                    width: double.infinity
                ),
                Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            RichText(text: TextSpan(children: [
                                TextSpan(
                                    text: 'Special Olympics',
                                    style: Theme.of(context).textTheme.subtitle2
                                ),
                                TextSpan(
                                    text: ' México-Puebla cuenta con diversos clubes, cada uno entrena diferentes deportes en los horarios y lugares definidos por ellos mismos. Te invitamos a conocerlos y poder formar parte del más cercano a tu localidad. Si cerca de ti no existe un club puedes compartirnos tus datos en la sección “Quiero Abrir Un Club”',
                                    style: Theme.of(context).textTheme.bodyText2
                                )
                            ])),
                            SizedBox(height: 20),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                    RaisedButton(
                                        color: Theme.of(context).primaryColor,
                                        child: Text(
                                            'Ver clubes',
                                            style: Theme.of(context).textTheme.button
                                        ),
                                        onPressed: (){
                                            Navigator.of(context).pushNamed(ClubsScreen.routeName);
                                        }
                                    ),
                                    RaisedButton(
                                        color: Theme.of(context).primaryColor,
                                        child: Text(
                                            'Quiero abrir un club',
                                            style: Theme.of(context).textTheme.button
                                        ),
                                        onPressed: (){
                                            Navigator.of(context).pushNamed(CreateClubScreen.routeName);
                                        }
                                    )
                                ]
                            )
                        ]
                    )
                )
            ]))
        );
    }
}