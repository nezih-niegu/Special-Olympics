import 'package:flutter/material.dart';

import '../widgets/section_tile.dart';
import './athlete_request_screen.dart';
import './partner_request_screen.dart';
import './family_request_screen.dart';
import './volunteers_screen.dart';

class CommunityScreen extends StatelessWidget{
    static const routeName = '/community';

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(title: Text('Participar como:')),
            body:  GridView(
                padding: const EdgeInsets.all(25),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 4 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10
                ),
                children: [
                    SectionTile(
                        title: 'Atleta',
                        description: 'En Special Olympics consideramos atletas a todas las personas con discapacidad intelectual que forman parte de nuestro movimiento y practican alguno de los deportes que ofrecemos realizando entrenamientos de manera continua y participando en competencias deportivas. Si quieres ser atleta, compártenos tus datos aquí.',
                        route: AthleteRequestScreen.routeName
                    ),
                    SectionTile(
                        title: 'Compañero unificado',
                        description: 'En Special Olympics consideramos compañeros unificados a todas las personas sin discapacidad que forman parte de nuestro movimiento y participan en alguno de los deportes que ofrecemos realizando entrenamientos de manera continua y participando en competencias deportivas junto con nuestros atletas con discapacidad intelectual. Si quieres ser compañero unificado compártenos tus datos aquí.',
                        route: PartnerRequestScreen.routeName,
                    ),
                    SectionTile(
                        title: 'Familia',
                        description: 'Los familiares de las personas con discapacidad intelectual de nuestro movimiento, conforman redes de apoyo e información y de manera periódica organizan foros destinados a resolver dudas e inquietudes en torno a la discapacidad intelectual. Si eres familiar de un atleta, compártenos tus datos aquí.',
                        route: FamilyRequestScreen.routeName,
                    ),
                    SectionTile(
                        title: 'Voluntario',
                        description: 'En Special Olympics puedes ver como tu tiempo y esfuerzo tiene un impacto inmediato. Ya sea que estés entrenando a un atleta o dirigiendo una oficina, repartiendo medallas, celebrando una victoria, cronometrando una carrera tú estás tocando las vidas de otras personas que sólo piden una oportunidad de participar, tener éxito y crecer. Si quieres ser voluntarios compártenos tus datos aquí.',
                        route: VolunteersScreen.routeName
                    )
                ]
            )
        );
    }
}