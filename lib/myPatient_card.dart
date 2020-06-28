import 'package:flutter/material.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({Key key}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildPatient('Total', '0 Patients'),
        Flexible(
          flex:2,
          child: Container(),
        ),
        _buildPatient('New', '0 Patients'),
      ],
    );
  }
  Widget _buildPatient(String title,String subtitle){
    return Flexible(
      flex: 5,
      child: Container(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 60,
                height: 80,
                child: CustomPaint(
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                       subtitle,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),

                      ),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
