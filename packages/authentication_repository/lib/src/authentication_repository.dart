import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';

import 'models/models.dart';

class LinkParticleCloudFailure implements Exception {}

class FirebaseSignUpFailure implements Exception {}

class FirebaseLoginFailure implements Exception {}

class LogOutFailure implements Exception {}


class AuthenticationRepository {
  final _store = FirebaseFirestore.instance;
  final _auth = auth.FirebaseAuth.instance;

  AuthenticationRepository() {
    _auth.authStateChanges().listen((_) async {
      _userController.add(await currentUser);
    });
  }

  Future<String> get token async {
    try {
      final result = await _store.collection('users').doc(_auth.currentUser.uid).get();
      return result.data()['cloud_token'];
    } catch(e) {
      print(e);
      return null;
    }
  }

  Future<User> get currentUser async {
    final firebaseUser = _auth.currentUser;
    return firebaseUser == null ? User.empty : User(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      name: firebaseUser.displayName,
      isCloudLinked: await token != null,
    );
  }

  final StreamController<User> _userController = StreamController.broadcast();
  Stream<User> get user async* {
    yield* _userController.stream;
    emitUser();
  }

  Future<void> emitUser() async {
    _userController.add(await currentUser);
  }

  Future<void> unlink() async {
    try {
      await _store.collection('users').doc(_auth.currentUser.uid).delete();
      await emitUser();
    } catch(e) {
      print(e);
      throw LinkParticleCloudFailure();
    }
  }

  Future<void> link({
    @required String email,
    @required String password,
    @required String id,
    @required String secret,
  }) async {
    try {
      final authResponse = await Dio().post('https://api.particle.io/oauth/token',
        data: <String, dynamic>{
          'client_id': id,
          'client_secret': secret,
          'grant_type': 'password',
          'username': email,
          'password': password,
          'expires_in': 0
        },
        options: Options(contentType: 'application/x-www-form-urlencoded')
      );

      final accessToken = authResponse.data['access_token'] as String;

      if (authResponse.statusCode == 200) {
        final userResponse = await Dio().get('https://api.particle.io/v1/user',
          options: Options(headers: { 'Authorization': 'Bearer $accessToken'})
        );

        if (userResponse.statusCode == 200) {
          await _store.collection('users').doc(_auth.currentUser.uid).set({
            'cloud_token': accessToken,
            'cloud_username': userResponse.data['username'] as String,
          });
          await emitUser();
        } else {
          throw LinkParticleCloudFailure();
        }
      } else {
        throw LinkParticleCloudFailure();
      }
    } on DioError catch(e) {
      print(e);
      throw LinkParticleCloudFailure();
    } catch(e) {
      print(e);
      throw LinkParticleCloudFailure();
    }
  }

  Future<void> signUp({
    @required String email,
    @required String password,
  }) async {
    try {
      final credential = _auth.createUserWithEmailAndPassword(email: email, password: password);
      print(credential);
    } on auth.FirebaseException catch (e) {
      print(e);
      throw FirebaseSignUpFailure();
    } catch(e) {
      print(e);
      throw FirebaseSignUpFailure();
    }
  }

  Future<void> login({
    @required String email,
    @required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on auth.FirebaseException catch(e) {
      print(e);
      throw FirebaseLoginFailure();
    } catch(e) {
      print(e);
      throw FirebaseLoginFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } on Exception {
      throw LogOutFailure();
    }
  }
}
