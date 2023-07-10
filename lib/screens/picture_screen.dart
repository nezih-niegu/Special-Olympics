import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../models/picture.dart';

class PictureScreen extends StatefulWidget{
    final List<PictureIndexResponseItem> pictures;
    final int startingIndex;
    final String galleryName;
    final PageController pageController;

    PictureScreen({
        this.pictures,
        this.startingIndex,
        this.galleryName
    }) : pageController = PageController(initialPage: startingIndex);

    @override
    _PictureScreenState createState(){
        return _PictureScreenState();
    }
}

class _PictureScreenState extends State<PictureScreen>{
    int currentIndex;

    @override
    void initState(){
        currentIndex = widget.startingIndex;
        super.initState();
    }

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(title: Text('Galería de: ${widget.galleryName}')),
            body: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (context, i){
                    return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage('https://special-olympics-api.herokuapp.com/pictures/${widget.pictures[i].id}'),
                        initialScale: PhotoViewComputedScale.contained,
                        heroAttributes: PhotoViewHeroAttributes(tag: widget.pictures[i].id)
                    );
                },
                itemCount: widget.pictures.length,
                loadingBuilder: (context, event){
                    return Center(child: CircularProgressIndicator());
                },
                backgroundDecoration: BoxDecoration(color: Theme.of(context).canvasColor),
                pageController: widget.pageController,
                onPageChanged: (int index){
                    setState((){
                        currentIndex = index;
                    });
                }
            )
        );
    }
}