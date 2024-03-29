part of main_group_list_page_view;

class _MainGroupListPageMobile extends StatefulWidget {
  _MainGroupListPageMobile(this.viewModel);
  final MainGroupListPageViewModel viewModel;
  @override
  State<_MainGroupListPageMobile> createState() =>
      _MainGroupListPageMobileState(viewModel);
}

class _MainGroupListPageMobileState extends State<_MainGroupListPageMobile>
    with AutomaticKeepAliveClientMixin {
  final MainGroupListPageViewModel viewModel;

  _MainGroupListPageMobileState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
          bottom: false,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Container(height: 70, child: _myInfo()),
                      Container(
                        height: 40,
                        child: Container(
                          height: 40,
                          child: _searchBar(context),
                        ),
                      ),
                      Container(
                          height: constraints.maxHeight / 100 * 85,
                          child: _listView())
                    ],
                  ));
            },
          )),
    );
  }

  Widget _myInfo() {
    return Container(
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: InkWell(
                onTap: () async {
                  await locator<NavigatorService>().navigateToPage(
                      HeadshotPreviewPageView(), RouteSettings(name: ""));
                  viewModel.notifyListeners();
                },
                child: Authentication.user.image.isEmpty
                    ? CircleAvatar(
                        maxRadius: 25.0,
                        backgroundColor: Colors.blueGrey,
                        child: Icon(FontAwesomeIcons.user))
                    : CachedNetworkImage(
                        imageUrl:
                            "${Config.apiURL('/file/image/headshot?i=${Authentication.user.id}&f=${Authentication.user.image}')}",
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                              maxRadius: 25.0,
                              backgroundImage: imageProvider,
                            )),
              )),
          Expanded(
              flex: 5,
              child: Column(
                children: [
                  Container(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(Authentication.user.name,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20)),
                  ),
                  Container(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(Authentication.user.userSM ?? "",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14)),
                  )
                ],
              )),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                InkWell(
                    onTap: () {},
                    child: Icon(FontAwesomeIcons.solidBell, size: 20)),
                Spacer(),
                InkWell(
                    onTap: () {
                      locator<NavigatorService>().navigateToPage(
                          FindAndAddFriendPageView(), RouteSettings(name: ""));
                    },
                    child: Icon(FontAwesomeIcons.userPlus, size: 20)),
                Spacer(),
                InkWell(
                    onTap: () {}, child: Icon(FontAwesomeIcons.cog, size: 20)),
                Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _searchBar(context) {
    return Row(children: [
      Expanded(
        flex: 1,
        child: Icon(Icons.search),
      ),
      Expanded(
        flex: 8,
        child: TextField(
            style: Theme.of(context).textTheme.bodyText1,
            cursorColor: Colors.black,
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintStyle: Theme.of(context).textTheme.bodyText1,
                hintText: "輸入關鍵字搜尋")),
      ),
      Expanded(
        flex: 1,
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.qr_code_scanner),
        ),
      )
    ]);
  }

  Widget _listView() {
    return viewModel.controller.text == ""
        ? FutureBuilder<APIReturn>(
            future: NetWorkAPI.getGroupAndFriend(),
            builder: (BuildContext context, AsyncSnapshot<APIReturn> snapshot) {
              if (snapshot.connectionState != ConnectionState.done ||
                  snapshot.data == null) {
                return Container();
              } else {
                if (snapshot.data.status) {
                  return LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return CustomScrollView(
                        slivers: [
                          SliverPersistentHeader(
                            delegate: SectionHeaderDelegate(
                                "好友 ${snapshot.data.data["friendCount"]}"),
                            pinned: true,
                          ),
                          SliverAnimatedList(
                            initialItemCount: snapshot.data.data["friendCount"],
                            itemBuilder: (BuildContext context, int index,
                                Animation<double> animation) {
                              Friend _friend = Friend.fromMap(
                                  snapshot.data.data['friendList'][index]);
                              Config.friendCache.addAll({_friend.id: _friend});
                              // Faker faker = new Faker();
                              return InkWell(
                                onTap: () {
                                  Config.currentUser = _friend;
                                  locator<NavigatorService>().navigateToPage(
                                      MessagePageView(
                                        group: null,
                                        friend: _friend,
                                        isGroupChat: false,
                                      ),
                                      RouteSettings(name: "MessagePageView"));
                                },
                                child: firendRow(_friend),
                              );
                            },
                          ),
                          SliverPersistentHeader(
                            delegate: SectionHeaderDelegate(
                                "群組 ${snapshot.data.data["groupCount"]}"),
                            pinned: true,
                          ),
                          SliverAnimatedList(
                            initialItemCount: snapshot.data.data["groupCount"],
                            itemBuilder: (BuildContext context, int index,
                                Animation<double> animation) {
                              Group _group = Group.fromMap(
                                  snapshot.data.data['groupList'][index]);
                              return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MessagePageView(
                                                friend: null,
                                                group: _group,
                                                isGroupChat: true,
                                              )),
                                    );
                                  },
                                  child: groupRow(_group));
                            },
                          )
                        ],
                      );
                    },
                  );
                } else {
                  return Container();
                }
              }
            })
        : ListView();
  }

  Widget firendRow(Friend _friend) {
    return Container(
        key: UniqueKey(),
        height: 60,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: _friend.image.isEmpty
                    ? CircleAvatar(
                        maxRadius: 25.0,
                        backgroundColor: Colors.blueGrey,
                        child: Icon(FontAwesomeIcons.user))
                    : FirendMessageHeadshotWidget(
                        id: _friend.id,
                        size: 25.0,
                      )),
            Expanded(
                flex: 6,
                child: Column(
                  children: [
                    Container(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(_friend.name,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 20)),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(_friend.userSM,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14)),
                    )
                  ],
                )),
            Expanded(flex: 2, child: Container())
          ],
        ));
  }

  Widget groupRow(Group _group) {
    return Container(
        key: UniqueKey(),
        height: 60,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: CircleAvatar(
                  maxRadius: 25.0,
                  backgroundColor: Colors.blueGrey,
                  // backgroundImage: NetworkImage(faker.image.image()),
                )),
            Expanded(
              flex: 6,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(_group.name,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20)),
              ),
            ),
            Expanded(flex: 2, child: Container())
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final double height;

  SectionHeaderDelegate(this.title, {this.height = 50});

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Text(title),
            Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
