import 'package:flutter/material.dart';

class Search extends SearchDelegate {

  final List countryList;

  Search(this.countryList);

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
        final suggestionList = query.isEmpty?countryList:countryList.where((element)=>element['country'].toString().toLowerCase().startsWith(query)).toList();
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
                              '${suggestionList[index]['country']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Image.network('${suggestionList[index]['countryInfo']['flag']}',height: 50,width: 60),
                          ],
                        )
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Confirmed - ${suggestionList[index]['cases']}',      
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),           
                              ),
                              Text(
                                'Active - ${suggestionList[index]['active']}',
                                 style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),            
                              ),
                              Text(
                                'Recovered - ${suggestionList[index]['recovered']}',
                                 style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),      
                              ),
                              Text(
                                'Deaths - ${suggestionList[index]['deaths']}',
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