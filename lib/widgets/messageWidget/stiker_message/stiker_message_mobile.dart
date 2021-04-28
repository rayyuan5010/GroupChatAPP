part of stiker_message_widget;

class _StikerMessageMobile extends StatelessWidget {
  _StikerMessageMobile({@required this.message, @required this.self});
  final Message message;
  final bool self;
  @override
  Widget build(BuildContext context) {
    return selfMessage();
  }

  Widget selfMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          constraints: BoxConstraints(
            maxWidth: 250,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 150,
              height: 150,
              child: Image.network(this.message.messageContent.content),
            ),
          ),
        ),
      ),
    );
  }
}
