part of login_page_view;

class _LoginPageMobile extends StatelessWidget {
  final LoginPageViewModel viewModel;

  _LoginPageMobile(this.viewModel);
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: '登入',
      theme: LoginTheme(),
      messages: LoginMessages(
          signupButton: "註冊",
          loginButton: "登入",
          usernameHint: "信箱",
          passwordHint: "密碼",
          confirmPasswordError: "錯誤",
          confirmPasswordHint: "確認密碼",
          forgotPasswordButton: "忘記密碼",
          goBackButton: "返回",
          recoverPasswordButton: "取得",
          recoverPasswordDescription: "將會發送密碼至您的信箱",
          recoverPasswordIntro: "重置您的密碼"),
      emailValidator: viewModel.emailValidator,
      passwordValidator: viewModel.passwordValidator,
      onLogin: viewModel.authUser,
      onSignup: viewModel.signup,
      onSubmitAnimationCompleted: () => viewModel.onComplete(context),
      onRecoverPassword: viewModel.recoverPassword,
    );
  }
}
