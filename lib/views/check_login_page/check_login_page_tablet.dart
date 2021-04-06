part of check_login_page_view;

class _CheckLoginPageTablet extends StatelessWidget {
  final CheckLoginPageViewModel viewModel;

  _CheckLoginPageTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('CheckLoginPageTablet')),
    );
  }
}