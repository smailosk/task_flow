import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/core/error_handling/failures/general_failure.dart';
import 'package:task_flow/core/models/environment/environment.dart';
import 'package:task_flow/services/auth_service.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = locator<AuthService>();

  FirestoreService() {
    _firestore.useFirestoreEmulator('127.0.0.1', 8080);
  }

  Future<List<Environment>> fetchEnvironments() async {
    if (_auth.uid == null) throw GeneralFailure();

    try {
      final snapshot = await _firestore
          .collection('Environments')
          .where(
            'admins',
            arrayContains: _auth.uid!,
          )
          .get();

      final envs =
          snapshot.docs.map((e) => Environment.fromJson(e.data())).toList();

      return envs;
    } catch (e) {
      throw GeneralFailure();
    }
  }

  fetchProjects() {}

  fetchTasks() {}
}
