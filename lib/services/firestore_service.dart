import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/core/error_handling/failures/general_failure.dart';
import 'package:task_flow/core/models/environment/environment.dart';
import 'package:task_flow/core/models/project/project.dart';
import 'package:task_flow/core/models/task/task.dart';
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

  Future<List<Project>> fetchProjects() async {
    try {
      final snapshot = await _firestore
          .collection('Projects')
          .where(
            'members',
            arrayContains: _auth.uid!,
          )
          .get();

      final projects =
          snapshot.docs.map((e) => Project.fromJson(e.data())).toList();
      return projects;
    } catch (e) {
      throw GeneralFailure();
    }
  }

  Future<List<ToDoTask>> fetchTasksForProject(String projectId,
      {int limit = 100}) async {
    try {
      final snapshot = await _firestore
          .collection('Tasks')
          .where(
            'parentProjectId',
            isEqualTo: projectId,
          )
          .limit(limit)
          .get();

      final tasks =
          snapshot.docs.map((e) => ToDoTask.fromJson(e.data())).toList();
      return tasks;
    } catch (e) {
      throw GeneralFailure(description: e.toString());
    }
    return [];
  }

  Future<List<Environment>> fetchEnvironmentsByIds(List<String> ids) async {
    try {
      final snapshot = await _firestore
          .collection('Environments')
          .where(
            'id',
            whereIn: ids,
          )
          .get();

      final envs =
          snapshot.docs.map((e) => Environment.fromJson(e.data())).toList();

      return envs;
    } catch (e) {
      throw GeneralFailure();
    }
  }

  Future<List<Project>> fetchProjectsByIds(List<String> ids) async {
    try {
      final snapshot = await _firestore
          .collection('Projects')
          .where(
            'id',
            whereIn: ids,
          )
          .get();

      final projects =
          snapshot.docs.map((e) => Project.fromJson(e.data())).toList();
      return projects;
    } catch (e) {
      throw GeneralFailure();
    }
  }
}
