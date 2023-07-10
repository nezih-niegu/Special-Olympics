import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart';
import '../providers/auth_provider.dart';
import './event_screen.dart';

class EventsScreen extends StatefulWidget{
    static const routeName = '/events';

    @override
    _EventsScreenState createState(){
        return _EventsScreenState();
    }    
}

class _EventsScreenState extends State<EventsScreen>{
    List<Map<dynamic, dynamic>> _selectedEvents;
    DateTime _selectedDate;
    final Map<DateTime, List<Map<String, dynamic>>> _events = {};

    void _selectDate(date){
        setState((){
            _selectedDate = date;
            _selectedEvents = _events[_selectedDate] ?? [];
        });
    }

    @override
    void initState(){
        Future.delayed(Duration.zero).then((_) async{
            final events = await Provider.of<EventProvider>(
                context,
                listen: false
            ).index(Provider.of<AuthProvider>(
                context,
                listen: false
            ).stateId);

            setState((){
                events.forEach((eventIndexResponseItem){
                    final startDate = DateTime(eventIndexResponseItem.start.year, eventIndexResponseItem.start.month, eventIndexResponseItem.start.day);
                    final endDate = DateTime(eventIndexResponseItem.end.year, eventIndexResponseItem.end.month, eventIndexResponseItem.end.day);
                    final daySpan = endDate.difference(startDate).inDays.abs() + 1;

                    for(var i = 0; i < daySpan; i++){
                        final date = startDate.add(Duration(days: i));
                        final events = _events[date];
                        final event = {
                            'id': eventIndexResponseItem.id,
                            'responseName': eventIndexResponseItem.name,
                            'name': '${eventIndexResponseItem.name} (de ${DateFormat('dd/MM/yyyy HH:mm').format(eventIndexResponseItem.start)} a ${DateFormat('dd/MM/yyyy HH:mm').format(eventIndexResponseItem.end)})',
                            'isDone': false
                        };
                        
                        _events[date] = events == null ? [event] : [..._events[date], event];
                    }
                });
            });
        });
        _selectedEvents = _events[_selectedDate] ?? [];

        super.initState();
    }

    @override
    Widget build(BuildContext context){
        return Column(children: [
            Container(child: Calendar(
                isExpanded: true,
                events: _events,
                onDateSelected: (date){
                    _selectDate(date);
                },
                showTodayIcon: false,
                eventColor: Theme.of(context).accentColor,
            )),
            Expanded(child: ListView.builder(
                itemCount: _selectedEvents.length,
                itemBuilder: (context, i){
                    return Container(
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(
                            width: 1.5,
                            color: Colors.black12
                        ))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 4
                        ),
                        child: ListTile(
                            leading: Icon(Icons.event),
                            title: Text(_selectedEvents[i]['name'].toString()),
                            onTap: (){
                                Navigator.of(context).pushNamed(
                                    EventScreen.routeName,
                                    arguments: {
                                        'id': _selectedEvents[i]['id'],
                                        'name': _selectedEvents[i]['responseName']
                                    }
                                );
                            }
                        )
                    );
                }
            ))
        ]);
    }
}