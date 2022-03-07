


import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:stepper_form/stepper_form/utils/RegexValidator.dart';

class FormBlocStep2 extends FormBloc<String, String> {

  final idCard = TextFieldBloc(
      validators: [
        FieldBlocValidators.required,
        validIdCard
      ]
  );

  final laserId = TextFieldBloc(
      validators: [
        FieldBlocValidators.required,
        validLaserId
      ]
  );

  final birthDate = InputFieldBloc<DateTime, Object>(
    name: 'birthDate',
    validators: [
      FieldBlocValidators.required,
    ]
  );

  final religion = TextFieldBloc(
      validators: [
        FieldBlocValidators.required,
      ]
  );

  final address = TextFieldBloc(
      validators: [
        FieldBlocValidators.required,
      ]
  );

  static String? validIdCard(String? s) {
    return RegexValidators.isValidNationId(s!) ? null : 'Invalid ID Card';
  }

  static String? validLaserId(String? s) {
    return RegexValidators.isValidNationLaserId(s!) ? null : 'Invalid Laser Id';
  }

  static String? validDate(String? s) {
    return RegexValidators.isValidDate(s!) ? null : 'Invalid Date';
  }

  FormBlocStep2() {
    addFieldBlocs(fieldBlocs: [
      idCard,
      laserId,
      birthDate,
      religion,
      address
    ]);
  }

  @override
  void onSubmitting() {
    emitSuccess(successResponse: 'success', canSubmitAgain: true);
  }

}