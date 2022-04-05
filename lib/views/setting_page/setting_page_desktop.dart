part of setting_page_view;

class _SettingPageDesktop extends StatelessWidget {
  final SettingPageViewModel viewModel;

  _SettingPageDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('SettingPageDesktop')),
    );
  }
}