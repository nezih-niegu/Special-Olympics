import 'package:flutter/material.dart';

class SectionTile extends StatelessWidget{
    final String title;
    final String description;
    final String route;
    final Map<String, dynamic> arguments;

    SectionTile({
        this.title,
        this.description,
        this.route,
        this.arguments
    });

    @override
    Widget build(BuildContext context){
        return Ink(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15)
            ),
            child: InkWell(
                onTap: (){
                    Navigator.of(context).pushNamed(
                        route,
                        arguments: arguments
                    );
                },
                borderRadius: BorderRadius.circular(15),
                child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Text(
                                title,
                                style: Theme.of(context).textTheme.headline6
                            ),
                            if(description != null) Container(
                                width: double.infinity,
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                    icon: Icon(Icons.info),
                                    color: Colors.white,
                                    onPressed: () async{
                                        await showDialog(
                                            context: context,
                                            builder: (context){
                                                return AlertDialog(
                                                    title: Text(
                                                        this.title,
                                                        style: TextStyle(color: Colors.black)
                                                    ),
                                                    content: Text(this.description),
                                                    actions: [
                                                        FlatButton(
                                                            child: Text('Ok'),
                                                            onPressed: (){
                                                                Navigator.of(context).pop();
                                                            }
                                                        )
                                                    ]
                                                );
                                            }
                                        );
                                    }
                                )
                            )
                        ]
                    )
                )
            ),
        );
    }
}