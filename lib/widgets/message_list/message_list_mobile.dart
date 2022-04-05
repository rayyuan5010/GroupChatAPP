part of message_list_widget;

class _MessageListMobile extends StatelessWidget {
  _MessageListMobile(
      {Key key, @required this.children, @required this.controller})
      : super(key: key);
  List<MessageWidget> children;
  ScrollController controller;
  double totalWidgetSize = 0.0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        controller: controller,
        itemBuilder: (context, index) {
          MessageWidget mw = children[index];
          return Container(
            key: UniqueKey(),
            child: mw,
          );
        },
        separatorBuilder: (context, index) => Container(
              height: 10,
            ),
        itemCount: children.length);
  }
}
