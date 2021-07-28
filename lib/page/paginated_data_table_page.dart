import 'dart:math';
import 'package:flutter/material.dart';

class PaginatedDataTablePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PaginatedPageState();
}

class _PaginatedPageState extends State<PaginatedDataTablePage> {
  SourceData _sourceData = SourceData();
  var _rowsPerPage = 8;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('PaginatedDataTable Page')),
            body: SingleChildScrollView(
                child: Column(children: [
              SizedBox(height: 10),
              PaginatedDataTable(
                  source: _sourceData,
                  header: Text('Flight Products'),
                  actions: [Icon(Icons.refresh), Icon(Icons.clear)],
                  headingRowHeight: 50.0,
                  dataRowHeight: 60.0,
                  // horizontalMargin: 40.0,
                  // columnSpacing: 40.0,
                  // showCheckboxColumn: true,
                  // rowsPerPage: 8,
                  // initialFirstRowIndex: 20,

                  rowsPerPage: _rowsPerPage,
                  onPageChanged: (i) => print('onPageChanged -> $i'),
                  availableRowsPerPage: [8, 16, 20],
                  onRowsPerPageChanged: (value) =>
                      setState(() => _rowsPerPage = value),
                  sortAscending: _sortAscending,
                  sortColumnIndex: 1,
                  showCheckboxColumn: true,
                  onSelectAll: (state) =>
                      setState(() => _sourceData.selectAll(state)),
                  columns: [
                    DataColumn(label: Text('Avatar')),
                    DataColumn(
                        label: Text('ID'),
                        onSort: (index, sortAscending) {
                          setState(() {
                            _sortAscending = sortAscending;
                            _sourceData.sortData(
                                (map) => map['id'], sortAscending);
                          });
                        }),
                    DataColumn(label: Text('Name')),
                    DataColumn(
                        label: Row(children: [
                      Text('Price'),
                      SizedBox(width: 5.0),
                      Icon(Icons.airplanemode_active)
                    ])),
                    DataColumn(label: Text('No.')),
                    DataColumn(label: Text('Address'))
                  ])
            ]))));
  }
}

class SourceData extends DataTableSource {
  int _selectCount = 0; //当前选中的行数
  final List<Map<String, dynamic>> _sourceData = List.generate(
      200,
      (index) => {
            "avatar": (index % 3 == 1)
                ? 'images/icon_hzw01.jpg'
                : (index % 3 == 2)
                    ? 'images/icon_hzw03.jpg'
                    : 'images/icon_music.png',
            "id": (index + 1),
            "name": "Item Name ${(index + 1)}",
            "price": Random().nextInt(10000),
            "no.": Random().nextInt(10000),
            "address": (index % 3 == 1)
                ? 'Beijing'
                : (index % 3 == 2)
                    ? 'New York'
                    : 'Los Angeles',
            "selected": false
          });

  bool get isRowCountApproximate => false;

  int get rowCount => _sourceData.length;

  int get selectedRowCount => _selectCount;

  DataRow getRow(int index) => DataRow.byIndex(
          index: index,
          selected: _sourceData[index]["selected"],
          onSelectChanged: (selected) {
            _sourceData[index]["selected"] = selected;
            notifyListeners();
          },
          cells: [
            DataCell(CircleAvatar(
                backgroundImage: AssetImage(_sourceData[index]["avatar"]))),
            DataCell(Text(_sourceData[index]['id'].toString())),
            DataCell(Text(_sourceData[index]['name'])),
            DataCell(Text('\$ ${_sourceData[index]['price']}')),
            DataCell(Text(_sourceData[index]['no.'].toString())),
            DataCell(Text(_sourceData[index]['address'].toString()))
          ]);

  void sortData<T>(Comparable<T> getField(Map<String, dynamic> map), bool b) {
    _sourceData.sort((Map<String, dynamic> map1, Map<String, dynamic> map2) {
      if (!b) {
        //两个项进行交换
        final Map<String, dynamic> temp = map1;
        map1 = map2;
        map2 = temp;
      }
      final Comparable<T> s1Value = getField(map1);
      final Comparable<T> s2Value = getField(map2);
      return Comparable.compare(s1Value, s2Value);
    });
    notifyListeners();
  }

  void selectAll(bool checked) {
    _sourceData.forEach((data) => data["selected"] = checked);
    _selectCount = checked ? _sourceData.length : 0;
    notifyListeners(); //通知监听器去刷新
  }
}
