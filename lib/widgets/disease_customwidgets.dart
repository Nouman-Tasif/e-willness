import 'package:flutter/material.dart';
import 'package:myproject/screen/doctor_listscreen.dart';

class DiseaseListItem extends StatelessWidget {
  final String disease;

  const DiseaseListItem({Key? key, required this.disease}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorListScreen(selectedDisease: disease)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.local_hospital, color: Colors.blue),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                disease,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
