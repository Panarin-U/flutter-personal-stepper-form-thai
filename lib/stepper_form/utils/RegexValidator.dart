class RegexValidators {
  static final RegExp _email = RegExp(
    r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );
  static final RegExp _password = RegExp(
    r'^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+){8,16}$',
  );
  static final RegExp _username = RegExp(
    r'^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+){6,15}$',
  );
  static final RegExp _mobile = RegExp(
      r'\d{10,10}$'
  );
  static final RegExp _tel = RegExp(
    r'\d{9}$',
  );

  static final RegExp _fax = RegExp(
    r'\d{9,15}$',
  );

  static final RegExp _number = RegExp(
    r'[\d]+$',
  );
  static final RegExp _thaiWord = RegExp(
    r'^[\u0E00-\u0E7F \.]+$',
  );
  static final RegExp _engWord = RegExp(
    r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$",
  );
  static final RegExp _date = RegExp(
    r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$',
  );

  static final RegExp _thaiLaserId = RegExp(
    r'^([a-zA-Z]{2}\d)\-(\d{7})\-(\d{2})$',
  );

  static final RegExp _passport = RegExp(
    r'^(?!^0+$)[a-zA-Z0-9]{3,20}$',
  );

  static final RegExp _commas = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

  static final RegExp _cardSpace = RegExp(r".{4}");

  static final RegExp _mobileSplit = RegExp(r'(\d{3})(\d{3})(\d+)');

  static String splitMobileWithDash(String mobile) {
    if (mobile.length != 10) {
      return mobile;
    }
    return mobile.replaceAllMapped(_mobileSplit, (Match m) => "${m[1]}-${m[2]}-${m[3]}");
  }

  static String numberWithCommas(String num) {
    return (num == null || num == "") ? "0.00" : num.replaceAllMapped(_commas, (Match m) => '${m[1]},');
  }

  static String cardWithSpace(String card) {
    return card.replaceAllMapped(_cardSpace, (match) => "${match.group(0)} ");
  }

  static bool isValidEngName(String word) {
    return _engWord.hasMatch(word);
  }
  static bool isValidThaiWord(String word) {
    return _thaiWord.hasMatch(word);
  }
  static bool isValidUserName(String username) {
    return _username.hasMatch(username);
  }
  static bool isValidEmail(String email) {
    return _email.hasMatch(email);
  }
  static bool isValidPassword(String password) {
    return _password.hasMatch(password);
  }
  static bool isValidMobile(String mobile) {
    String replace = mobile.replaceAll('-', '');
    return _mobile.hasMatch(replace);
  }
  static bool isValidTel(String mobile) {
    String replace = mobile.replaceAll('-', '');
    return _tel.hasMatch(replace);
  }
  static bool isValidNumber(String code) {
    return _number.hasMatch(code);
  }
  static bool isValidDate(String code) {
    return _date.hasMatch(code);
  }
  static bool isValidPassport(String passport) {
    return _passport.hasMatch(passport);
  }
  static bool isValidNationLaserId(String code) {
    return _thaiLaserId.hasMatch(code);
  }

  static bool isValidNationId(String code) {
    if(!_number.hasMatch(code) || (code.length != 13))
      return false;

    int sum=0;
    for(int i=0; i < 12; i++)
      sum += int.parse(code[i])*(13-i);

    if((11-sum%11)%10!=int.parse(code[12]))
      return false;

    return true;
  }

  static bool isValidFax(String fax) {
    String replace = fax.replaceAll('-', '');
    return _fax.hasMatch(replace);
  }

  static bool isValidPin(String pin) {

    if (pin.length < 6) return false;

    for(int i=0; i <= pin.length - 3; i++) {
      if ((pin[i] == pin[i+1]) && (pin[i+1] == pin[i+2])) {
        return false;
      }

      if (((int.parse(pin[i]) + 1) ==  int.parse(pin[i+1])) &&
          ((int.parse(pin[i+1]) +1)  == int.parse(pin[i+2]))) {
        return false;
      }

      if ((int.parse(pin[i]) ==  (int.parse(pin[i+1])+1)) &&
          (int.parse(pin[i+1])  == (int.parse(pin[i+2])+1))) {
        return false;
      }
    }

    return true;
  }
}
