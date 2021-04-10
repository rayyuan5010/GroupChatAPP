part of talk_list_view;

class _TalkListTablet extends StatelessWidget {
  final TalkListViewModel viewModel;

  _TalkListTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('TalkListTablet')),
    );
  }
}