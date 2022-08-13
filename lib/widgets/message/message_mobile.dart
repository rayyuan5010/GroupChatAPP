part of message_widget;

class _MessageMobile extends StatelessWidget {
  _MessageMobile(
      {@required this.message,
      @required this.showHead,
      @required this.showTime});
  final Message message;
  final bool showTime;
  final bool showHead;
  User user = Authentication.user;
  @override
  Widget build(BuildContext context) {
    switch (message.messageDetail.messageType) {
      case MessageType.TEXT:
        return TextMessageWidget(
            message: message,
            self: user.id == message.senderId,
            showHead: showHead,
            showTime: showTime);
      case MessageType.STIKER:
        return StikerMessageWidget(
            message: message, self: user.id == message.senderId);
      case MessageType.IMAGE:
        return ImageMessageWidget(
            message: message, self: user.id == message.senderId);
      case MessageType.FILE:
        return TextMessageWidget(
            message: message,
            self: user.id == message.senderId,
            showHead: showHead,
            showTime: showTime);
      case MessageType.MAPMARKER:
        return TextMessageWidget(
            message: message,
            self: user.id == message.senderId,
            showHead: showHead,
            showTime: showTime);
      case MessageType.MAPPATH:
        return TextMessageWidget(
            message: message,
            self: user.id == message.senderId,
            showHead: showHead,
            showTime: showTime);
      case MessageType.DRAW:
        return TextMessageWidget(
            message: message,
            self: user.id == message.senderId,
            showHead: showHead,
            showTime: showTime);
      default:
        return TextMessageWidget(
            message: message,
            self: user.id == message.senderId,
            showHead: showHead,
            showTime: showTime);
    }
  }
}
