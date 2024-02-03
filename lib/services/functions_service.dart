import 'package:cloud_functions/cloud_functions.dart';

class FunctionsService {
  final _functions = FirebaseFunctions.instance;

  FunctionsService() {
    _functions.useFunctionsEmulator('localhost', 5001);
  }
}
