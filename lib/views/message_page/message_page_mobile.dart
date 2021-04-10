part of message_page_view;

class _MessagePageMobile extends StatelessWidget {
  final MessagePageViewModel viewModel;

  _MessagePageMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          viewModel.title,
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [IconButton(icon: Icon(Icons.menu), onPressed: () {})],
      ),
      body: Center(child: Text('MessagePageMobile')),
    );
  }
}
