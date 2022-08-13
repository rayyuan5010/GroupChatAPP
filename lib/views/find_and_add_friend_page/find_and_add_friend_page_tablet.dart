part of find_and_add_friend_page_view;

class _FindAndAddFriendPageTablet extends StatelessWidget {
  final FindAndAddFriendPageViewModel viewModel;

  _FindAndAddFriendPageTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('FindAndAddFriendPageTablet')),
    );
  }
}