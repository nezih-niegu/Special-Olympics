import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget{
    final String name;
    final String imageUrl;
    final String imageName;
    final Function onTap;

    ItemTile({
        this.name,
        this.imageUrl,
        this.imageName,
        this.onTap
    });

    @override
    Widget build(BuildContext context){
        return InkWell(
            onTap: onTap,
            child: Card(
                elevation: 4,
                margin: EdgeInsets.all(10),
                child: Stack(children: [
                    if(imageUrl != null) Image.network(
                        imageUrl,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                    ),
                    if(imageName != null) Image.asset(
                        'assets/images/${imageName}',
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                    ),
                    Positioned(
                        bottom: 20,
                        right: 10,
                        child: Container(
                            width: 300,
                            color: Colors.black54,
                            padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 20
                            ),
                            child: Text(
                                name,
                                style: Theme.of(context).textTheme.headline6,
                                softWrap: true,
                                overflow: TextOverflow.fade
                            )
                        )
                    )
                ])
            ),
        );
    }
}