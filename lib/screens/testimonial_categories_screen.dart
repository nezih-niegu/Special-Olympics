import 'package:flutter/material.dart';

import '../widgets/item_tile.dart';
import './testimonials_screen.dart';

class TestimonialCategoriesScreen extends StatelessWidget{
    static const routeName = "/testimonial-categories";

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(title: Text('Testimonios')),
            body: ListView(children: [
                ItemTile(
                    name: 'Familias',
                    imageName: 'testimonials-families.jpg',
                    onTap: (){
                        Navigator.of(context).pushNamed(
                            TestimonialsScreen.routeName,
                            arguments: {
                                'type': 0
                            }
                        );
                    },
                ),
                ItemTile(
                    name: 'Atletas',
                    imageName: 'testimonials-athletes.jpg',
                    onTap: (){
                        Navigator.of(context).pushNamed(
                            TestimonialsScreen.routeName,
                            arguments: {
                                'type': 1
                            }
                        );
                    },
                ),
                ItemTile(
                    name: 'Entrenadores',
                    imageName: 'testimonials-coaches.jpg',
                    onTap: (){
                        Navigator.of(context).pushNamed(
                            TestimonialsScreen.routeName,
                            arguments: {
                                'type': 2
                            }
                        );
                    },
                ),
                ItemTile(
                    name: 'Voluntarios',
                    imageName: 'testimonials-volunteers.jpg',
                    onTap: (){
                        Navigator.of(context).pushNamed(
                            TestimonialsScreen.routeName,
                            arguments: {
                                'type': 3
                            }
                        );
                    },
                ),
                ItemTile(
                    name: 'Compañeros unificados',
                    imageName: 'testimonials-partners.jpg',
                    onTap: (){
                        Navigator.of(context).pushNamed(
                            TestimonialsScreen.routeName,
                            arguments: {
                                'type': 4
                            }
                        );
                    },
                ),
                ItemTile(
                    name: 'Aliados',
                    imageName: 'testimonials-allies.jpeg',
                    onTap: (){
                        Navigator.of(context).pushNamed(
                            TestimonialsScreen.routeName,
                            arguments: {
                                'type': 5
                            }
                        );
                    },
                )
            ])
        );
    }
}