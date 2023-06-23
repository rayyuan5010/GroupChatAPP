part of message_page_view;

class _MessagePageMobile extends StatefulWidget {
  _MessagePageMobile(this.viewModel);
  final MessagePageViewModel viewModel;
  @override
  State<_MessagePageMobile> createState() => _MessagePageMobileState(viewModel);
}

class _MessagePageMobileState extends State<_MessagePageMobile>
    with AutomaticKeepAliveClientMixin {
  _MessagePageMobileState(this.viewModel);
  final MessagePageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          viewModel.title,
          // style: TextStyle(color: Colors.black),
        ),
        // iconTheme: IconThemeData(color: Colors.black),
        actions: [IconButton(icon: Icon(Icons.more_vert), onPressed: () {})],
      ),
      body: bodyView(),
    );
  }
  // List<Widget> pages = [
  //  mapWidget(),
  //   Container(child: Text('p2')),
  // ];

  Widget bodyView() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          height: constraints.maxHeight,
          child: Column(
            children: [
              Container(
                height: 300,
                child: Container(
                  width: constraints.maxWidth,
                  child: Container(
                      width: constraints.maxWidth,
                      child: DefaultTabController(
                        length: 2,
                        child: LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraints) {
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
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      '筆跡',
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                height: constraints.maxHeight < 50
                                    ? 0
                                    : constraints.maxHeight - 50,
                                child: PageView(
                                  physics: NeverScrollableScrollPhysics(),
                                  controller: viewModel.controller,
                                  children: [
                                    GoogleMapWidget(
                                        onFinished:
                                            (Completer<GoogleMapController>
                                                _controller) async {
                                          viewModel.getPosition(
                                              context, _controller);
                                        },
                                        markers: viewModel.markers),
                                    Container()
                                  ],
                                ),
                              )
                            ],
                          );
                        }),
                      )),
                ),
              ),
              Expanded(
                  flex: 50,
                  child: Container(
                      child: MessageListWidget(
                    controller: viewModel.scrollController,
                    children: List.generate(
                      viewModel.messageList.length,
                      (index) {
                        bool showHead = true;
                        bool showTime = false;
                        if (viewModel.preMessageSender !=
                            viewModel.messageList[index].senderId) {
                          showHead = false;
                        }
                        if ((index + 1) < viewModel.messageList.length) {
                          if (viewModel.messageList[index + 1].senderId !=
                              viewModel.messageList[index].senderId) {
                            showTime = true;
                          }
                        }

                        viewModel.preMessageSender =
                            viewModel.messageList[index].senderId;

                        return MessageWidget(
                          message: viewModel.messageList[index],
                          showHead: !showHead,
                          showTime: showTime,
                        );
                      },
                    ),
                  ))),
              Container(height: 10),
              Container(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {
                              showCupertinoModalBottomSheet(
                                // expand: true,
                                context: context,
                                // backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return MessageTypeTablWidget(
                                    onSelected: (String stickerId) {
                                      viewModel.sendMessage(
                                          type: MessageType.STIKER,
                                          otherMessage: stickerId);
                                    },
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.add)),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          // color: Colors.red,
                          height: 40,
                          child: SingleChildScrollView(
                            child: TextField(
                                maxLines: null,
                                textInputAction: TextInputAction.newline,
                                controller: viewModel.sendMessageController,
                                style: Theme.of(context).textTheme.bodyText1,
                                cursorColor: Colors.black,
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 15,
                                        top: 5,
                                        right: 15),
                                    hintStyle:
                                        Theme.of(context).textTheme.bodyText1,
                                    hintText: "輸入訊息")),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TapDebouncer(
                          cooldown: const Duration(milliseconds: 1000),
                          onTap: () async => await viewModel.sendMessage(),
                          builder: ((context, onTap) => IconButton(
                                onPressed: onTap,
                                icon: Icon(Icons.send),
                              )),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
