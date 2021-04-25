part of text_message_widget;

class _TextMessageMobile extends StatelessWidget {
  _TextMessageMobile({@required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return selfMessage();
  }

  Widget selfMessage() {
    switch (message.messageContent.messageType) {
      case MessageType.TEXT:
        return selfTextMessage();
      case MessageType.STIKER:
        return selfStikerMessage();
      case MessageType.IMAGE:
        return selfTextMessage();
      case MessageType.FILE:
        return selfTextMessage();
      case MessageType.MAPMARKER:
        return selfTextMessage();
      case MessageType.MAPPATH:
        return selfTextMessage();
      case MessageType.DRAW:
        return selfTextMessage();
      default:
        return selfTextMessage();
    }
  }

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
            child: Text(this.message.messageContent.showMessage,
                style: TextStyle(fontSize: 14)),
          ),
        ),
      ),
    );
  }

  Widget selfStikerMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          decoration: BoxDecoration(
              // color: AppThemes.textMessageBubble,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          constraints: BoxConstraints(
            maxWidth: 250,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(this.message.messageContent.showMessage),
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
