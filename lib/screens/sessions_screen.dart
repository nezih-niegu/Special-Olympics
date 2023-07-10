import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/session_provider.dart';
import '../models/session.dart';


class SessionsScreen extends StatefulWidget{
    static const routeName = '/sessions';

    @override
    _SessionsScreenState createState(){
        return _SessionsScreenState();
    }
}
class _SessionsScreenState extends State<SessionsScreen>{
    @override
    void initState(){
        super.initState();
        SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
        ]);
    }

    @override
    void dispose() {
        SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
        ]);
        super.dispose();
    }
    
    @override
    Widget build(BuildContext context){
        final args = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
        final clubId = args['club_id'];
        final clubName = args['club_name'];

        final now = DateTime.now();
        final startOfWeek = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday));
        const days = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];

        return Scaffold(
            appBar: AppBar(title: Text('Entrenamientos de: ${clubName}')),
            body: FutureBuilder(
                future: Provider.of<SessionProvider>(
                    context,
                    listen: false
                ).index(clubId),
                builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                    }
                    if(snapshot.error != null){
                        return Center(child: Text(snapshot.error.toString()));
                    }

                    Future.delayed(Duration.zero, () => {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Arrastra para buscar entrenamientos'),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            action: SnackBarAction(
                                textColor: Colors.white,
                                label: 'OK',
                                onPressed: (){
                                    Scaffold.of(context).hideCurrentSnackBar();
                                }
                            )
                        ))
                    });

                    return WeekView(
                        dates: [
                            startOfWeek,
                            startOfWeek.add(Duration(days: 1)),
                            startOfWeek.add(Duration(days: 2)),
                            startOfWeek.add(Duration(days: 3)),
                            startOfWeek.add(Duration(days: 4)),
                            startOfWeek.add(Duration(days: 5)),
                            startOfWeek.add(Duration(days: 6))
                        ],
                        dateFormatter: (int year, int month, int day){
                            return days[DateTime(year, month, day).weekday - 1];
                        },
                        dayViewWidth: 100,
                        dayBarTextStyle: TextStyle(
                            fontSize: 10
                        ),
                        events: (snapshot.data as List<SessionIndexResponseItem>).map((sessionIndexResponseItem){
                            return FlutterWeekViewEvent(
                                title: sessionIndexResponseItem.practiceActivity,
                                description: '',
                                start: startOfWeek.add(Duration(days: sessionIndexResponseItem.day)).add(Duration(hours: DateTime.parse('${DateFormat('yyyy-MM-dd').format(now)} ${sessionIndexResponseItem.start}').hour)),
                                end: startOfWeek.add(Duration(days: sessionIndexResponseItem.day)).add(Duration(hours: DateTime.parse('${DateFormat('yyyy-MM-dd').format(now)} ${sessionIndexResponseItem.end}').hour))
                            );
                        }).toList()
                    );
                }
            )
        );
    }
}