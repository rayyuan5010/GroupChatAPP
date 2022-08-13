part of headshot_preview_page_view;

class _HeadshotPreviewPageDesktop extends StatelessWidget {
  final HeadshotPreviewPageViewModel viewModel;

  _HeadshotPreviewPageDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('HeadshotPreviewPageDesktop')),
    );
  }
}