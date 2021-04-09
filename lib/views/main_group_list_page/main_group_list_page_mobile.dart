part of main_group_list_page_view;

class _MainGroupListPageMobile extends StatelessWidget {
  final MainGroupListPageViewModel viewModel;

  _MainGroupListPageMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                      height: constraints.maxHeight / 100 * 10,
                      child: _myInfo()),
                  Container(
                    height: constraints.maxHeight / 100 * 5,
                    child: Container(
                      height: 40,
                      child: _searchBar(),
                    ),
                  ),
                  Container(
                      height: constraints.maxHeight / 100 * 82,
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
              child: CircleAvatar(
                maxRadius: 30.0,
                backgroundColor: Colors.blueGrey,
                child: Icon(FontAwesomeIcons.user),
              )),
          Expanded(
              flex: 5,
              child: Column(
                children: [
                  Container(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Rayyuan',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Rayyuan',
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
                GestureDetector(
                    onTap: () {},
                    child: Icon(FontAwesomeIcons.solidBell, size: 20)),
                Spacer(),
                GestureDetector(
                    onTap: () {},
                    child: Icon(FontAwesomeIcons.userPlus, size: 20)),
                Spacer(),
                GestureDetector(
                    onTap: () {}, child: Icon(FontAwesomeIcons.cog, size: 20)),
                Spacer(),
              ],
            ),
          )
        ],
      ),
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
              return CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: SectionHeaderDelegate("好友"),
                    pinned: true,
                  ),
                  SliverAnimatedList(
                    initialItemCount: 30,
                    itemBuilder: (BuildContext context, int index,
                        Animation<double> animation) {
                      Faker faker = new Faker();
                      return firendRow(faker);
                    },
                  ),
                  SliverPersistentHeader(
                    delegate: SectionHeaderDelegate("群組"),
                    pinned: true,
                  ),
                  SliverAnimatedList(
                    initialItemCount: 30,
                    itemBuilder: (BuildContext context, int index,
                        Animation<double> animation) {
                      Faker faker = new Faker();
                      return firendRow(faker);
                    },
                  )
                ],
              );
            },
          )
        : ListView();
  }

  Widget firendRow(Faker faker) {
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
                  backgroundImage: NetworkImage(faker.image.image()),
                )),
            Expanded(
                flex: 6,
                child: Column(
                  children: [
                    Container(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(faker.person.name(),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 20)),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(faker.conference.name(),
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
}

class SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final double height;

  SectionHeaderDelegate(this.title, {this.height = 50});

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
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
