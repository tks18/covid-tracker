import 'package:covidtracker/datasource.dart';
import 'package:covidtracker/panels/mostaffectedcountries.dart';
import 'package:covidtracker/panels/worldwidepanel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    http.Response response = await http.get("https://corona.lmao.ninja/v2/countries");
    setState(() {
      countryData = json.decode(response.body);
    });
  }

@override
  void initState() {
    super.initState();
    fetchWorldWideData();
    fetchCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Covid Tracker'
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
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
                  Container(
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
                ],
              ),
            ),
            worldWideData == null ? CircularProgressIndicator() : WorldWidePanel(worldData: worldWideData),
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
          ],
        ),
      )
    );
  }
}