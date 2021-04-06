part of login_page_view;

class _LoginPageMobile extends StatelessWidget {
  final LoginPageViewModel viewModel;

  _LoginPageMobile(this.viewModel);
// LoginMessages({
//     this.usernameHint = defaultUsernameHint,
//     this.passwordHint = defaultPasswordHint,
//     this.confirmPasswordHint = defaultConfirmPasswordHint,
//     this.forgotPasswordButton = defaultForgotPasswordButton,
//     this.loginButton = defaultLoginButton,
//     this.signupButton = defaultSignupButton,
//     this.recoverPasswordButton = defaultRecoverPasswordButton,
//     this.recoverPasswordIntro = defaultRecoverPasswordIntro,
//     this.recoverPasswordDescription = defaultRecoverPasswordDescription,
//     this.goBackButton = defaultGoBackButton,
//     this.confirmPasswordError = defaultConfirmPasswordError,
//     this.recoverPasswordSuccess = defaultRecoverPasswordSuccess,
//   });

  static const defaultUsernameHint = 'Email';
  static const defaultPasswordHint = 'Password';
  static const defaultConfirmPasswordHint = 'Confirm Password';
  static const defaultForgotPasswordButton = 'Forgot Password?';
  static const defaultLoginButton = 'LOGIN';
  static const defaultSignupButton = 'SIGNUP';
  static const defaultRecoverPasswordButton = 'RECOVER';
  static const defaultRecoverPasswordIntro = 'Reset your password here';
  static const defaultRecoverPasswordDescription =
      'We will send your plain-text password to this email account.';
  static const defaultGoBackButton = 'BACK';
  static const defaultConfirmPasswordError = 'Password do not match!';
  static const defaultRecoverPasswordSuccess = 'An email has been sent';

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
      onSignup: viewModel.authUser,
      onSubmitAnimationCompleted: () => viewModel.onComplete(context),
      onRecoverPassword: viewModel.recoverPassword,
    );
  }
}
