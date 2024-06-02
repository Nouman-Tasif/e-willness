import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myproject/constants/constatsvalue.dart';
import 'package:myproject/screen/login_screen.dart';
import 'package:myproject/screen/profile_screen.dart';
import 'package:myproject/viewmodel/homescreen_viewmodel.dart';
import 'package:provider/provider.dart';

import '../authservices/authservices.dart';
import '../widgets/disease_customwidgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenViewModel>(builder: (context, viewmodel, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("E willness"),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Perform notification action
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("Doctor")
                      .doc(DynamicSize().user!.uid)

                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var userData =
                          snapshot.data!.data() as Map<String, dynamic>?;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/images/profileimage.jpg'),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${userData?['fullName']}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('My Profile'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.feedback),
                title: const Text('Give Feedback'),
                onTap: () {
                  // Perform give feedback action
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    try {
                      await AuthService().logout();
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                      // Navigate to the login screen or any other desired screen
                    } catch (e) {
                      Fluttertoast.showToast(msg: "$e");
                    }
                  }
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextField(
                    controller: viewmodel.searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search a specialist',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        viewmodel.searchText = value;
                      });
                    },
                  ),
                  if (viewmodel.searchText.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: viewmodel.clearSearch,
                    ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: viewmodel.patientDisease.length,
                itemBuilder: (context, index) {
                  final disease = viewmodel.patientDisease[index];
                  if (viewmodel.searchText.isEmpty ||
                      disease
                          .toLowerCase()
                          .contains(viewmodel.searchText.toLowerCase())) {
                    return DiseaseListItem(disease: disease);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
