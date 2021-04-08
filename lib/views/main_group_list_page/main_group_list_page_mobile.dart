part of main_group_list_page_view;

class _MainGroupListPageMobile extends StatelessWidget {
  final MainGroupListPageViewModel viewModel;

  _MainGroupListPageMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                    height: constraints.maxHeight / 100 * 10, child: _myInfo()),
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
    )));
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
              flex: 6,
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
            flex: 2,
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {}, child: Icon(FontAwesomeIcons.bell, size: 20)),
                Container(
                  width: 10,
                ),
                GestureDetector(
                    onTap: () {},
                    child: Icon(FontAwesomeIcons.userPlus, size: 20)),
                Container(
                  width: 10,
                ),
                GestureDetector(
                    onTap: () {}, child: Icon(FontAwesomeIcons.cog, size: 20)),
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
        flex: 6,
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
                hintText: "Hint here")),
      ),
      Expanded(
        flex: 3,
        child: MaterialButton(
          onPressed: () {},
          child: Text('add Firend'),
        ),
      )
    ]);
  }

  Widget _listView() {
    return viewModel.controller.text == ""
        ? CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: SectionHeaderDelegate("好友"),
                pinned: true,
              ),
              SliverAnimatedList(
                key: UniqueKey(),
                initialItemCount: 80,
                itemBuilder: (BuildContext context, int index,
                    Animation<double> animation) {
                  var faker = new Faker();

                  return Container(
                      height: 60,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: CircleAvatar(
                                maxRadius: 25.0,
                                backgroundColor: Colors.blueGrey,
                                backgroundImage:
                                    NetworkImage(faker.image.image()),
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
                },
              ),
              SliverPersistentHeader(
                delegate: SectionHeaderDelegate("群組"),
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: Text('list2'),
              ),
            ],
          )
        : ListView();
  }
}

class SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final double height;

  SectionHeaderDelegate(this.title, [this.height = 50]);

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).primaryColor,
      alignment: Alignment.center,
      child: Text(title),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
