import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:async';
import 'package:flutter_covid_chart/covidapi.dart';
import 'package:flutter_covid_chart/model/newinfect.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List<NewInfect>> _data;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  refresh() {
    _data = CovidAPI.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('COVID-19 : Latest 10 day infection statistics', style: TextStyle(fontSize: 16)),            
            backgroundColor: Colors.red,
          ),
          backgroundColor: Colors.black,
          body: FutureBuilder(
              future: _data,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done)
                  return new charts.BarChart(dataList(snapshot.data),
                      animate: true,
                      barRendererDecorator:
                          new charts.BarLabelDecorator<String>(),
                      domainAxis: new charts.OrdinalAxisSpec(
                          renderSpec: new charts.SmallTickRendererSpec(

                              // Tick and Label styling here.
                              labelStyle: new charts.TextStyleSpec(
                                  fontSize: 12, // size in Pts.
                                  color: charts
                                      .MaterialPalette.yellow.shadeDefault),

                              // Change the line colors to match text color.
                              lineStyle: new charts.LineStyleSpec(
                                  color: charts
                                      .MaterialPalette.red.shadeDefault))),
                      primaryMeasureAxis: new charts.NumericAxisSpec(
                          renderSpec: new charts.GridlineRendererSpec(

                              // Tick and Label styling here.
                              labelStyle: new charts.TextStyleSpec(
                                  fontSize: 12, // size in Pts.
                                  color: charts
                                      .MaterialPalette.yellow.shadeDefault),

                              // Change the line colors to match text color.
                              lineStyle: new charts.LineStyleSpec(
                                  color: charts
                                      .MaterialPalette.red.shadeDefault))));
                else
                  return Center(child: CircularProgressIndicator());
              }),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.yellowAccent,
            onPressed: () => setState(() => refresh()),
            tooltip: 'refresh..',
            child: const Icon(Icons.refresh, color: Colors.black),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop
          ),
    );
  }
}

List<charts.Series<NewInfect, String>> dataList(List<NewInfect> _list) {
  return [
    new charts.Series<NewInfect, String>(
        id: 'Covid Infect',
        domainFn: (NewInfect items, _) => items.date,
        measureFn: (NewInfect items, _) => items.total,
        data: _list,
        labelAccessorFn: (NewInfect item, _) => '${item.total}',
        insideLabelStyleAccessorFn: (NewInfect sales, _) {
          return new charts.TextStyleSpec(
              color: charts.MaterialPalette.yellow.shadeDefault);
        },
        fillColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault
        // labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
        )
  ];
}

// class User {
//   final String name;
//   final int age;
//   final String gender;

//   User({this.name, this.age, this.gender});

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       name: json['name'],
//       age: json['age'],
//       gender: json['gender'],
//     );
//   }
// }

//Future<List<User>> getUser() async {
//  final response =
//      await http.get('http://www.thaiticketmajor.com/aeh/myjson.php');
//
//  if (response.statusCode == 200) {
//    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//    return parsed.map<User>((json) => User.fromJson(json)).toList();
//  } else {
//    throw Exception('Failed to load album');
//  }
//}

//class MyData extends StatefulWidget {
//  @override
//  _MyDataState createState() => _MyDataState();
//}

//class _MyDataState extends State<MyData> {
//  @override
//  void initState() {
//    super.initState();
//    getData();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return null;
//  }
//}

//class MyLayout extends StatelessWidget {
//
//  void getData() async {
//    final result = await http.get('http://www.thaiticketmajor.com/aeh/myjson.php');
//    print(result);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Scaffold(
//          body: SafeArea(
//        child: Container(
//          child: Text('ABC'),
//        ),
//      )),
//    );
//  }
//}
