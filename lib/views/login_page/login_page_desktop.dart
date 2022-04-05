part of login_page_view;

class _LoginPageDesktop extends StatelessWidget {
  final LoginPageViewModel viewModel;

  _LoginPageDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('LoginPageDesktop')),
    );
  }
}