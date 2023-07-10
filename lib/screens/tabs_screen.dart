import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import './manuals_screen.dart';
import '../widgets/app_drawer.dart';
import './home_screen.dart';
import './events_screen.dart';
import './contact_screen.dart';

class TabsScreen extends StatefulWidget{
    static const routeName = '/tabs';

    @override
    _TabsScreenState createState(){
        return _TabsScreenState();
    }
}

class _TabsScreenState extends State<TabsScreen>{
    GlobalKey _globalKey = GlobalKey();
    List<Map<String, Object>> _pages;
    int _selectedPageIndex = 1;

    @override initState(){
        _pages = [
            {
                'page': ContactScreen(),
                'title': 'Contacto'
            },
            {
                'page': HomeScreen(),
                'title': 'Inicio'
            },
            {
                'page': EventsScreen(),
                'title': 'Eventos'
            }
        ];

        super.initState();
    }

    void _selectPage(int index){
        setState((){
            _selectedPageIndex = index;
        });
    }

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
                title: Text(_pages[_selectedPageIndex]['title']),
                actions: [
                    if(Provider.of<AuthProvider>(
                        context,
                        listen: false
                    ).isAuth()) IconButton(
                        icon: Icon(Icons.collections_bookmark),
                        onPressed: (){
                            Navigator.of(context).pushNamed(ManualsScreen.routeName);
                        }
                    )
                ]
            ),
            drawer: AppDrawer(),
            body: _pages[_selectedPageIndex]['page'],
            bottomNavigationBar: BottomNavigationBar(
                key: _globalKey,
                onTap: _selectPage,
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.white,
                currentIndex: _selectedPageIndex,
                type: BottomNavigationBarType.shifting,
                items: [
                    BottomNavigationBarItem(
                        backgroundColor: Theme.of(context).primaryColor,
                        icon: Icon(Icons.info),
                        title: Text('Contacto')
                    ),
                    BottomNavigationBarItem(
                        backgroundColor: Theme.of(context).primaryColor,
                        icon: Icon(Icons.home),
                        title: Text('Inicio')
                    ),
                    BottomNavigationBarItem(
                        backgroundColor: Theme.of(context).primaryColor,
                        icon: Icon(Icons.event),
                        title: Text('Eventos')
                    )
                ]
            ),
        );
    }
}