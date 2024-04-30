import 'package:flutter/material.dart';
import 'package:myproject/viewmodel/calories_viewmodel.dart';
import 'package:provider/provider.dart';

class CaloriesCalculator extends StatelessWidget {
  CaloriesCalculator({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<CaloriesViewModel>(builder: (context, viewmodel, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Calories Calculator'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: viewmodel.ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Age'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: viewmodel.weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Weight (kg)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your weight';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: viewmodel.heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Height (cm)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your height';
                    }
                    return null;
                  },
                ),
                ListTile(
                  title: const Text('Male'),
                  leading: Radio(
                    value: true,
                    groupValue: viewmodel.isMale,
                    onChanged: (value) {
                      viewmodel.isMale = value as bool;
                      viewmodel.updateStates();
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Female'),
                  leading: Radio(
                    value: false,
                    groupValue: viewmodel.isMale,
                    onChanged: (value) {
                      viewmodel.isMale = value as bool;
                      viewmodel.updateStates();
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      viewmodel.calculateCalories();
                    }
                  },
                  child: const Text('Calculate'),
                ),
                if (viewmodel.result > 0)
                  Text(
                    'Your daily calorie intake is ${viewmodel.result} ',
                    style: TextStyle(fontSize: 18),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
