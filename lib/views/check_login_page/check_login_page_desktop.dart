part of check_login_page_view;

class _CheckLoginPageDesktop extends StatelessWidget {
  final CheckLoginPageViewModel viewModel;

  _CheckLoginPageDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('CheckLoginPageDesktop')),
    );
  }
}