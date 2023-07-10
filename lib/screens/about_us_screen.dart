import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget{
    static const routeName = '/about-us';

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(title: Text('Sobre nosotros')),
            body: SingleChildScrollView(child: Column(children: [
                Image.asset(
                    'assets/images/about-us.jpg',
                    fit: BoxFit.cover,
                    height: 300,
                    width: double.infinity,
                ),
                Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
                                'Quiénes Somos',
                                style: Theme.of(context).textTheme.subtitle2
                            ),
                            RichText(text: TextSpan(children: [
                                TextSpan(
                                    text: 'Special Olympics',
                                    style: Theme.of(context).textTheme.subtitle2,
                                ),
                                TextSpan(
                                    text: ' es un movimiento de inclusión global que utiliza programas de deporte, salud, educación y liderazgo todos los días en todo el mundo para terminar con la discriminación y empoderar a las personas con discapacidad intelectual.',
                                    style: Theme.of(context).textTheme.bodyText2
                                )
                            ])),
                            SizedBox(height: 10),
                            RichText(text: TextSpan(children: [
                                TextSpan(
                                    text: 'Fundado en 1968, el movimiento ',
                                    style: Theme.of(context).textTheme.bodyText2
                                ),
                                TextSpan(
                                    text: 'Special Olympics',
                                    style: Theme.of(context).textTheme.subtitle2,
                                ),
                                TextSpan(
                                    text: ' ha crecido a más de 5 millones de atletas. Con el apoyo de más de 1 millón de entrenadores y voluntarios, ',
                                    style: Theme.of(context).textTheme.bodyText2
                                ),
                                TextSpan(
                                    text: 'Special Olympics',
                                    style: Theme.of(context).textTheme.subtitle2,
                                ),
                                TextSpan(
                                    text: ' ofrece 32 deportes de tipo olímpico y más de 108,000 juegos y competencias durante todo el año.',
                                    style: Theme.of(context).textTheme.bodyText2
                                )
                            ])),
                            SizedBox(height: 10),
                            RichText(text: TextSpan(
                                text: 'En México este movimiento tiene presencia en 23 Estados, de los cuales Puebla es uno de los orgullosos representantes. Nuestro Estado ha trabajado activamente desde 1989 y en estos años hemos podido apoyar los sueños de más de 1500 atletas.',
                                style: Theme.of(context).textTheme.bodyText2
                            )),
                            SizedBox(height: 20),
                            Text(
                                'Misión',
                                style: Theme.of(context).textTheme.subtitle2
                            ),
                            RichText(text: TextSpan(children: [
                                TextSpan(
                                    text: 'Proporcionar entrenamiento deportivo todo el año y competencia atlética en una variedad de deportes olímpicos para niños y adultos con discapacidad intelectual. Esto les da oportunidades para seguir desarrollando su condición física, demostrar su valor, experimentar alegría y participar en el intercambio de habilidades y amistad con sus familias y otros atletas de ',
                                    style: Theme.of(context).textTheme.bodyText2
                                ),
                                TextSpan(
                                    text: 'Special Olympics',
                                    style: Theme.of(context).textTheme.subtitle2,
                                ),
                                TextSpan(
                                    text: ' y la comunidad.',
                                    style: Theme.of(context).textTheme.bodyText2
                                )
                            ])),
                            SizedBox(height: 20),
                            Text(
                                'Visión',
                                style: Theme.of(context).textTheme.subtitle2
                            ),
                            RichText(text: TextSpan(
                                text: 'Abrir los corazones y mentes de las personas con discapacidad intelectual a través del deporte, para crear comunidades inclusivas en todo el mundo.',
                                style: Theme.of(context).textTheme.bodyText2
                            )),
                            SizedBox(height: 20),
                            Text(
                                'Filosofía',
                                style: Theme.of(context).textTheme.subtitle2
                            ),
                            RichText(text: TextSpan(
                                text: 'Integrar a la sociedad a personas con discapacidad intelectual, dentro de un marco de respeto, aceptación y equidad, apoyando a sus familias y sirviendo como puente con otras instituciones, tanto del sector público como privado, para que puedan alcanzar su potencial físico y mental.',
                                style: Theme.of(context).textTheme.bodyText2
                            )),
                            SizedBox(height: 20),
                            Text(
                                'Valores',
                                style: Theme.of(context).textTheme.subtitle2
                            ),
                            RichText(text: TextSpan(
                                text: 'Inclusión, respeto, conﬁanza, alegría, unidad, cuidado de la salud, fortaleza, competitividad y gratitud.',
                                style: Theme.of(context).textTheme.bodyText2
                            ))
                        ]
                    )
                )
            ]))
        );
    }
}