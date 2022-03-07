




import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:stepper_form/stepper_form/utils/RegexValidator.dart';

class FormBlocStep1 extends FormBloc<String, String> {

  final nameEn = TextFieldBloc(
      validators: [
        FieldBlocValidators.required,
        englishOnly
      ]
  );

  final nameTh = TextFieldBloc(
      validators: [
        FieldBlocValidators.required,
        thaiOnly
      ]
  );

  final email = TextFieldBloc(
      validators: [
        FieldBlocValidators.required,
        isEmail
      ]
  );

  final age = TextFieldBloc(
      validators: [
        FieldBlocValidators.required,
        isNumberOnly
      ]
  );

  final phone = TextFieldBloc(
      validators: [
        FieldBlocValidators.required,
        isPhone
      ]
  );


  static String? englishOnly(String? s) {
    return RegexValidators.isValidEngName(s!) ? null : 'Name Must be English';
  }

  static String? thaiOnly(String? s) {
    return RegexValidators.isValidThaiWord(s!) ? null : 'Name Must be Thai';
  }

  static String? isEmail(String? s) {
    return RegexValidators.isValidEmail(s!) ? null : 'Invalid Email';
  }

  static String? isNumberOnly(String? s) {
    return RegexValidators.isValidNumber(s!) ? null : 'Number Only';
  }

  static String? isPhone(String? s) {
    return RegexValidators.isValidMobile(s!) ? null : 'Mobile Not Valid';
  }

  FormBlocStep1() {
    addFieldBlocs(fieldBlocs: [
      nameEn,
      nameTh,
      email,
      age,
      phone,
    ]);
  }

  void addErrors() {

  }


  @override
  void onSubmitting() async {
    // TODO: implement onSubmitting
    // emitFailure(failureResponse: 'xxx');
    emitSuccess(successResponse: 'success', canSubmitAgain: true);
  }

}