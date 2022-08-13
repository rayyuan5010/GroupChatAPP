part of talk_list_view;

class _TalkListMobile extends StatelessWidget {
  final TalkListViewModel viewModel;

  _TalkListMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: false,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        height: constraints.maxHeight / 100 * 5,
                        child: Container(
                          height: 40,
                          child: _searchBar(),
                        ),
                      ),
                      Container(
                          height: constraints.maxHeight / 100 * 95,
                          child: _listView())
                    ],
                  ));
            },
          )),
    );
  }

  Widget _searchBar() {
    return Row(children: [
      Expanded(
        flex: 1,
        child: Icon(Icons.search),
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
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
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
        ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return ListView.builder(
                itemCount: viewModel.rooms.length,
                itemBuilder: (BuildContext context, int index) {
                  return firendRow(viewModel.rooms[index], context);
                },
              );
            },
          )
        : ListView();
  }

  Widget firendRow(Room room, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MessagePageView(
                    friend: viewModel.friendWithID[room.id],
                    group: null,
                    isGroupChat: false,
                  )),
        );
      },
      child: Container(
          key: UniqueKey(),
          height: 60,
          child: Row(
            children: [
              Expanded(
                  flex: 2, child: FirendMessageHeadshotWidget(id: room.id)),
              Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      Container(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(room.name ?? "",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 20)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(room.lastMessage ?? "",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14)),
                      )
                    ],
                  )),
              Expanded(flex: 2, child: Container())
            ],
          )),
    );
  }
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
