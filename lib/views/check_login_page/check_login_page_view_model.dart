import 'package:firebase_auth/firebase_auth.dart';

import 'package:group_chat/core/base/base_view_model.dart';

class CheckLoginPageViewModel extends BaseViewModel {
  CheckLoginPageViewModel();
  User user;
  void checkLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    print(auth);

    // final GoogleSignIn googleSignIn = GoogleSignIn();

    // final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    // if (googleSignInAccount != null) {
    //   final GoogleSignInAuthentication googleSignInAuthentication =
    //       await googleSignInAccount.authentication;

    //   final AuthCredential credential = GoogleAuthProvider.credential(
    //     accessToken: googleSignInAuthentication.accessToken,
    //     idToken: googleSignInAuthentication.idToken,
    //   );

    //   try {
    //     final UserCredential userCredential =
    //         await auth.signInWithCredential(credential);

    //     user = userCredential.user;
    //   } on FirebaseAuthException catch (e) {
    //     if (e.code == 'account-exists-with-different-credential') {
    //       // ...
    //     } else if (e.code == 'invalid-credential') {
    //       // ...
    //     }
    //   } catch (e) {
    //     // ...
    //   }
    // }
  }
}
