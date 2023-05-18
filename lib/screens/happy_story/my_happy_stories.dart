import 'dart:io';

import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/my_happy_story/get_happy_story_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/my_happy_story/post_happy_story_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyHappyStories extends StatefulWidget {
  const MyHappyStories({Key key}) : super(key: key);

  @override
  State<MyHappyStories> createState() => _MyHappyStoriesState();
}

class _MyHappyStoriesState extends State<MyHappyStories> {
  WebViewController controller;

  // country
  var video_provider = ['Youtube', 'Dailymotion', 'Vimeo'];
  var video_provider_value = 'Youtube';

  @override
  void initState() {
    super.initState();

    store.dispatch(happyStoryCheckMiddleware());
  }

  final _formKey = GlobalKey<FormState>();

  quill.QuillController _controller = quill.QuillController.basic();

  TextEditingController _story_titleController = TextEditingController();
  TextEditingController _story_partnerNameController = TextEditingController();

  // TextEditingController _story_videoProviderController =
  //     TextEditingController();
  TextEditingController _story_videoLinkController = TextEditingController();
  var videoProvider = store.state.myHappyStoryState.result == false
      ? null
      : store.state.myHappyStoryState.myHappyStory.videoProvider;

  //for image uploading
  ImagePicker _picker = ImagePicker();
  File _image;
  var _img_name;

  Future getImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporay = File(image.path);

      setState(() {
        _image = imageTemporay;
        _img_name = imageTemporay.path.split('/').last;
      });
    } on PlatformException catch (e) {
      print("Failed to pick Image: $e");
    }
  }

  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      onInit: (store) {
        if (videoProvider != null) {
          if (videoProvider == 'youtube') {
            var data =
                store.state.myHappyStoryState.myHappyStory.videoLink.split("=");
            var video_link = "";
            // print(data.length);
            if (data.length > 1) {
              video_link = data[1];
            }

            store.state.myHappyStoryState.src =
                "https://www.youtube.com/embed/$video_link";
          }
          if (videoProvider == 'dailymotion') {
            var video_link = store
                .state.myHappyStoryState.myHappyStory.videoLink
                .split("video/")[1];

            store.state.myHappyStoryState.src =
                "https://www.dailymotion.com/embed/video/$video_link";
          }
          if (videoProvider == 'vimeo') {
            var video_link = store
                .state.myHappyStoryState.myHappyStory.videoLink
                .split("vimeo.com/")[1];

            store.state.myHappyStoryState.src =
                "https://player.vimeo.com/video/$video_link";
          }
        }
        ;
      },
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: buildAppBar(context),
        body: state.myHappyStoryState.result
            ? buildSingleChildScrollViewForData(context, state)
            : buildSingleChildScrollViewForForm(context, state),
      ),
    );
  }

  Widget buildSingleChildScrollViewForForm(
      BuildContext context, AppState state) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Const.kPaddingHorizontal, vertical: 11),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildHappyStoriesFormContainer(context, _formKey, state)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSingleChildScrollViewForData(
      BuildContext context, AppState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Const.kPaddingHorizontal, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: DeviceInfo(context).width,
                height: 170,

                /// image
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  child: Image.network(
                    state.myHappyStoryState.myHappyStory.photos.first,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                state.myHappyStoryState.myHappyStory.title,
                style: Styles.bold_arsenic_14,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(state.myHappyStoryState.myHappyStory.date,
                  style: Styles.regular_gull_grey_10),
              const SizedBox(
                height: 10,
              ),
              Text(
                state.myHappyStoryState.myHappyStory.details,
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
                      // print(store.state.myHappyStoryState.src);
                      //if(cc.loadUrl(store.state.myHappyStoryState.src).)
                      cc.loadHtmlString('''
                              <iframe src="${store.state.myHappyStoryState.src}" style="height:600px; width : 1000px;" frameborder="0" allowfullscreen>></iframe>''');
                    },
                    javascriptMode: JavascriptMode.unrestricted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHappyStoriesFormContainer(
      BuildContext context, _f_key, AppState state) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).happy_stories_form_sub_title,
            style: Styles.bold_app_accent_14,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            AppLocalizations.of(context).happy_stories_form_story_title + " *",
            style: Styles.bold_arsenic_12,
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: _story_titleController,
            decoration: InputStyle.inputDecoration_text_field(hint: "Title"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Title required";
              }
            },
          ),
          SizedBox(
            height: 20,
          ),

          Text(AppLocalizations.of(context).happy_stories_form_story_details,
              style: Styles.bold_arsenic_12),
          SizedBox(
            height: 5,
          ),
          quill.QuillToolbar.basic(
            controller: _controller,
            showFontFamily: false,
            showSearchButton: false,
            showIndent: false,
            showHeaderStyle: false,
            showListBullets: true,
            showColorButton: false,
            showFontSize: false,
            showQuote: false,
            showInlineCode: false,
            showLink: false,
            showCodeBlock: false,
            showListCheck: false,
            showDividers: true,
            showClearFormat: false,
            showStrikeThrough: false,
            toolbarSectionSpacing: 0,
            showBackgroundColorButton: false,
            showUnderLineButton: false,
            // showImageButton: false,
            // showVideoButton: false,
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(
                color: MyTheme.solitude,
                borderRadius: BorderRadius.circular(12)),
            child: quill.QuillEditor.basic(
              controller: _controller,
              readOnly: false, // true for view only mode
            ),
          ),

          /// partner name
          SizedBox(
            height: 15,
          ),
          Text(
            AppLocalizations.of(context).happy_stories_form_partner_name + " *",
            style: Styles.bold_arsenic_12,
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: _story_partnerNameController,
            decoration:
                InputStyle.inputDecoration_text_field(hint: "Partner Name"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Partner Name required";
              }
            },
          ),

          /// photos upload
          SizedBox(
            height: 15,
          ),
          Text(
            AppLocalizations.of(context).happy_stories_form_photos + " *",
            style: Styles.bold_arsenic_12,
          ),
          SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () {
              getImage();
            },
            child: Stack(children: [
              TextFormField(
                readOnly: true,
                decoration: InputStyle.inputDecoration_text_field(
                    hint: _img_name != null ? _img_name : "Choose file"),
              ),
              Positioned(
                top: 5,
                bottom: 5,
                right: 5,
                child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(MyTheme.zircon),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    // onPressed: () {
                    //   getImage();
                    // },
                    child: Text('Browse')),
              )
            ]),
          ),

          /// video provider
          SizedBox(
            height: 15,
          ),
          Text(
            AppLocalizations.of(context).happy_stories_form_video_provider,
            style: Styles.bold_arsenic_12,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: MyTheme.solitude),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonFormField(
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Required field";
                  }
                  return null;
                },
                iconSize: 0.0,
                decoration: InputDecoration(
                  hintText: "Select One",
                  isDense: true,
                  hintStyle: Styles.regular_gull_grey_12,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: MyTheme.gull_grey,
                  ),
                  // helperText: 'Helper text',
                ),
                value: video_provider_value,
                items: video_provider.map<DropdownMenuItem<dynamic>>((e) {
                  return DropdownMenuItem<dynamic>(
                    value: e,
                    child: Text(
                      e,
                    ),
                  );
                }).toList(),
                onChanged: (dynamic newValue) {
                  setState(() {
                    video_provider_value = newValue;
                  });
                }),
          ),

          ///video link
          SizedBox(
            height: 15,
          ),
          Text(
            AppLocalizations.of(context).happy_stories_form_video_link,
            style: Styles.bold_arsenic_12,
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: _story_videoLinkController,
            decoration:
                InputStyle.inputDecoration_text_field(hint: "Video link"),
          ),
          SizedBox(
            height: 40,
          ),

          state.myHappyStoryState.happyloader == false
              ? InkWell(
                  onTap: () {
                    if (!_formKey.currentState.validate()) {
                      MyScaffoldMessenger()
                          .sf_messenger(text: "Form's not validated!");
                    } else {
                      store.dispatch(happystorystoreMiddleware(
                        context: context,
                        title: _story_titleController.text,
                        details: _controller.document.toPlainText(),
                        partner_name: _story_partnerNameController.text,
                        photos: _image,
                        video_provider: video_provider_value,
                        video_link: _story_videoLinkController.text,
                      ));

                      store.dispatch(happyStoryCheckMiddleware());
                    }
                  },
                  child:
                      CommonWidget.manage_profile_update_box(context: context))
              : Center(
                  child: CircularProgressIndicator(
                    color: MyTheme.storm_grey,
                  ),
                ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(),
        icon: Image.asset(
          'assets/icon/icon_pop.png',
          height: 16,
          width: 23,
        ),
      ),
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        AppLocalizations.of(context).my_happy_stories_appbar_title,
        style: Styles.bold_arsenic_16,
      ),
    );
  }
}
