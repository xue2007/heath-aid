import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class NotificationCard extends StatelessWidget {

  final String name;
  final String illness;
  final String time;
  const NotificationCard({
    Key key, this.name,this.illness,this.time
  }) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(left:2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
      ),
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/cool1.jpg'),
                )
              ),
            ),
            Container(
              width: 100,
              child: ListTile(
                title: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(illness),
              ),
            ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.check_circle,
              size: 30,
              color: Colors.green,
            ),
            Icon(
              Icons.cancel,
              size: 30,
              color: Colors.red,
            ),
          ],
        ),
      ],
    )
      )
    );
  }
}
