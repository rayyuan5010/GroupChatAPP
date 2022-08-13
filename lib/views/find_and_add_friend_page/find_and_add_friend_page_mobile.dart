part of find_and_add_friend_page_view;

class _FindAndAddFriendPageMobile extends StatelessWidget {
  final FindAndAddFriendPageViewModel viewModel;

  _FindAndAddFriendPageMobile(this.viewModel);
  Faker faker = new Faker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          '加入好友',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      child: Column(
        children: [
          Container(
            child: functionBar(),
            height: 90,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  height: 60,
                  // color: Colors.red,
                  child: searchFriendByIDBar(),
                ),
                Expanded(
                  child: Container(
                    child: friendProfileView(),
                  ),
                  flex: 7,
                )
              ],
            ),
            flex: 8,
          ),
        ],
      ),
    );
  }

  Widget functionBar() {
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
              child: bigIconButtonWithLabel(
                  Icon(Icons.qr_code, size: 40), Text('QRCODE'))),
          Expanded(
              child: bigIconButtonWithLabel(
                  Icon(Icons.nfc, size: 40), Text('NFC'))),
        ],
      ),
    );
  }

  Widget bigIconButtonWithLabel(Icon icon, Text text) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: icon,
            flex: 8,
          ),
          text
        ],
      ),
    );
  }

  Widget searchFriendByIDBar() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(90)),
      child: Row(
        children: [
          Expanded(
            child: Icon(Icons.search),
            flex: 1,
          ),
          Expanded(
              child: Container(
                child: TextField(
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: new TextStyle(color: Colors.black, fontSize: 20.0),
                    decoration: InputDecoration(
                      fillColor: Colors.redAccent,
                      hintText: 'Search',
                      // hintStyle: new TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.all(10.0),
                      border: InputBorder.none,
                    )),
              ),
              flex: 6),
          Expanded(
              child: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {},
              ),
              flex: 1),
          Expanded(
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {},
              ),
              flex: 1)
        ],
      ),
    );
  }

  Widget friendProfileView() {
    return Container(
      // color: Colors.red,
      margin: EdgeInsets.all(30),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            child: CircleAvatar(
              maxRadius: 150.0,
              backgroundColor: Colors.blueGrey,
              backgroundImage: NetworkImage(faker.image.image()),
            ),
            flex: 5,
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            child: Text(
              '名稱名稱',
              style: TextStyle(fontSize: 30),
            ),
            flex: 3,
          ),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromWidth(200),
              ),
              onPressed: () {},
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 24),
              ),
            ),
            flex: 1,
          )
        ],
      ),
    );
  }

  Widget notfoundProfileView() {
    return Container(
      color: Colors.black,
      child: Text('456'),
    );
  }
}
