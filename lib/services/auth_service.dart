import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/core/error_handling/failures/auth_failures.dart';

enum AccountProviders { email, facebook, google, apple }

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _log = getLogger('AuthService');

  AuthService() {
    if (kDebugMode) {
      _auth.useAuthEmulator('127.0.0.1', 9099);
    }
  }

  String? get uid => _auth.currentUser?.uid;

  String? get email => _auth.currentUser?.email;

  String? get displayName => _auth.currentUser?.displayName;

  Future<User?> get currentUser => _auth.userChanges.call().first;

  Future<bool> isUserSignedIn() async {
    final user = await _auth.authStateChanges().first;
    return user != null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Signs in the user with email and password
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user.user;
    } on FirebaseAuthException catch (exception) {
      throw FirebaseAuthFailure.mapFirebaseAuthExceptionToFailure(
        exception,
      );
    }
  }

  // Creates a new account with email and password
  Future<User?> createAccountWithEmail(
    String email,
    String password,
    String? displayName,
  ) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await result.user?.updateDisplayName(displayName);

      return result.user;
    } on FirebaseAuthException catch (exception) {
      throw FirebaseAuthFailure.mapFirebaseAuthExceptionToFailure(
        exception,
      );
    }
  }

  // Updates the user's password
  Future<void> updatePassword(String newPassword) async {
    _log.i('newPassword: $newPassword');
    try {
      final user = await _auth.authStateChanges().first;
      return user?.updatePassword(newPassword);
    } on FirebaseAuthException catch (exception) {
      throw FirebaseAuthFailure.mapFirebaseAuthExceptionToFailure(
        exception,
      );
    }
  }

  // Updates the user's display name (username)
  Future<void> updateUsername(String username) async {
    try {
      final user = await _auth.authStateChanges().first;
      return user?.updateDisplayName(username);
    } on FirebaseAuthException catch (exception) {
      throw FirebaseAuthFailure.mapFirebaseAuthExceptionToFailure(
        exception,
      );
    }
  }

// Future<List<AccountProviders>> signInAndLinkAccount(String email,
//     AccountProviders signInProvider, AccountProviders providerToLink) async {
//   var output = List<AccountProviders>.empty(growable: true);
//   try {
//     var userEmail = await signInWithProviderAndGetEmail(signInProvider);
//     if (userEmail != email) {
//       throw FirebaseAuthException(
//           message:
//               "You are trying to link an account with a different email.",
//           code: "invalid-email");
//     }
//     var existingProviders = await getProviders(userEmail!);
//     if (existingProviders.contains(signInProvider)) {
//       var user = await _signInWithProvider(signInProvider);
//       var credentials =
//           await _signInWithProviderAndGetCredentials(providerToLink);
//       var linkedUser = await user!.linkWithCredential(credentials!);
//       output.addAll(Utils.firebaseUserToAccountProviders(linkedUser.user!));
//     }
//     return output;
//   } on FirebaseAuthException catch (exception) {
//     throw FirebaseAuthFailure.mapFirebaseAuthExceptionToFailure(exception);
//   }
// }

// Future<void> linkAccount(AccountProviders provider) async {
//   // get the current user
//   User existingUser = FirebaseAuth.instance.currentUser!;

//   UserCredential? linkauthresult;

//   switch (provider) {
//     case AccountProviders.email:
//       //Out of scope (we can't create an account with email and password and there is at least one sign in method already registred)
//       break;
//     case AccountProviders.facebook:
//       var token = await locator<FacebookAuthenticationService>()
//           .getFacebookAccessToken();
//       AuthCredential facebookCredential =
//           FacebookAuthProvider.credential(token!.token);
//       linkauthresult =
//           await existingUser.linkWithCredential(facebookCredential);
//       break;
//     case AccountProviders.google:
//       final GoogleSignIn _googleSignIn = GoogleSignIn();
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;

//       final AuthCredential googleCredential = GoogleAuthProvider.credential(
//         idToken: googleAuth?.idToken,
//         accessToken: googleAuth?.accessToken,
//       );
//       linkauthresult =
//           await existingUser.linkWithCredential(googleCredential);
//       break;
//     case AccountProviders.Apple:
//       var result =
//           await locator<AppleAuthenticationService>().signInWithApple();

//       AuthCredential appleCredential = OAuthProvider('apple.com').credential(
//         idToken: result.identityToken,
//         rawNonce: locator<AppleAuthenticationService>().rawNonce,
//       );
//       linkauthresult = await existingUser.linkWithCredential(appleCredential);
//       break;
//   }
// }

// Future<List<AccountProviders>> getProviders(String email) async {
//   // Fetch a list of what sign-in methods exist for the conflicting user
//   List<String> userSignInMethods =
//       await _auth.fetchSignInMethodsForEmail(email);
//   List<AccountProviders> providersList =
//       List<AccountProviders>.empty(growable: true);
//   if (userSignInMethods.contains('facebook.com')) {
//     providersList.add(AccountProviders.facebook);
//   }
//   if (userSignInMethods.contains('google.com')) {
//     providersList.add(AccountProviders.google);
//   }
//   if (userSignInMethods.contains('password')) {
//     providersList.add(AccountProviders.email);
//   }
//   if (userSignInMethods.contains('apple.com')) {
//     providersList.add(AccountProviders.apple);
//   }
//   return providersList;
// }

// Future<AuthCredential?> _signInWithProviderAndGetCredentials(
//     AccountProviders provider) async {
//   try {
//     AuthCredential? credential;
//     switch (provider) {
//       case AccountProviders.email:
//         //Not Needed
//         break;
//       case AccountProviders.facebook:
//         var loginResult = await locator<FacebookAuthenticationService>()
//             .signInWithFacebook();
//         credential = FacebookAuthProvider.credential(loginResult.token);
//         break;
//       case AccountProviders.google:
//         GoogleSignInAuthentication googleAuth =
//             await locator<GoogleAuthenticationService>().signInWithGoogle();
//         credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );
//         break;
//       case AccountProviders.apple:
//         var result =
//             await locator<AppleAuthenticationService>().signInWithApple();
//         credential = OAuthProvider("apple.com").credential(
//           idToken: result.identityToken,
//           rawNonce: locator<AppleAuthenticationService>().rawNonce,
//         );
//         break;
//     }

//     return credential;
//   } on FirebaseAuthException catch (exception) {
//     throw FirebaseAuthFailure.mapFirebaseAuthExceptionToFailure(exception);
//   }
// }

// Future<bool> signIn(AccountProviders provider) async {
//   try {
//     //Sign in in order to get the email from the provider
//     var userEmail = await signInWithProviderAndGetEmail(provider);
//     //Get the list of linked account for that email
//     var existingProviders = await getProviders(userEmail!);
//     //First time doing sign in
//     if (existingProviders.isEmpty) {
//       await _signInWithProvider(provider);
//       return false;
//     }
//     //Normal sign in: this sign in method is the only way to sign in
//     if (existingProviders.contains(provider)) {
//       User? user = await _signInWithProvider(provider);
//       if (user != null) {
//         return _firestoreService.userExists(user.uid);
//       }
//       //First time sign in with this provider, but having other sign in methods
//     } else if (existingProviders.isNotEmpty) {
//       if (existingProviders.contains(AccountProviders.Google)) {
//         throw FirebaseAuthFailure(
//             FirebaseAuthFailures.AccountExistsWithDifferentCredential,
//             "Already have an account with Google",
//             StackTrace.current,
//             args: {"provider": AccountProviders.Google, "email": userEmail});
//       } else if (existingProviders.contains(AccountProviders.Facebook)) {
//         throw FirebaseAuthFailure(
//             FirebaseAuthFailures.AccountExistsWithDifferentCredential,
//             "Already have an account with Facebook",
//             StackTrace.current,
//             args: {
//               "provider": AccountProviders.Facebook,
//               "email": userEmail
//             });
//       } else if (existingProviders.contains(AccountProviders.Apple)) {
//         throw FirebaseAuthFailure(
//             FirebaseAuthFailures.AccountExistsWithDifferentCredential,
//             "Already have an account with Apple",
//             StackTrace.current,
//             args: {"provider": AccountProviders.Apple, "email": userEmail});
//       } else if (existingProviders.contains(AccountProviders.Email)) {
//         throw FirebaseAuthFailure(
//             FirebaseAuthFailures.AccountExistsWithDifferentCredential,
//             "Already have an account with Email and Password",
//             StackTrace.current,
//             args: {"provider": AccountProviders.Email, "email": userEmail});
//       }
//     }
//     return false;
//   } on FirebaseAuthException catch (exception) {
//     throw FirebaseAuthFailure.mapFirebaseAuthExceptionToFailure(exception);
//   }
// }

  ///Returns Firebase User after sign in using the given provider and sign in with Firebase.
  ///
  ///Takes [AccountProviders] as a parameter
// Future<User?> _signInWithProvider(AccountProviders provider) async {
//   User? user;
//   switch (provider) {
//     case AccountProviders.email:
//       //Doesnt Exist in this scope
//       break;
//     case AccountProviders.facebook:
//       await locator<FacebookAuthenticationService>().signOut();
//       user = await signInFirebaseWithFacebook();
//       break;
//     case AccountProviders.google:
//       await locator<GoogleAuthenticationService>().signOutGoogle();
//       user = await signInFirebaseWithGoogle();
//       break;
//     case AccountProviders.apple:
//       user = await signInFirebaseWithApple();
//       break;
//   }
//   return user;
// }

  ///Returns an `email` as [String] after signing in with Firebase using the given provider.
  ///
  ///Takes [AccountProviders] as a parameter
// Future<String?> signInWithProviderAndGetEmail(
//     AccountProviders provider) async {
//   try {
//     String? userEmail;
//     switch (provider) {
//       case AccountProviders.email:
//         //Not Needed
//         break;
//       case AccountProviders.facebook:
//         // Getting the facebook accessToken
//         var accessToken = await locator<FacebookAuthenticationService>()
//             .signInWithFacebook();
//         // Getting the email from accessToken
//         userEmail = await locator<FacebookAuthenticationService>()
//             .getEmail(accessToken);
//         break;
//       // Case GOOGLE
//       case AccountProviders.google:
//         // Signes out the user
//         await locator<GoogleAuthenticationService>().signOutGoogle();
//         // Signes in the user
//         await locator<GoogleAuthenticationService>().signInWithGoogle();
//         // Getting the email
//         userEmail = await locator<GoogleAuthenticationService>().getEmail();
//         break;
//       case AccountProviders.apple:
//         userEmail = await locator<AppleAuthenticationService>()
//             .signInWithAppleAndGetEmail();
//         // userEmail = appleCred.email;
//         break;
//     }
//     return userEmail;
//   } on FirebaseAuthException catch (exception) {
//     throw FirebaseAuthFailure.mapFirebaseAuthExceptionToFailure(exception);
//   }
// }
}
