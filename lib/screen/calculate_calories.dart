import 'package:flutter/material.dart';
import 'package:myproject/viewmodel/calories_viewmodel.dart';
import 'package:provider/provider.dart';

class CaloriesCalculator extends StatelessWidget {
  CaloriesCalculator({super.key});

  final _caloriesFormKey = GlobalKey<FormState>();
  final _bmiFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<CaloriesViewModel>(builder: (context, viewmodel, _) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Calories and BMI Calculator'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _caloriesFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: viewmodel.ageController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Age'),
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
                        decoration:
                            const InputDecoration(labelText: 'Weight (kg)'),
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
                        decoration:
                            const InputDecoration(labelText: 'Height (cm)'),
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
                          if (_caloriesFormKey.currentState!.validate()) {
                            viewmodel.calculateCalories();
                          }
                        },
                        child: const Text('Calculate Calories'),
                      ),
                      if (viewmodel.result > 0)
                        Text(
                          'Your daily calorie intake is ${viewmodel.result} ',
                          style: const TextStyle(fontSize: 18),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _bmiFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: viewmodel.weight,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: 'Weight (kg)'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your weight';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: viewmodel.height,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: 'Height (cm)'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your height';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_bmiFormKey.currentState!.validate()) {
                            double weight = double.parse(viewmodel.weight.text);
                            double height =
                                double.parse(viewmodel.height.text) /
                                    100; // convert cm to m
                            double bmi = weight / (height * height);

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Your BMI'),
                                content: Text('Your BMI is: $bmi'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: const Text('Calculate BMI'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
