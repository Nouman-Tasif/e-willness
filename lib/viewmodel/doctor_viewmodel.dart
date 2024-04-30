


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class DoctorProfileViewModel with ChangeNotifier{
  final fullName =TextEditingController();
  final dob =TextEditingController();
  final specialist =TextEditingController();
  final address =TextEditingController();
  final qualification =TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  String? selectedDisease;

  List<String> doctorSpecialist = [
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


  File? selectedImage;

  Future<void> pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      selectedImage = File(pickedImage.path);
      updateState();
    }
  }
  updateState() {
    notifyListeners();
  }
  saveDoctorProfile(){
    FirebaseFirestore.instance
        .collection('doctorProfile')
        .doc(user!.uid)
        .set({
      'fullName': fullName.text,
      'dob': dob.text,
      'specialist': selectedDisease,
      'address': address.text,
      'Qualification': qualification.text,
    }).then((value) {
      // Success, do something if needed
      Fluttertoast.showToast(msg: "profile created Successfully");
    }).catchError((error) {
      // Error handling
      Fluttertoast.showToast(msg: 'Failed to create profile: $error');
    });
  }




}
