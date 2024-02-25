import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/core/error_handling/failures/general_failure.dart';
import 'package:task_flow/core/models/environment/environment.dart';
import 'package:task_flow/core/models/project/project.dart';
import 'package:task_flow/core/models/task/task.dart';
import 'package:task_flow/services/auth_service.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = locator<AuthService>();

  FirestoreService() {
    if (kDebugMode) {
      _firestore.useFirestoreEmulator('127.0.0.1', 8080);
    }
  }
  final _log = getLogger('FirestoreService');

  Future<List<EnvironmentModel>> fetchEnvironments() async {
    try {
      final snapshot = await _firestore
          .collection('Environments')
          .where(
            'admins',
            arrayContains: _auth.uid!,
          )
          .get();
      _log.i('fetchEnvironments - ${snapshot.docs.length}');
      final envs = snapshot.docs
          .map((e) => EnvironmentModel.fromJson(e.data()))
          .toList();

      return envs;
    } catch (e) {
      throw GeneralFailure();
    }
  }

  Future<List<ProjectModel>> fetchProjects() async {
    try {
      final snapshot = await _firestore
          .collection('Projects')
          .where(
            'members',
            arrayContains: _auth.uid!,
          )
          .get();

      final projects =
          snapshot.docs.map((e) => ProjectModel.fromJson(e.data())).toList();
      return projects;
    } catch (e) {
      throw GeneralFailure();
    }
  }

  Future<List<TaskModel>> fetchTasksForProject(String projectId,
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
          snapshot.docs.map((e) => TaskModel.fromJson(e.data())).toList();
      return tasks;
    } catch (e) {
      throw GeneralFailure(description: e.toString());
    }
  }

  Future<List<EnvironmentModel>> fetchEnvironmentsByIds(
      List<String> ids) async {
    try {
      final snapshot = await _firestore
          .collection('Environments')
          .where(
            'id',
            whereIn: ids,
          )
          .get();

      final envs = snapshot.docs
          .map((e) => EnvironmentModel.fromJson(e.data()))
          .toList();

      return envs;
    } catch (e) {
      throw GeneralFailure();
    }
  }

  Future<List<ProjectModel>> fetchProjectsByIds(List<String> ids) async {
    try {
      final snapshot = await _firestore
          .collection('Projects')
          .where(
            'id',
            whereIn: ids,
          )
          .get();

      final projects =
          snapshot.docs.map((e) => ProjectModel.fromJson(e.data())).toList();
      return projects;
    } catch (e) {
      throw GeneralFailure();
    }
  }
}
