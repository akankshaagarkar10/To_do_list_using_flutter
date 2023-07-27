import 'package:flutter/material.dart'; 

class Description extends StatelessWidget {
  final String? title, description;

  const Description({Key? key, this.title, this.description}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Description')),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                title.toString(),
                style:TextStyle(fontFamily: 'RobotoMono', fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                description.toString(),
                style: TextStyle(fontFamily: 'RobotoMono', fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}