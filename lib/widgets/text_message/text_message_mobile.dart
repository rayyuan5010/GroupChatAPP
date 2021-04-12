part of text_message_widget;

class _TextMessageMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 200, left: 15),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        width: 10,
        // height: 80,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('123'),
        ),
      ),
    );
  }
}
