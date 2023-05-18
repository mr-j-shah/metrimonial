import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HappyStoriesDetails extends StatefulWidget {
  final data;

  const HappyStoriesDetails({this.data, Key key}) : super(key: key);

  @override
  State<HappyStoriesDetails> createState() => _HappyStoriesDetailsState();
}

class _HappyStoriesDetailsState extends State<HappyStoriesDetails> {
  var videoProvider;
  var videoLink;
  var src = "";

  // initial
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.data.videoLink);
    // print(widget.data.videoProvider);
    videoProvider = widget.data.videoProvider;
    videoLink = widget.data.videoLink;

    if ((videoLink != null) && (videoProvider) != null) {
      if (videoProvider == 'youtube') {
        var data = widget.data.videoLink.split("=");
        var video_link = "";
        // print(data.length);
        if (data.length > 1) {
          video_link = data[1];
        }
        src = "https://www.youtube.com/embed/$video_link";
      }

      if (videoProvider == 'dailymotion') {
        var video_link = widget.data.videoLink.split("video/")[1];

        src = "https://www.dailymotion.com/embed/video/$video_link";
      }
      if (videoProvider == 'vimeo') {
        var video_link = widget.data.videoLink.split("vimeo.com/")[1];

        src = "https://player.vimeo.com/video/$video_link";
      }
    }
  }

  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Const.kPaddingHorizontal, vertical: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: DeviceInfo(context).width,


                  /// image
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/342x200.png',
                      image: data.photos.first,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                ),
                Text(
                  data.title,
                  style: Styles.bold_arsenic_14,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(data.date, style: Styles.regular_gull_grey_10),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  data.details,
                  style: Styles.regular_arsenic_14,
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Container(
                    height: 400,
                    width: DeviceInfo(context).width,
                    child: WebView(
                      zoomEnabled: false,
                      navigationDelegate: (req) {
                        return NavigationDecision.prevent;
                      },
                      // TODO:: iframe issue

                      key: _key,
                      // initialUrl:
                      //state.myHappyStoryState.myHappyStoryCheckResponse.data.videoLink,
                      onWebViewCreated: (cc) {
                        // print(src);
                        //if(cc.loadUrl(store.state.myHappyStoryState.src).)
                        cc.loadHtmlString('''
                                <iframe src="${src}" style="height:600px; width : 1000px;" frameborder="0" allowfullscreen>></iframe>''');
                      },
                      javascriptMode: JavascriptMode.unrestricted,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        // padding: EdgeInsets.zero,
        // constraints: BoxConstraints(),
        icon: Image.asset(
          'assets/icon/icon_pop.png',
          height: 16,
        ),
      ),
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        AppLocalizations.of(context).happy_stories_details_appbar_title,
        style: Styles.bold_app_accent_16,
      ),
    );
  }
}
