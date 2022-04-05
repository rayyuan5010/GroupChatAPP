part of root_page_view;

class _RootPageMobile extends StatelessWidget {
  final RootPageViewModel viewModel;

  _RootPageMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    switch (Authentication.status) {
      case LoginStatus.noSingIn:
        return LoginPageView();
        break;
      case LoginStatus.signIn:
        return MainPageRootView();
        break;
      case LoginStatus.checkStatus:
        return CheckLoginPageView();
        break;
      default:
        return CheckLoginPageView();
        break;
    }
  }
}
