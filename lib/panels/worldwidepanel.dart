import 'package:flutter/material.dart';

class WorldWidePanel extends StatelessWidget {
  final Map worldData;

  const WorldWidePanel({Key key, this.worldData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
        ),
        children: <Widget>[
          StatusPanel(
            title: 'Confirmed',
            panelColor: Colors.red[100],
            textColor: Colors.red,
            count: '${worldData['cases']}',
          ),
          StatusPanel(
            title: 'Active',
            panelColor: Colors.blue[100],
            textColor: Colors.blue,
            count: '${worldData['active']}',
          ),
          StatusPanel(
            title: 'Recovered',
            panelColor: Colors.green[100],
            textColor: Colors.green,
            count: '${worldData['recovered']}',
          ),
          StatusPanel(
             title: 'Deaths',
            panelColor: Colors.grey[400],
            textColor: Colors.grey,
            count: '${worldData['deaths']}',
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel({Key key, this.panelColor, this.textColor, this.title, this.count}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 80.0,
      margin: EdgeInsets.all(5.0),
      color: panelColor,
      width: width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
              fontSize: 16.0
            ),
          ),
          Text(
            count,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
              fontSize: 16.0
            )
          )
        ],
      ),
    );
  }
}