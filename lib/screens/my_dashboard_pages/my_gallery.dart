import 'dart:io';

import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_image/gallery_image_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_image/gallery_image_store_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:one_context/one_context.dart';

import '../../custom/full_screen_image_viewer.dart';

class MyGallery extends StatefulWidget {
  const MyGallery({Key key}) : super(key: key);

  @override
  State<MyGallery> createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  var _userName = prefs.getString(Const.userName);
  var _userEmail = prefs.getString(Const.userEmail);

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

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        store.dispatch(Reset.myGallery),
        store.dispatch(galleryImageMiddleware()),
      ],
      builder: (_, state) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () => store.dispatch(galleryImageMiddleware()),
          child: Column(
            children: [
              buildGradientBoxContainer(context, state),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        AppLocalizations.of(context)
                            .gallery_1_screen_featured_photos,
                        style: Styles.bold_arsenic_14,
                      ),
                    ),
                    Expanded(
                      child: state.galleryImageState.isFetching
                          ? Center(
                              child: CircularProgressIndicator(
                                color: MyTheme.storm_grey,
                              ),
                            )
                          : Container(
                              child: state.galleryImageState.galleryImageList
                                      .isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0, vertical: 10),
                                      child: MasonryGridView.count(
                                        padding: EdgeInsets.zero,
                                        itemCount: state.galleryImageState
                                            .galleryImageList.length,
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 12,
                                        crossAxisSpacing: 12,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FullScreenImageViewer(
                                                          state
                                                              .galleryImageState
                                                              .galleryImageList[
                                                                  index]
                                                              .imagePath),
                                                ),
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(16.0),
                                              ),
                                              child: Image.network(
                                                state
                                                    .galleryImageState
                                                    .galleryImageList[index]
                                                    .imagePath,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : const Center(
                                      child: Text('No Data Found'),
                                    ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGradientBoxContainer(BuildContext context, AppState state) {
    return Container(
      height: 200,
      width: DeviceInfo(context).width,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32.0),
              bottomRight: Radius.circular(32.0)),
          gradient: Styles.buildLinearGradient(
              begin: Alignment.topLeft, end: const Alignment(0.8, 1))),
      child: SafeArea(
        child: SizedBox(
          height: 170,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10.0),
                child: Column(
                  children: [
                    /// image name email and other more vertz field
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Image.asset(
                                'assets/icon/icon_pop_white.png',
                                height: 20,
                                width: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              radius: 25,
                              foregroundImage:
                                  state.accountState.profileData?.memberPhoto ==
                                          null
                                      ? const AssetImage(
                                          'assets/images/default_avater.png')
                                      : NetworkImage(state.accountState
                                          .profileData?.memberPhoto),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _userName,
                                  style: Styles.bold_white_14,
                                ),
                                Text(_userEmail, style: Styles.regular_white_12)
                              ],
                            )
                          ],
                        ),
                      ],
                    ),

                    /// horzontal line
                    Divider(
                      thickness: 1,
                      color: Colors.white.withOpacity(0.50),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 12),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/icon/icon_gallery.png',
                                    height: 16,
                                    width: 16,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                      state.accountState.profileData
                                          .remainingPhotoGallery
                                          .toString(),
                                      style: TextStyle(
                                          color: MyTheme.app_accent_color))
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              (state.accountState.profileData.currentPackageInfo
                                              .packageExpiry !=
                                          "Expired") &&
                                      state.accountState.profileData
                                              .remainingPhotoGallery !=
                                          0
                                  ? OneContext().showDialog(
                                      builder: (context) => AlertDialog(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)
                                                  .gallery_1_screen_add_new_image,
                                              style: Styles.bold_arsenic_14,
                                            ),
                                            IconButton(
                                              padding: EdgeInsets.zero,
                                              constraints: BoxConstraints(),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              icon: Image.asset(
                                                'assets/icon/icon_cross.png',
                                                height: 16,
                                                width: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                        content: InkWell(
                                          onTap: () {
                                            getImage();
                                          },
                                          child: Stack(children: [
                                            TextFormField(
                                              readOnly: true,
                                              decoration: InputStyle
                                                  .inputDecoration_text_field(
                                                      hint: _img_name != null
                                                          ? _img_name
                                                          : "Choose file"),
                                            ),
                                            Positioned(
                                              top: 5,
                                              bottom: 5,
                                              right: 5,
                                              child: TextButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                MyTheme.zircon),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  12),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  12),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  child: const Text('Browse')),
                                            )
                                          ]),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              store.dispatch(
                                                gallery_image_save(
                                                    photo: _image),
                                              );
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  gradient: Styles
                                                      .buildLinearGradient(
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(12))),
                                              padding: const EdgeInsets.all(14),
                                              child: Center(
                                                child: Text(
                                                  AppLocalizations.of(context)
                                                      .common_confirm,
                                                  style: const TextStyle(
                                                    color: MyTheme.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : MyScaffoldMessenger().sf_messenger(
                                      text: 'Please update your package');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                color: MyTheme.zircon,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 12),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/icon/icon_gallery_plus.png',
                                      height: 16,
                                      width: 16,
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'Add new image',
                                      style: TextStyle(
                                          color: MyTheme.app_accent_color),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
