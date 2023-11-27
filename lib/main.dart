import 'package:flutter/material.dart';
import 'package:lecturajson/interfaces/noticias.dart';
import 'package:lecturajson/providers/provider_noticias.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Noticias DataTable'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: showList(),
        ),
      ),
    );
  }

  Widget showList() {
    ScrollController _scrollController = ScrollController();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder<List<Noticias>>(
          future: listNoticias.cargarNoticias(),
          initialData: [],
          builder: (context, AsyncSnapshot<List<Noticias>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return DataTable(
                columnSpacing: 10.0,
                dividerThickness: 1.0,
                headingRowColor:
                    MaterialStateColor.resolveWith((states) => Colors.blue),
                columns: [
                  DataColumn(
                      label: Text('Titulo',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white))),
                  DataColumn(
                      label: Text('Descripción',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white))),
                  DataColumn(
                      label: Text('Icono',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white))),
                  DataColumn(
                      label: Text('Fecha',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white))),
                ],
                rows: listWidgetNoticias(snapshot.data!, context),
              );
            }
          },
        ),
      ),
    );
  }

  List<DataRow> listWidgetNoticias(List<Noticias> data, BuildContext context) {
    return data.map((Noticias noticias) {
      return DataRow(
        cells: [
          DataCell(
            Container(
              width: 100.0,
              child: Text(
                noticias.titulo,
                style: TextStyle(fontSize: 10.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          DataCell(
            Container(
              width: 120.0,
              child: Text(
                noticias.descripcion,
                style: TextStyle(fontSize: 10.0),
                maxLines: 20,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          DataCell(
            Container(
              width: 50.0,
              height: 30.0,
              child: Text(
                noticias.icono,
                style: TextStyle(fontSize: 10.0),
                maxLines: 20,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          DataCell(
            Container(
              width: 80.0,
              child: Text(
                noticias.fechaPublicacion ?? 'N/A',
                style: TextStyle(fontSize: 10.0),
                maxLines: 20,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}
