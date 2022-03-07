



import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:stepper_form/stepper_form/bloc/form_bloc_step1.dart';
import 'package:stepper_form/stepper_form/bloc/form_bloc_step2.dart';

class StepperFormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StepperFormScreenState();
  }

}

class _StepperFormScreenState extends State<StepperFormScreen> {

  int _activeCurrentStep = 0;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

// Here we have created list of steps
// that are required to complete the form
  List<Step> stepList(BuildContext ct) {
    final formBlocStep1 = ct.read<FormBlocStep1>();
    final formBlocStep2 = ct.read<FormBlocStep2>();
    return [
      // This is step1 which is called Account.
      // Here we will fill our personal details
      Step(state: _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeCurrentStep >= 0,
          title: const Text('Information'),
          content: FormBlocListener<FormBlocStep1, String, String>(
            onSuccess: (_, __) {
              setState(() {
                _activeCurrentStep++;
              });
            },
            child: Container(
              child: Column(
                children: [
                  TextFieldBlocBuilder(
                    textFieldBloc: formBlocStep1.nameEn,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name (Eng)',
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFieldBlocBuilder(
                    textFieldBloc: formBlocStep1.nameTh,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name (Thai)',
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFieldBlocBuilder(
                    textFieldBloc: formBlocStep1.email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFieldBlocBuilder(
                    textFieldBloc: formBlocStep1.age,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Age',
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFieldBlocBuilder(
                    textFieldBloc: formBlocStep1.phone,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                  ),
                ],
              ),
            ),

          )
      ),
      // This is Step2 here we will enter our address
      Step(
          state: _activeCurrentStep <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeCurrentStep >= 1,
          title: const Text('ID Card Info'),
          content: FormBlocListener<FormBlocStep2, String, String>(
            onSuccess: (_, __) {
              setState(() {
                _activeCurrentStep++;
              });
            },
            child: Container(
              child: Column(
                children: [
                  TextFieldBlocBuilder(
                    textFieldBloc: formBlocStep2.idCard,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ID Card',
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFieldBlocBuilder(
                    textFieldBloc: formBlocStep2.laserId,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Laser ID',
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  DateTimeFieldBlocBuilder(
                    dateTimeFieldBloc: formBlocStep2.birthDate,
                    format: DateFormat('dd-MM-yyyy'),
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1990),
                    lastDate: DateTime(2100),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'BirthDate',
                    ),
                  ),
                  TextFieldBlocBuilder(
                    textFieldBloc: formBlocStep2.address,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFieldBlocBuilder(
                    textFieldBloc: formBlocStep2.religion,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Religion',
                    ),
                  ),
                ],
              ),
            ),
          )
      ),

      // This is Step3 here we will display all the details
      // that are entered by the user
      Step(
          state: StepState.complete,
          isActive: _activeCurrentStep >= 2,
          title: const Text('Confirm'),
          content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('FullName EN: ${formBlocStep1.nameEn.value}'),
                  Text('FullName TH: ${formBlocStep1.nameTh.value}'),
                  Text('Email: ${formBlocStep1.email.value}'),
                  Text('Age : ${formBlocStep1.age.value}'),
                  Text('Phone Number : ${formBlocStep1.phone.value}'),
                  Text('ID Card: ${formBlocStep2.idCard.value}'),
                  Text('LASER ID: ${formBlocStep2.laserId.value}'),
                  Text('BIRTH DATE: ${formBlocStep2.birthDate.value}'),
                  Text('ADDRESS : ${formBlocStep2.address.value}'),
                  Text('RELIGION : ${formBlocStep2.religion.value}'),

                ],
              )))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Stepper'),
      ),
      // Here we have initialized the stepper widget
      body: MultiBlocProvider(
        providers: [
          BlocProvider<FormBlocStep1>(
            create: (BuildContext context) => FormBlocStep1(),
          ),
          BlocProvider(
            create: (BuildContext context) => FormBlocStep2()
          )
        ],
        child: Builder(
          builder: (context) {
            final formBlocStep1 = context.read<FormBlocStep1>();
            final formBlocStep2 = context.read<FormBlocStep2>();
            return Stepper(
              type: StepperType.horizontal,
              currentStep: _activeCurrentStep,
              steps: stepList(context),

              // onStepContinue takes us to the next step
              onStepContinue: () {
                if (_activeCurrentStep == 0) {
                  formBlocStep1.submit();
                } else if (_activeCurrentStep == 1) {
                  formBlocStep2.submit();
                } else {
                  const snackBar = SnackBar(
                    content: Text('Complete !!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  setState(() {
                    formBlocStep1.clear();
                    formBlocStep2.clear();
                    _activeCurrentStep = 0;
                  });
                }
              },

              // onStepCancel takes us to the previous step
              onStepCancel: () {
                if (_activeCurrentStep == 0) {
                  return;
                }

                setState(() {
                  _activeCurrentStep -= 1;
                });
              },


            );
          },
        ),
      )
    );
  }

}