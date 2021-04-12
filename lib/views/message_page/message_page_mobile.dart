part of message_page_view;

class _MessagePageMobile extends StatelessWidget {
  final MessagePageViewModel viewModel;

  _MessagePageMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          viewModel.title,
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [IconButton(icon: Icon(Icons.more_vert), onPressed: () {})],
      ),
      body: SafeArea(
        child: bodyView(),
      ),
    );
  }

  Widget bodyView() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          height: constraints.maxHeight,
          child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: viewModel.showForTop(constraints.maxHeight),
                    width: constraints.maxWidth,
                    child: Container(
                        width: constraints.maxWidth,
                        child: DefaultTabController(
                          length: 2,
                          child: LayoutBuilder(builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return Column(
                              children: [
                                TabBar(
                                  onTap: (index) {
                                    viewModel.controller.jumpToPage(index);
                                  },
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        '地圖',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        '筆跡',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  height: constraints.maxHeight < 60
                                      ? 0
                                      : constraints.maxHeight - 60,
                                  child: PageView(
                                    physics: NeverScrollableScrollPhysics(),
                                    controller: viewModel.controller,
                                    children: viewModel.pages,
                                  ),
                                )
                              ],
                            );
                          }),
                        )),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: viewModel.showForBottom(constraints.maxHeight),
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return TextMessageWidget();
                      },
                    ),
                  ),
                  Container(
                      height: constraints.maxHeight / 100 * 8,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Icon(Icons.add),
                          ),
                          Expanded(
                            flex: 8,
                            child: TextField(
                                cursorColor: Colors.black,
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                    hintText: "輸入訊息")),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.send),
                            ),
                          )
                        ],
                      )),
                ],
              )),
        );
      },
    );
  }
}
