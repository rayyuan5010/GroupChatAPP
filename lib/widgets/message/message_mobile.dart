part of message_widget;

class _MessageMobile extends StatelessWidget {
  _MessageMobile({@required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    switch (message.messageContent.messageType) {
      case MessageType.TEXT:
        return TextMessageWidget(message: message);
      case MessageType.STIKER:
        return StikerMessageWidget(message: message);
      case MessageType.IMAGE:
        return ImageMessageWidget(message: message);
      case MessageType.FILE:
        return TextMessageWidget(message: message);
      case MessageType.MAPMARKER:
        return TextMessageWidget(message: message);
      case MessageType.MAPPATH:
        return TextMessageWidget(message: message);
      case MessageType.DRAW:
        return TextMessageWidget(message: message);
      default:
        return TextMessageWidget(message: message);
    }
  }
}
