part of message_type_tabl_widget;

class _MessageTypeTablMobile extends StatelessWidget {
  _MessageTypeTablMobile({@required this.onSelected});
  final Function(String) onSelected;
  final List<Tab> tabs = [
    Tab(text: '貼圖'),
    Tab(text: '錄音'),
    Tab(
      text: '檔案',
    ),
    Tab(
      text: '其他',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 300,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: DefaultTabController(
          length: tabs.length,
          child: LayoutBuilder(
            builder: (p0, p1) => Container(
              height: p1.maxHeight,
              child: Column(
                children: [
                  TabBar(tabs: tabs),
                  Container(
                    height: p1.maxHeight - 50,
                    child: TabBarView(children: [
                      Container(
                          child: FutureBuilder<APIReturn>(
                              future: NetWorkAPI.getUsersSticker(),
                              // ignore: missing_return
                              builder: (BuildContext context,
                                  AsyncSnapshot<APIReturn> snapshot) {
                                if (snapshot.connectionState !=
                                        ConnectionState.done ||
                                    snapshot.data == null) {
                                  return Container(
                                    height: 50,
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  if (snapshot.data.status) {
                                    return GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              childAspectRatio: 1),
                                      itemCount: snapshot.data.dataCount,
                                      itemBuilder: (context, index) {
                                        String stickerId =
                                            snapshot.data.data[index]["id"];
                                        return TapDebouncer(
                                            cooldown: const Duration(
                                                milliseconds: 1000),
                                            onTap: () async {
                                              onSelected(stickerId);
                                              Navigator.pop(context);
                                            },
                                            builder: ((context, onTap) {
                                              return InkWell(
                                                onTap: onTap,
                                                child: ExtendedImage.network(
                                                  Config.apiURL(
                                                      '/file/image/sticker?i=$stickerId'),
                                                  cache: true,
                                                  // repeat: ImageRepeat.repeat,
                                                ),
                                              );
                                            }));
                                      },
                                    );
                                  }
                                }
                              })),
                      Container(),
                      Container(),
                      Container(),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
