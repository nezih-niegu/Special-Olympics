import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class ManualScreen extends StatelessWidget{
    static const routeName = '/manual';

    Widget build(BuildContext context){
        final args = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
        final id = args['id'];
        final name = args['name'];
        final type =  args['type'];
        final file = args['file'];

        return Scaffold(
            appBar: AppBar(title: Text('Manual de: ${name}')),
            body: FutureBuilder(
                future: file == null ? PDFDocument.fromURL('http://special-olympics-api.herokuapp.com/${type}s/${id}/manual') : PDFDocument.fromFile(file),
                builder: (context, snapshot){
                    return snapshot.connectionState == ConnectionState.waiting ? Center(child: CircularProgressIndicator()) : PDFViewer(document: snapshot.data);
                }
            )
        );
    }
}