import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'search.dart';

class CountryPage extends StatefulWidget {
  
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {

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
    fetchCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search
            ),
            onPressed: (){
              showSearch(context: (context), delegate: Search(countryData));
            },
          )
        ],
        title: Text(
          'Country Stats'
        ),
      ),
      body: countryData == null ? CircularProgressIndicator(): ListView.builder(
        itemBuilder: (context,index){
          return Card(
            child: Container(
              height: 130.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [ BoxShadow(
                  color: Colors.grey[100],
                  blurRadius: 10,
                  offset: Offset(0, 10),
                )],
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 200.0,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          countryData[index]['country'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Image.network(countryData[index]['countryInfo']['flag'],height: 50,width: 60),
                      ],
                    )
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Confirmed' + countryData[index]['cases'].toString(),      
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),           
                          ),
                          Text(
                            'Active' + countryData[index]['active'].toString(),
                             style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),            
                          ),
                          Text(
                            'Recovered' + countryData[index]['recovered'].toString(),
                             style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),      
                          ),
                          Text(
                            'Deaths' + countryData[index]['deaths'].toString(),
                             style: TextStyle(
                              color: Theme.of(context).brightness==Brightness.dark?Colors.grey[100]:Colors.grey[900],
                              fontWeight: FontWeight.bold,
                            ),          
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: countryData == null ? 0 : countryData.length,
      ),
    );
  }
}