part of message_page_view;

class _MessagePageTablet extends StatelessWidget {
  final MessagePageViewModel viewModel;

  _MessagePageTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('MessagePageTablet')),
    );
  }
}