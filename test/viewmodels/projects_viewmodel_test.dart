import 'package:flutter_test/flutter_test.dart';
import 'package:task_flow/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ProjectsViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
