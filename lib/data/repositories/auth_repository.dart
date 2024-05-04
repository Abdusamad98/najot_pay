import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:najot_pay/data/local/storage_repository.dart';
import 'package:najot_pay/data/models/exceptions/firebase_exceptions.dart';
import 'package:najot_pay/data/models/network_response.dart';

class AuthRepository {
  Future<NetworkResponse> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return NetworkResponse(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return NetworkResponse(
        errorText: LogInWithEmailAndPasswordFailure.fromCode(e.code).message,
        errorCode: e.code,
      );
    } catch (error) {
      print("ERRORRR:${error.toString()}");
      return NetworkResponse(
        errorText: "An unknown exception occurred.${error}",
      );
    }
  }

  Future<NetworkResponse> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return NetworkResponse(data: userCredential);
    } on FirebaseAuthException catch (e) {
      print("ERROR:$e");
      return NetworkResponse(
        errorText: SignUpWithEmailAndPasswordFailure.fromCode(e.code).message,
        errorCode: e.code,
      );
    } catch (_) {
      print("ERROR:$_");
      return NetworkResponse(
        errorText: "An unknown exception occurred.",
      );
    }
  }

  Future<NetworkResponse> googleSignIn() async {
    try {
      late final AuthCredential credential;
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser!.authentication;
      credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return NetworkResponse(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return NetworkResponse(
          errorCode: LogInWithGoogleFailure.fromCode(e.code).message);
    } catch (_) {
      return NetworkResponse(
        errorText: "An unknown exception occurred.",
      );
    }
  }

  Future<NetworkResponse> logOutUser() async {
    try {
      await StorageRepository.setString(
        key: "pin_code",
        value: "",
      );
      await StorageRepository.setBool(
        key: "biometrics_enabled",
        value: false,
      );
      await FirebaseAuth.instance.signOut();
      return NetworkResponse(data: "success");
    } on FirebaseAuthException catch (e) {
      return NetworkResponse(
        errorText: "Error",
        errorCode: e.code,
      );
    } catch (_) {
      return NetworkResponse(
        errorText: "An unknown exception occurred.",
      );
    }
  }
}
