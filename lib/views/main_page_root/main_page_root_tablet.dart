part of main_page_root_view;

class _MainPageRootTablet extends StatelessWidget {
  final MainPageRootViewModel viewModel;

  _MainPageRootTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('MainPageRootTablet')),
    );
  }
}