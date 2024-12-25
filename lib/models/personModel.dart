class Person {
  String? _fullName;
  String? _email;
  String? _phoneNumber;
  String? _password;
  //String _confirmPassword;

  Person(
    this._fullName,
    this._email,
    this._phoneNumber,
    this._password,
    //this._confirmPassword,
  );

// Getter
  String get fullName => _fullName!;
  String get email => _email!;
  String get phoneNumber => _phoneNumber!;
  String get password => _password!;

//Setter
  set fullName(String? newName) {
    if (newName != null) {
      this._fullName = newName;
    }
  }

  set email(String? newEmail) {
    if (newEmail != null) {
      this._email = newEmail;
    }
  }

  set phoneNumber(String newPhoneNumber) {
    this._phoneNumber = newPhoneNumber;
  }

  set password(String? newPassword) {
    if (newPassword != null) {
      this._password = newPassword;
    }
  }

// Convering person schema into Map.
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['fullName'] = _fullName;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['password'] = _password;

    return map;
  }

  // Function which will help us extract a person object from a Map object.
  Person.fromMapObject(Map<String, dynamic> map) {
    this._fullName = map['fullName'];
    this._email = map['email'];
    this._phoneNumber = map['phoneNumber'];
    this._password = map['password'];
  }
}
