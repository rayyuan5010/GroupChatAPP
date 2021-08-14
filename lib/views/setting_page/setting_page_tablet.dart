part of setting_page_view;

class _SettingPageTablet extends StatelessWidget {
  final SettingPageViewModel viewModel;

  _SettingPageTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('SettingPageTablet')),
    );
  }
}