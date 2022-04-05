part of main_group_list_page_view;

class _MainGroupListPageTablet extends StatelessWidget {
  final MainGroupListPageViewModel viewModel;

  _MainGroupListPageTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('MainGroupListPageTablet')),
    );
  }
}