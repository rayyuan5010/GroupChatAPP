part of text_message_widget;

class _TextMessageMobile extends StatelessWidget {
  _TextMessageMobile(
      {@required this.message,
      @required this.self,
      @required this.showHead,
      @required this.showTime});
  final bool showTime;
  final bool showHead;
  final Message message;
  final bool self;
  @override
  Widget build(BuildContext context) {
    return self ? selfTextMessage(context) : friendMessage(context);
  }

  // Widget selfMessage() {

  // }

  Widget selfTextMessage(BuildContext context) {
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
            child: Text(this.message.messageDetail.content ?? "",
                style: TextStyle(fontSize: 14)),
          ),
        ),
      ),
    );
  }

  Widget friendMessage(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Stack(
            clipBehavior: Clip.none,
            // overflow: Overflow.visible,
            children: [
              Visibility(
                  visible: showHead,
                  child: Positioned(
                    top: 5,
                    left: 5,
                    child: Container(
                      child: FirendMessageHeadshotWidget(
                        id: message.senderId,
                        size: 20,
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppThemes.textMessageBubble,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  constraints: BoxConstraints(maxWidth: 250, maxHeight: 400),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(message.messageDetail.content,
                        style: TextStyle(fontSize: 14)),
                  ),
                ),
              ),
              Visibility(
                  visible: showTime,
                  child: Positioned(
                    bottom: 0,
                    right: -60,
                    child: Container(
                      width: 50,
                      child: Text(
                          DateFormat('HH:mm')
                              .format(message.messageDetail.reciveTime),
                          style: TextStyle(
                              fontSize: 10,
                              color:
                                  Theme.of(context).textTheme.bodyText1.color)),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
