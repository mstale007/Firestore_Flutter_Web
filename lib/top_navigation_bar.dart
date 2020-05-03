import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      elevation: 20,
      shadowColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
            image: DecorationImage(
                image: AssetImage("title_bar_back.png"), 
                fit: BoxFit.cover)
              ),
        height: 100,
        child: Row(
          children: [
            SizedBox(
              height: 80,
              child: Image.asset("logo.png"),
            )
          ],
        ),
      ),
    );
  }
}
