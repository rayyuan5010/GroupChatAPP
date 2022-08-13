part of headshot_preview_page_view;

class _HeadshotPreviewPageTablet extends StatelessWidget {
  final HeadshotPreviewPageViewModel viewModel;

  _HeadshotPreviewPageTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('HeadshotPreviewPageTablet')),
    );
  }
}