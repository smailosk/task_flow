import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:task_flow/core/error_handling/failures/general_failure.dart';
import 'package:task_flow/core/error_handling/failures/google_auth_failures.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    signInOption: SignInOption.standard,
    scopes: [
      'email',
      //'https://www.googleapis.com/auth/contacts.readonly',
      // 'https://www.googleapis.com/auth/user.birthday.read',
      // 'https://www.googleapis.com/auth/user.gender.read',
      //'https://www.googleapis.com/auth/profile.language.read'
    ],
  );
  String? _idToken;

  String? _accessToken;

  get accessToken => _accessToken;

  ///Sign out
  Future<GoogleSignInAccount?> signOutGoogle() => _googleSignIn.signOut();

  ///Disconnects the current user from the app and revokes previous authentication.
  Future<GoogleSignInAccount?> disconnect() => _googleSignIn.disconnect();

  ///Returns a future that resolves to whether a user is currently signed in
  Future<bool> userIsSignedIn() => _googleSignIn.isSignedIn();

  ///Returns `email` after signing in with Google
  Future<String?> getEmail() async {
    try {
      String link =
          'https://www.googleapis.com/oauth2/v1/userinfo?access_token=$_accessToken';
      var graphResponse = await http.get(Uri.parse(link));
      Map<String, dynamic> result = json.decode(graphResponse.body);
      return result['email'];
    } on IOException catch (e, stackTrace) {
      throw GeneralFailure(
          type: GeneralFailureType.internetConnectionError,
          description: "getEmailFromAccessToken Failed on IOException",
          stackTrace: stackTrace);
    } on Exception catch (e, stackTrace) {
      throw GeneralFailure(
          type: GeneralFailureType.unexpectedError,
          description: "getEmailFromAccessToken Failed on $e",
          stackTrace: stackTrace);
    }
  }

  ///Signs the user in with Google
  ///
  ///Returns [GoogleSignInAuthentication]
  ///
  ///It signes the user silently if he's already signed in, interactive sign-in process otherwise.
  Future<GoogleSignInAuthentication> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount;
    GoogleSignInAuthentication googleAuth;
    try {
      final isSignedIn = await userIsSignedIn();
      if (isSignedIn) {
        googleSignInAccount = await _googleSignIn.signInSilently();
        googleAuth = await _googleSignIn.currentUser!.authentication;
      } else {
        // Trigger the authentication flow
        googleSignInAccount = await _googleSignIn.signIn();
        if (googleSignInAccount != null) {
          // Obtain the auth details from the request
          googleAuth = await googleSignInAccount.authentication;
        } else {
          throw GoogleAuthFailure(GoogleAuthFailureType.canceled,
              description: '', stackTrace: StackTrace.current);
        }
      }
      _idToken = googleAuth.idToken;
      _accessToken = googleAuth.accessToken;
    } on PlatformException catch (exception) {
      throw GoogleAuthFailure.mapFirebaseAuthExceptionToFailure(exception);
    } catch (e) {
      throw GeneralFailure();
    }
    return googleAuth;
  }

  /// Returns Google data from Google APIs
  Future<Map<String, dynamic>> fetchGoogleData() async {
    final apiKey = '';
    if (_idToken != null && _accessToken != null) {
      try {
        String link =
            'https://people.googleapis.com/v1/people/me?personFields=birthdays,genders&key=$apiKey';
        var graphResponse = await http.get(Uri.parse(link),
            headers: {'Authorization': 'Bearer $_accessToken'});
        var result = json.decode(graphResponse.body);
        return result;
      } on IOException catch (e, stackTrace) {
        throw GeneralFailure(
            type: GeneralFailureType.internetConnectionError,
            description: "fetchGoogleData Failed on IOException",
            stackTrace: stackTrace);
      } on Exception catch (e, stackTrace) {
        throw GeneralFailure(
            type: GeneralFailureType.unexpectedError,
            description: "fetchGoogleData Failed on $e",
            stackTrace: stackTrace);
      }
    } else {
      throw GeneralFailure(stackTrace: StackTrace.current);
    }
  }
}
