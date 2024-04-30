import 'package:flutter/material.dart';
import 'package:myproject/constants/constatsvalue.dart';
import 'package:myproject/viewmodel/doctor_viewmodel.dart';
import 'package:provider/provider.dart';

class DoctorProfileScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<DoctorProfileViewModel>(builder: (builder, viewModel, _) {
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
            height: DynamicSize.height(0.9, context),
            width: DynamicSize.width(0.97, context),
            child: SingleChildScrollView(
              child:  Column(
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
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500),
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
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: viewModel.selectedImage != null
                            ? FileImage(viewModel.selectedImage!)
                            : const AssetImage("assets/images/profileimage.jpg")
                                as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            viewModel.pickImageFromGallery();
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                return null;
                              }
                              return "Enter Full Name";
                            },
                            controller: viewModel.fullName,
                            decoration: InputDecoration(
                              hintText: 'Enter full name',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.account_circle_outlined),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          child: TextFormField(
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                return null;
                              }
                              return "Enter date of Birth";
                            },
                            controller: viewModel.dob,
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
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: DropdownButtonFormField<String>(
                              value: viewModel.selectedDisease,
                              validator: (value) {
                                if (value != null && value.isNotEmpty) {
                                  return null;
                                }
                                return "Select Specilist";
                              },
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  viewModel.selectedDisease = newValue;
                                  viewModel.updateState();
                                }
                              },
                              items: viewModel.doctorSpecialist.map((disease) {
                                return DropdownMenuItem<String>(
                                  value: disease,
                                  child: Text(disease),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                labelText: 'Select Specilist',
                                contentPadding:
                                    EdgeInsets.only(top: 10, bottom: 20),
                                // Added to remove extra padding
                                border: InputBorder.none,
                              ),
                              isExpanded:
                                  true, // Added to allow the dropdown to expand horizontally
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          child: TextFormField(
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                return null;
                              }
                              return "Enter address";
                            },
                            controller: viewModel.address,
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
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 50),
                          child: TextFormField(
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                return null;
                              }
                              return "Enter Qualification";
                            },
                            controller: viewModel.qualification,
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
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate()) {
                                viewModel.saveDoctorProfile();
                              }
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
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
