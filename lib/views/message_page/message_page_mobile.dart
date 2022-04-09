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
                                          final GoogleMapController controller =
                                              await _controller.future;
                                          controller.animateCamera(
                                              CameraUpdate.newCameraPosition(
                                                  CameraPosition(
                                            target: LatLng(position.latitude,
                                                position.longitude),
                                            zoom: 14.4746,
                                          )));
                                          // viewModel.markers = {
                                          //   Marker(
                                          //     markerId: MarkerId("marker_1"),
                                          //     position: LatLng(
                                          //         position.latitude,
                                          //         position.longitude),
                                          //   )
                                          // };
                                          // viewModel.notifyListeners();
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
                      (index) =>
                          MessageWidget(message: viewModel.messageList[index]),
                    ),
                  ))),
              Container(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Icon(Icons.add),
                      ),
                      Expanded(
                        flex: 8,
                        child: SingleChildScrollView(
                          child: TextField(
                              maxLines: null,
                              textInputAction: TextInputAction.newline,
                              controller: viewModel.sendMessageController,
                              cursorColor: Colors.black,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: "輸入訊息")),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () async {
                            var time = DateTime.now().millisecondsSinceEpoch;
                            viewModel.messageList.add(Message.fromMap({
                              "senderId": Authentication.user.id,
                              "senderName": "name",
                              "senderImage": "image",
                              "reciver": "",
                              "reciveType": 0,
                              "messageId": "${Authentication.user.id}-${time}",
                              "messageType": 0,
                              "messageTime": time,
                              "messageContent":
                                  viewModel.sendMessageController.text,
                              "messageTabId": ""
                            }));
                            viewModel.sendMessageController.clear();
                            viewModel.notifyListeners();
                            await Future.delayed(
                                const Duration(milliseconds: 100));
                            SchedulerBinding.instance
                                ?.addPostFrameCallback((_) {
                              viewModel.scrollController.animateTo(
                                  viewModel.scrollController.position
                                      .maxScrollExtent,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn);
                            });
                          },
                          icon: Icon(Icons.send),
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
}
