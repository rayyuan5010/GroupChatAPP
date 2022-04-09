part of message_widget;

class _MessageMobile extends StatelessWidget {
  _MessageMobile({@required this.message});
  final Message message;
  User user = Authentication.user;
  @override
  Widget build(BuildContext context) {
    switch (message.messageType) {
      case MessageType.TEXT:
        return TextMessageWidget(
            message: message, self: user.id == message.senderId);
      case MessageType.STIKER:
        return StikerMessageWidget(
            message: message, self: user.id == message.senderId);
      case MessageType.IMAGE:
        return ImageMessageWidget(
            message: message, self: user.id == message.senderId);
      case MessageType.FILE:
        return TextMessageWidget(
            message: message, self: user.id == message.senderId);
      case MessageType.MAPMARKER:
        return TextMessageWidget(
            message: message, self: user.id == message.senderId);
      case MessageType.MAPPATH:
        return TextMessageWidget(
            message: message, self: user.id == message.senderId);
      case MessageType.DRAW:
        return TextMessageWidget(
            message: message, self: user.id == message.senderId);
      default:
        return TextMessageWidget(
            message: message, self: user.id == message.senderId);
    }
  }
}
