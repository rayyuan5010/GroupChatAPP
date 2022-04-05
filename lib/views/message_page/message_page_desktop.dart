part of message_page_view;

class _MessagePageDesktop extends StatelessWidget {
  final MessagePageViewModel viewModel;

  _MessagePageDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('MessagePageDesktop')),
    );
  }
}