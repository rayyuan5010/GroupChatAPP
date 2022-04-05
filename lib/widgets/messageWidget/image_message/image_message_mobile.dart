part of image_message_widget;

class _ImageMessageMobile extends StatelessWidget {
  _ImageMessageMobile({@required this.message, @required this.self});
  final Message message;
  final bool self;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('image_message_mobile'),
    );
  }
}
