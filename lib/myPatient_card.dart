import 'package:flutter/material.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({Key key}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildPatient(' Blood \n Pressure', ' 120/90\n mm/Hg',const Color(0xffff2e6a)),
        _buildPatient(' Heart \n Beat', ' 50 npm\n per min',const Color(0xff1250f3)),
        _buildPatient(' Blood \n Glucose', ' 85-100\n mg/dl',const Color(0xff14d083)),
      ],
    );
  }
  Widget _buildPatient(String title,String subtitle,var color){
    return Flexible(
      flex: 5,
      child: Card(
        child: Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
        color:color,
        ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 150,
                  height: 0,
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
                            color: Colors.white,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                         subtitle,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
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
      ),
    );
  }
}
