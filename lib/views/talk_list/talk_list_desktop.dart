part of talk_list_view;

class _TalkListDesktop extends StatelessWidget {
  final TalkListViewModel viewModel;

  _TalkListDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('TalkListDesktop')),
    );
  }
}