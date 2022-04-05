part of setting_page_view;

class _SettingPageMobile extends StatelessWidget {
  final SettingPageViewModel viewModel;

  _SettingPageMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RaisedButton(
          onPressed: () {
            // Authentication.auth.signOut();
            // LoginStatus s
            Authentication.status = LoginStatus.noSingIn;
            // viewModel.notifyListeners();
            // viewModel.dispose();
            // viewModel.notifyListeners();
            RootPageController.rootPageViewModel.notifyListeners();
          },
          child: Text('logout'),
        ),
      ),
    );
  }
}
