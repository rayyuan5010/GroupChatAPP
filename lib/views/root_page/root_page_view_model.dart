import 'package:firebase_auth/firebase_auth.dart';
import 'package:group_chat/core/base/base_view_model.dart';
import 'package:group_chat/other/auth.dart';

class RootPageViewModel extends BaseViewModel {
  RootPageViewModel();
  LoginStatus status = LoginStatus.checkStatus;
  checkLoginStaus() {
    User user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      status = LoginStatus.noSingIn;
    } else {
      status = LoginStatus.signIn;
    }
    notifyListeners();
  }
  // Add ViewModel specific code here
}

enum LoginStatus { noSingIn, signIn, checkStatus }
