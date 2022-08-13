part of headshot_preview_page_view;

class _HeadshotPreviewPageMobile extends StatelessWidget {
  final HeadshotPreviewPageViewModel viewModel;

  _HeadshotPreviewPageMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    print(
        "${Config.apiURL('/file/image/headshot?i=${Authentication.user.id}&f=${Authentication.user.image}')}");
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 10,
          ),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  width: 50,
                  height: 50,
                  child: InkWell(
                    child: Icon(
                      Icons.close,
                      size: 30,
                    ),
                    onTap: () {
                      locator<NavigatorService>().pop(
                          locator<NavigatorService>()
                              .navigatorKey
                              .currentContext);
                      // Logger().d("123");
                    },
                  )),
              Spacer(),
              InkWell(
                onTap: () {
                  viewModel.is_pick_dialog = true;
                  viewModel.notifyListeners();
                  showDialog<void>(
                      context: context,
                      builder: (context) => UnconstrainedBox(
                            constrainedAxis: Axis.vertical,
                            child: SizedBox(
                              width: 150,
                              child: Dialog(
                                insetPadding: EdgeInsets.zero,
                                child: Container(
                                  height: 200,
                                  color: Theme.of(context).backgroundColor,
                                  child: Column(
                                    children: [
                                      Container(height: 20),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 40,
                                          child: Text(
                                            '開啟相機',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Container(height: 20),
                                      InkWell(
                                        onTap: () =>
                                            viewModel.openImagePicker(context),
                                        child: Container(
                                          height: 40,
                                          child: Text(
                                            '選擇照片',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Container(height: 20),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 40,
                                          child: Text(
                                            '刪除照片',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: Theme.of(context).iconTheme.color),
                      borderRadius: BorderRadius.all(Radius.circular(20))),

                  // color: Colors.red,
                  width: 90,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                      Expanded(
                        flex: 2,
                        child: Icon(Icons.camera_alt_outlined),
                      ),
                      Expanded(
                        child: Container(),
                        flex: 2,
                      ),
                      Expanded(flex: 5, child: Text('編輯'))
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            // flex: 9,
            child: Center(
              child: Authentication.user.image.isEmpty
                  ? Icon(
                      Icons.photo,
                      size: 200,
                    )
                  : CachedNetworkImage(
                      imageUrl:
                          "${Config.apiURL('/file/image/headshot?i=${Authentication.user.id}&f=${Authentication.user.image}')}",
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
            ),
          )
        ],
      )),
    );
  }
}
