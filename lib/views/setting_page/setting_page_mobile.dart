part of setting_page_view;

class _SettingPageMobile extends StatelessWidget {
  final SettingPageViewModel viewModel;

  _SettingPageMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        MaterialButton(
          onPressed: () async {
            // Authentication.auth.signOut();
            // LoginStatus s
            Authentication.status = LoginStatus.noSingIn;
            DBHelper dbHelper = DBHelper();
            await dbHelper.logout();
            // viewModel.notifyListeners();
            // viewModel.dispose();
            // viewModel.notifyListeners();
            RootPageController.rootPageViewModel.notifyListeners();
          },
          child: Text('logout'),
        ),
      ]),
    ));
  }
}
