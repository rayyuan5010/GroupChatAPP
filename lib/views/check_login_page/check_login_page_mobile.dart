part of check_login_page_view;

class _CheckLoginPageMobile extends StatelessWidget {
  final CheckLoginPageViewModel viewModel;

  _CheckLoginPageMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
        child: Column(
          children: [
            Spacer(flex: 2),
            Image.asset("assets/images/welcome_image.png"),
            Spacer(flex: 3),
            Text(
              "歡迎使用\n旅遊聊天室",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Row(children: [
              Spacer(),
              Container(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                  strokeWidth: 2,
                ),
                width: 30,
                height: 30,
              ),
              Container(width: 20),
              Text(
                "登入狀態檢查中",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .color
                      .withOpacity(0.64),
                ),
              ),
              Spacer(),
            ]),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
