part of main_page_root_view;

class _MainPageRootDesktop extends StatelessWidget {
  final MainPageRootViewModel viewModel;

  _MainPageRootDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('MainPageRootDesktop')),
    );
  }
}