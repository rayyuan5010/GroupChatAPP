part of root_page_view;

class _RootPageTablet extends StatelessWidget {
  final RootPageViewModel viewModel;

  _RootPageTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('RootPageTablet')),
    );
  }
}