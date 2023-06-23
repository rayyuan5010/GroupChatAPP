part of stiker_message_widget;

class _StikerMessageMobile extends StatefulWidget {
  _StikerMessageMobile(
      {@required this.message,
      @required this.self,
      @required this.showHead,
      @required this.showTime});
  final bool showTime;
  final bool showHead;
  final Message message;
  final bool self;
  @override
  State<_StikerMessageMobile> createState() => _StikerMessageState(
      message: message, self: self, showHead: showHead, showTime: showTime);
}

class _StikerMessageState extends State<_StikerMessageMobile>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  _StikerMessageState(
      {@required this.message,
      @required this.self,
      @required this.showHead,
      @required this.showTime});
  final bool showTime;
  final bool showHead;
  final Message message;
  final bool self;

  @override
  void initState() {
    super.initState();
  }

  ImageProvider<Object> getSticker() {
    String _id = this.message.messageDetail.content;
    print(this.message.messageDetail.content);
    File sticker = Config.getSticker(_id);
    if (sticker.existsSync()) {
      return ExtendedImage.file(sticker).image;
    } else {
      String imagePath = "${Config.defaultPath}/Sticker/images/";
      NetWorkAPI.downloadFile('/file/image/sticker?i=$_id', _id, imagePath);
      return ExtendedImage.network(
        Config.apiURL('/file/image/sticker?i=$_id'),
        cache: true,
      ).image;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                child: ExtendedImage(
                  image: getSticker(),
                )),
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
                    child: SizedBox(
                        width: 150,
                        height: 150,
                        child: ExtendedImage(
                          image: getSticker(),
                        )),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
