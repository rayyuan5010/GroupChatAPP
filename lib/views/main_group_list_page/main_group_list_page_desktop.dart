part of main_group_list_page_view;

class _MainGroupListPageDesktop extends StatelessWidget {
  final MainGroupListPageViewModel viewModel;

  _MainGroupListPageDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('MainGroupListPageDesktop')),
    );
  }
}