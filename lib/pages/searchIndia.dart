import 'package:covidtracker/datasource.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate {

  final List indiaState;

  Search(this.indiaState);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: primaryBlack,
      brightness: DynamicTheme.of(context).brightness
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(
          icon: Icon(
            Icons.clear
          ),
          onPressed: (){
            query='';
          },
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(
        icon: Icon(
          Icons.arrow_back_ios
        ),
        onPressed: (){
          Navigator.pop(context);
        },
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      return Container(

      );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      {
        final suggestionList = query.isEmpty?indiaState:indiaState.where((element)=>element['state'].toString().toLowerCase().startsWith(query)).toList();
          return ListView.builder(
            itemBuilder: (context, index) {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 200.0,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      '${indiaState[index]['state']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Confirmed - ${indiaState[index]['confirmed']}',      
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),           
                          ),
                          Text(
                            'Active - ${indiaState[index]['active']}',
                             style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),            
                          ),
                          Text(
                            'Recovered - ${indiaState[index]['recovered']}',
                             style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),      
                          ),
                          Text(
                            'Deaths - ${indiaState[index]['deaths']}',
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
            itemCount: suggestionList.length,
          );
      }
  }
  
}