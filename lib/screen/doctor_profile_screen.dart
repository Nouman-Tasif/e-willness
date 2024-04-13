import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorProfileScreen extends StatelessWidget {

final fullName =TextEditingController();
final dob =TextEditingController();
final specialist =TextEditingController();
final address =TextEditingController();
final qualification =TextEditingController();
User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white70,
        body: Container(
          margin: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
          height: height * 0.9,
          width: width * 0.97,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text(
                    'Create Profile',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      // Navigate to settings screen
                    },
                  ),
                ],
              ),
              Stack(
                children: <Widget>[
                  const CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage("assets/images/profileimage.jpg"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Handle edit button pressed
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Select Profile Picture',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: fullName,
                  decoration: InputDecoration(
                    hintText: 'Enter full name',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.account_circle_outlined),
                      onPressed: () {
                        // Handle icon pressed
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: TextField(
                  controller: dob,
                  decoration: InputDecoration(
                    hintText: 'Date of Birth',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today_sharp),
                      onPressed: () {
                        // Handle icon pressed
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: TextField(
                  controller: specialist,
                  decoration: InputDecoration(
                    hintText: 'Enter Specialisation',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.check_circle_outline_outlined),
                      onPressed: () {
                        // Handle icon pressed
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: TextField(
                  controller: address,
                  decoration: InputDecoration(
                    hintText: 'Enter address',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.map),
                      onPressed: () {
                        // Handle icon pressed
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
                child: TextField(
                  controller: qualification,
                  decoration: InputDecoration(
                    hintText: 'Qualification',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add_chart_rounded),
                      onPressed: () {
                        // Handle icon pressed
                      },
                    ),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('doctorProfile')
                        .doc(user!.uid)
                        .set({
                      'fullName': fullName.text,
                      'dob': dob.text,
                      'specialist': specialist.text,
                      'address': address.text,
                      'Qualification': qualification.text,
                    }).then((value) {
                      // Success, do something if needed
                      print('Profile created successfully');
                    }).catchError((error) {
                      // Error handling
                      print('Failed to create profile: $error');
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Create Profile",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
