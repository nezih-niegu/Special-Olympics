import 'package:flutter/material.dart';
import 'package:special_olympics_app/widgets/section_tile.dart';

import './volunteer_request_screen.dart';
import './professional_request_screen.dart';
import './coach_request_screen.dart';

class VolunteersScreen extends StatelessWidget{
    static const routeName = '/volunteers';

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(title: Text('Participar como: ')),
            body: GridView(
                padding: EdgeInsets.all(30),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 4 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10
                ),
                children: [
                    SectionTile(
                        title: 'Voluntario en eventos',
                        description: 'Acompaña a nuestros atletas y compañeros unificados como miembro del staff y vive un día inolvidable. Regístrate aquí para recibir más información',
                        route: VolunteerRequestScreen.routeName
                    ),
                    SectionTile(
                        title: 'Voluntario ofreciendo servicios profesionales',
                        description: 'Se parte de nuestro movimiento aprovechando tus conocimientos para beneficio de personas con discapacidad y/o sus familias. Regístrate aquí para recibir más información.',
                        route: ProfessionalRequestScreen.routeName,
                    ),
                    SectionTile(
                        title: 'Entrenador voluntario',
                        description: 'Si te gusta el deporte, ayuda a nuestros atletas a mejorar su desempeño deportivo. Regístrate aquí para recibir más información.',
                        route: CoachRequestScreen.routeName
                    )
                ]
            )
        );
    }
}