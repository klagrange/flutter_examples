import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Validators {
//  final _email = StreamController<String>.broadcast();
//  final _password = StreamController<String>.broadcast();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // add data to stream
  Stream<String> get email => this._email.stream.transform(validateEmail);
  Stream<String> get password =>
      this._password.stream.transform(validatePassword);
  Stream<bool> get submitValid =>
      CombineLatestStream.combine2(email, password, (e, p) => true);

  // change data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;

    print('${validEmail} : ${validPassword}');
  }

  dispose() {
    _email.close();
    _password.close();
  }
}
