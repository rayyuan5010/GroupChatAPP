part of text_message_widget;

class _TextMessageMobile extends StatelessWidget {
  _TextMessageMobile({@required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return selfTextMessage();
  }

  // Widget selfMessage() {

  // }

  Widget selfTextMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          decoration: BoxDecoration(
              color: AppThemes.textMessageBubble,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          constraints: BoxConstraints(
            maxWidth: 250,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(this.message.messageContent.content,
                style: TextStyle(fontSize: 14)),
          ),
        ),
      ),
    );
  }

  Widget friendMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          decoration: BoxDecoration(
              color: AppThemes.textMessageBubble,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          constraints: BoxConstraints(
            maxWidth: 250,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                '123\r\n12312dsfsdfdsfsdfawqf123n12312dsfsdfdsfsdfawqf123n12312dsfsdfdsfsdfawqf123',
                style: TextStyle(fontSize: 14)),
          ),
        ),
      ),
    );
  }
}
