import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class Authentication {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static User user;
}
