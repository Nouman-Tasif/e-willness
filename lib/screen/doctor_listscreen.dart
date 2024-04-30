import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myproject/screen/doctor_profilescreen.dart';

import '../model/doctor_model.dart';

class DoctorListScreen extends StatelessWidget {
  final String selectedDisease;

  DoctorListScreen({required this.selectedDisease});

  List<Doctor> doctors = [
    Doctor(name: 'Dr. John Doe', specialty: 'Cardiology'),
    Doctor(name: 'Dr. Jane Smith', specialty: 'Neurology'),
    Doctor(name: 'Dr. Michael Johnson', specialty: 'Oncology'),
    // Add more doctors with their specialties
  ];
  List<String> patientDisease = [
    'flu',
    'bronchitis',
    'pneumonia',
    'heart attack',
    'stroke',
    'cancer',
    'diabetes',
    'alzheimer',
    'arthritis',
    'adenovirus',
    'aflatoxicosis',
    'alcoholism',
    'allergic rhinitis',
    'alzheimers disease',
    'anemia',
    'anxiety disorder',
    'appendicitis',
    'asperger syndrome',
    'asthma',
    'bacterial meningitis',
    'bipolar disorder',
    'bladder cancer',
    'blood clot',
    'bursitis',
    'cervical cancer',
    'chickenpox',
    'chronic obstructive pulmonary disease (copd)',
    'cholesterol',
    'common cold',
    'conjunctivitis',
    'depression',
    'diarrhea',
    'eating disorder',
    'epilepsy',
    'fever',
    'food poisoning',
    'gallstones',
    'gonorrhea',
    'heart disease',
    'hepatitis',
    'herpes',
    'influenza',
    'irritable bowel syndrome (ibs)',
    'kidney stones',
    'lung cancer',
    'malaria',
    'measles',
    'meningitis',
    'mononucleosis',
    'rabies',
    'salmonella',
    'shingles',
    'tuberculosis (tb)',
    'urinary tract infection (uti)',
    'varicose veins',
    'warts',
    'yeast infection',
    'acanthamoebkeratitis',
    'acute appendicitis',
    'acute kidney injury (aki)',
    "alzheimer's disease",
    'aortic aneurysm',
    'colorectal cancer',
    'dementia',
    'erectile dysfunction',
    'fibromyalgia',
    'glaucoma',
    'heart failure',
    'kidney disease',
    'lung disease',
    "parkinson's disease",
    'peptic ulcer disease',
    'peripheral artery disease',
    'prostate cancer',
    'rheumatoid arthritis',
    'stomach cancer',
    'thyroid cancer',
    'ulcerative colitis',
    'atopic dermatitis',
    'celiac disease',
    'chronic kidney disease',
    "crohn's disease",
    "graves' disease",
    "hashimoto's thyroiditis",
    'lupus'
  ];

  String getRandomName() {
    var names = [
      'John',
      'Jane',
      'Michael',
      'David',
      'Sarah',
      'Emily',
      'Daniel',
      'Jessica',
      'Christopher',
      'Nicole'
    ];
    var random = Random();
    return names[random.nextInt(names.length)];
  }

  @override
  Widget build(BuildContext context) {
    var random = Random();

    for (var i = 0; i < 100; i++) {
      var name = 'Dr. ' + getRandomName();
      var specialty = patientDisease[random.nextInt(patientDisease.length)];
      doctors.add(Doctor(name: name, specialty: specialty));
    }
    List<Doctor> filteredDoctors = doctors
        .where((doctor) =>
            doctor.specialty.toLowerCase() == selectedDisease.toLowerCase())
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors for $selectedDisease'),
      ),
      body: ListView.builder(
        itemCount: filteredDoctors.length,
        itemBuilder: (context, index) {
          final doctor = filteredDoctors[index];
          return ListTile(
            title: Text(doctor.name),
            subtitle: Text(doctor.specialty),
            onTap: () {
              // Navigate to the doctor's profile screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SingleDoctorProfileScreen(doctor: doctor),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
