part of firend_message_headshot_widget;

class _FirendMessageHeadshotMobile extends StatefulWidget {
  _FirendMessageHeadshotMobile({@required this.id, @required this.size});
  final double size;
  final String id;
  @override
  State<_FirendMessageHeadshotMobile> createState() =>
      _FirendMessageHeadshotMobileState();
}

class _FirendMessageHeadshotMobileState
    extends State<_FirendMessageHeadshotMobile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: NetWorkAPI.checkFirendHeadShot(widget.id, refresh: () {
          setState(() {});
        }),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot<APIReturn> snapshot) {
          if (snapshot.connectionState != ConnectionState.done ||
              snapshot.data == null) {
            if (Config.friendCache.containsKey(widget.id)) {
              File file = Config.getHeadShot(
                  widget.id, Config.friendCache[widget.id].image);

              if (file.existsSync()) {
                return CircleAvatar(
                  maxRadius: widget.size,
                  backgroundImage: Image.file(file).image,
                );
              } else {
                return CircleAvatar(
                  maxRadius: widget.size,
                  backgroundColor: Colors.blueGrey,
                  child: Icon(FontAwesomeIcons.user),
                );
              }
            } else {
              return CircleAvatar(
                maxRadius: widget.size,
                backgroundColor: Colors.blueGrey,
                child: Icon(FontAwesomeIcons.user),
              );
            }
          } else {
            File file = Config.getHeadShot(widget.id, snapshot.data.data);

            if (snapshot.data.data != null && file.existsSync()) {
              return CircleAvatar(
                  maxRadius: widget.size,
                  backgroundImage: Image.file(file).image);
            } else {
              if (snapshot.data.data == null) {
                return CircleAvatar(
                  maxRadius: widget.size,
                  backgroundColor: Colors.blueGrey,
                  child: Icon(FontAwesomeIcons.user),
                );
              } else {
                return CircleAvatar(
                    maxRadius: widget.size,
                    backgroundImage:
                        Image.network('/file/image/headshot?i=${widget.id}')
                            .image);
              }
            }

            // return
            //     ? ,
            //       )
            //     : CircleAvatar(
            //         maxRadius: widget.size,
            //         backgroundColor: Colors.blueGrey,
            //         child: Icon(FontAwesomeIcons.user),
            //       );
          }
        });
  }

  refrestPage() {
    setState(() {});
  }
}
