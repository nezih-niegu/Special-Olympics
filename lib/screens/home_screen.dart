import 'package:flutter/material.dart';

import '../widgets/section_tile.dart';
import './sports_screen.dart';
import './clubs_info_screen.dart';
import './community_screen.dart';
import './testimonial_categories_screen.dart';
import './programs_screen.dart';
import './about_us_screen.dart';

class HomeScreen extends StatelessWidget{
    static const routeName = '/home';

    @override
    Widget build(BuildContext context){
        return GridView(
            padding: const EdgeInsets.all(25),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 4 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10
            ),
            children: [
                SectionTile(
                    title: 'Sobre nosotros',
                    route: AboutUsScreen.routeName,
                ),
                SectionTile(
                    title: 'Deportes',
                    description: 'Conoce los deportes que se practican en nuestro sub-programa, así como en qué municipios hay entrenamientos de cada uno de ellos.',
                    route: SportsScreen.routeName
                ),
                SectionTile(
                    title: 'Clubes',
                    description: 'Conoce dónde entrenan nuestros atletas.',
                    route: ClubsInfoScreen.routeName
                ),
                SectionTile(
                    title: 'Comunidad',
                    description: 'Conoce los diferentes roles en los que puedes ser parte de nuestro movimiento.',
                    route: CommunityScreen.routeName
                ),
                SectionTile(
                    title: 'Testimonios',
                    description: 'Conoce algunas historias de éxito.',
                    route: TestimonialCategoriesScreen.routeName,
                ),
                SectionTile(
                    title: 'Programas innovadores',
                    description: 'Somos mucho más que deporte, conoce lo que ofrecemos en este movimiento.',
                    route: ProgramsScreen.routeName
                )
            ]
        );
    }
}