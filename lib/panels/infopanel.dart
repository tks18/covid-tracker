import 'package:covidtracker/datasource.dart';
import 'package:covidtracker/pages/faq.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => FaqPage()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              color: primaryBlack,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "FAQ's",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white
                    )
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              )
            ),
          ),
          GestureDetector(
            onTap: (){
              launch("https://covid19responsefund.org/");
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              color: primaryBlack,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Donate",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white
                    )
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              )
            ),
          ),
          GestureDetector(
            onTap: (){
              launch("https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters");
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              color: primaryBlack,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Myth-Busters",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white
                    )
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}

