part of root_page_view;

class _RootPageDesktop extends StatelessWidget {
  final RootPageViewModel viewModel;

  _RootPageDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('RootPageDesktop')),
    );
  }
}