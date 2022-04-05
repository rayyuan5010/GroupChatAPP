part of login_page_view;

class _LoginPageTablet extends StatelessWidget {
  final LoginPageViewModel viewModel;

  _LoginPageTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('LoginPageTablet')),
    );
  }
}
