import 'package:flutter/material.dart';
import 'package:myproject/constants/constatsvalue.dart';
import 'package:myproject/viewmodel/doctor_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
class DoctorProfileScreen extends StatefulWidget {
  String profileName;

  DoctorProfileScreen({super.key, required this.profileName});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final doctorProfileViewModel = DoctorProfileViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DoctorProfileViewModel>(context, listen: false)
          .loadProfileData(widget.profileName);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("----------${doctorProfileViewModel.profileImageUrl}");

    return Consumer<DoctorProfileViewModel>(builder: (builder, viewModel, _) {
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white70,
          body: Container(
            margin: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.blue,
            ),
            height: DynamicSize.height(0.9, context),
            width: DynamicSize.width(0.97, context),
            child: SingleChildScrollView(
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
                            : (viewModel.profileImageUrl != null
                                ? NetworkImage(viewModel.profileImageUrl!)
                                : const AssetImage("assets/images/avatar1.jpeg")
                                    as ImageProvider),
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
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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
                          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          child: TextFormField(
                            controller: viewModel.dob,
                            readOnly: true, // Make the TextFormField read-only
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );

                              if (pickedDate != null) {
                                // Format the date as per your requirements
                                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                viewModel.dob.text = formattedDate;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Date of Birth',
                              suffixIcon: Icon(Icons.calendar_today_sharp),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: SingleChildScrollView(
                              child: DropdownButtonFormField<List<String>>(
                                value: viewModel.selectedDiseases.isNotEmpty
                                    ? viewModel.selectedDiseases
                                    : null,
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    viewModel.selectedDiseases = newValue;
                                    viewModel.updateState();
                                  }
                                },
                                items: [
                                  DropdownMenuItem<List<String>>(
                                    value: viewModel.selectedDiseases,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                          viewModel.doctorSpecialist.length,
                                          (index) {
                                            final disease = viewModel
                                                .doctorSpecialist[index];
                                            final isSelected = viewModel
                                                .selectedDiseases
                                                .contains(disease);

                                            return CheckboxListTile(
                                              title: Text(disease),
                                              value: isSelected,
                                              onChanged: (checked) {
                                                if (checked!) {
                                                  viewModel.selectedDiseases
                                                      .add(disease);
                                                } else {
                                                  viewModel.selectedDiseases
                                                      .remove(disease);
                                                }
                                                viewModel.updateState();
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'Select Specialist',
                                  contentPadding:
                                      EdgeInsets.only(top: 10, bottom: 20),
                                  border: InputBorder.none,
                                ),
                                isExpanded: true,
                                selectedItemBuilder: (BuildContext context) {
                                  return viewModel.selectedDiseases
                                      .map<Widget>((String disease) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      child: Text(disease),
                                    );
                                  }).toList();
                                },
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
                                if (viewModel.selectedImage != null) {
                                  viewModel.saveDoctorProfile(
                                      widget.profileName.toString(),
                                      viewModel.selectedImage);
                                } else {
                                  viewModel.saveDoctorProfile(
                                      widget.profileName.toString(), null);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Create Profile",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
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
