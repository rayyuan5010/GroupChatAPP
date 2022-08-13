part of main_page_root_view;

class _MainPageRootMobile extends StatelessWidget {
  final MainPageRootViewModel viewModel;

  _MainPageRootMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: viewModel.controller,
        itemCount: viewModel.pages.length,
        itemBuilder: (BuildContext context, int index) {
          return viewModel.pages[index];
        },
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Theme.of(context).backgroundColor,
        selectedIndex: viewModel.currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) {
          viewModel.currentIndex = index;
          viewModel.notifyListeners();
          viewModel.controller.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('首頁'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text('聊天'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(
              FontAwesomeIcons.solidUser,
              size: 19,
            ),
            title: Text(
              '個人資訊',
            ),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('設定'),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
