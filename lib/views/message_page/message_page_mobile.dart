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
  // List<Widget> pages = [
  //  mapWidget(),
  //   Container(child: Text('p2')),
  // ];

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
                                            final position = await Geolocator
                                                .getCurrentPosition();
                                            final GoogleMapController
                                                controller =
                                                await _controller.future;
                                            controller.animateCamera(
                                                CameraUpdate.newCameraPosition(
                                                    CameraPosition(
                                              target: LatLng(position.latitude,
                                                  position.longitude),
                                              zoom: 14.4746,
                                            )));
                                            viewModel.markers = {
                                              Marker(
                                                markerId: MarkerId("marker_1"),
                                                position: LatLng(
                                                    position.latitude,
                                                    position.longitude),
                                              )
                                            };
                                            viewModel.notifyListeners();
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
                  Container(
                    height: viewModel.showForBottom(constraints.maxHeight),
                    child: ListView.separated(
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        final sender = MessageSender(
                            name: "Ray",
                            id: "xvzxzv-safasf-wwqrqwr",
                            imageUrl: "");
                        final content = MessageContent(messageRowData: {
                          "content":
                              "aasfasf\r\nsaffasfasfasfasfasf\r\nasfas\r\nsafasfasf",
                          "timestamp": 1618294531000,
                          "type": 0,
                          "id": "xvaxewv-safasf-wwqrqwr",
                          "sender": "xvzxzv-safasf-wwqrqwr"
                        }, messageType: MessageType.TEXT);
                        final content2 = MessageContent(
                            messageType: MessageType.STIKER,
                            messageRowData: {
                              "content":
                                  "https://firebasestorage.googleapis.com/v0/b/myapplication5-c682d.appspot.com/o/gif%2F001%2F0529.gif_wh860.gif?alt=media&token=02d4b4c5-8df4-4dcf-bac7-35f14f513322",
                              "timestamp": 1618294531000,
                              "type": 0,
                              "id": "xvaxewv-safasf-wwqrqwr",
                              "sender": "xvzxzv-safasf-wwqrqwr"
                            });
                        Message message = new Message(
                            messageContent: content2, messageSender: sender);
                        return TextMessageWidget(message: message);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 40,
                        );
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
