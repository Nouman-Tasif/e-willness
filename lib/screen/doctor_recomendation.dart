import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject/screen/doctor_profile.dart';

class DoctorRecommendation extends StatelessWidget {
  const DoctorRecommendation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Center(child: Text('Doctors', textAlign: TextAlign.center)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Doctor').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final doctors = snapshot.data!.docs;
            debugPrint("-------${doctors.length}");
            return ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index].data() as Map<String, dynamic>;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>DoctorProfile(doctorId: doctors[index].id)));
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  NetworkImage(doctor['profileImage']),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doctor['fullName'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    doctor['disease'].join(', '),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
