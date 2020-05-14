import 'package:covidtracker/datasource.dart';
import 'package:covidtracker/pages/countrypage.dart';
import 'package:covidtracker/panels/infopanel.dart';
import 'package:covidtracker/panels/mostaffectedcountries.dart';
import 'package:covidtracker/panels/worldwidepanel.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map worldWideData;
  fetchWorldWideData() async {
    http.Response response = await http.get("https://corona.lmao.ninja/v2/all");
    setState(() {
      worldWideData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response = await http.get("https://corona.lmao.ninja/v2/countries?sort=cases");
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
  }

@override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Covid Tracker'
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Theme.of(context).brightness==Brightness.light?Icons.lightbulb_outline:Icons.highlight
            ),
            onPressed: (){
              DynamicTheme.of(context).setBrightness(Theme.of(context).brightness==Brightness.light?Brightness.dark:Brightness.light);
            },
          )
        ],
        centerTitle: false,
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10.0),
                height: 100.0,
                color: Colors.orange[100],
                child: Text(
                  DataSource.quote,
                  style: TextStyle(
                    color: Colors.orange[800],
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'WorldWide',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CountryPage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryBlack,
                          borderRadius: BorderRadius.circular(
                            15
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Regional',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              worldWideData == null ? CircularProgressIndicator() : WorldWidePanel(worldData: worldWideData),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: PieChart(
                  dataMap: {
                    'Confirmed': worldWideData['cases'].toDouble(),
                    'Active': worldWideData['active'].toDouble(),
                    'Recovered': worldWideData['recovered'].toDouble(),
                    'Deaths': worldWideData['deaths'].toDouble(),
                  },
                  colorList: [
                    Colors.red,
                    Colors.blue,
                    Colors.green,
                    Colors.grey[900]
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Most Affected Countries',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              countryData == null?Container():MostAffectedPanel(countryData: countryData),
              InfoPanel(),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "We are Together in the Fight",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              )
            ],
          ),
        ),
      )
    );
  }
}