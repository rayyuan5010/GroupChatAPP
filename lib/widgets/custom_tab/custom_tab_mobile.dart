part of custom_tab_widget;

class _CustomTabMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: constraints.maxWidth,
          height: 30,
          child: Row(
            children: [
              Container(
                child: Text('123'),
              ),
              Container(
                child: Text('123'),
              ),
              Container(
                child: Text('123'),
              )
            ],
          ),
        );
      },
    );
  }
}
