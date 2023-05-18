import 'package:active_matrimonial_flutter_app/custom/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/gallery_picture_view_card.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_picture_view_request/gallery_picture_view_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_picture_view_request/gallery_picture_view_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_picture_view_request/gallery_picture_view_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_context/one_context.dart';

import '../../helpers/device_info.dart';

class GalleryProfileViewRqst extends StatefulWidget {
  const GalleryProfileViewRqst({Key key}) : super(key: key);

  @override
  State<GalleryProfileViewRqst> createState() => _GalleryProfileViewRqstState();
}

class _GalleryProfileViewRqstState extends State<GalleryProfileViewRqst> {
  ScrollController scrollController = ScrollController();
  ScrollController _xcrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    store.dispatch(GalleryPictureViewReset());
    store.dispatch(getGalleryPictureViewRequestMiddleware());

    _xcrollController.addListener(() {
      if (_xcrollController.position.maxScrollExtent ==
          _xcrollController.offset) {
        var page = store.state.galleryPictureViewState.page += 1;
        print("########$page");
        store.dispatch(getGalleryPictureViewRequestMiddleware(page: page));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    _xcrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        onWillChange: (_ViewModel prev, _ViewModel current) {
          if (prev.status == GalleryStatus.failure) {
            OneContext().showDialog(
                builder: (context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text(current.error),
                  );
                });
          }
        },
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (_, _ViewModel vm) {
          return Scaffold(
            appBar: CommonAppBar(
                    text: AppLocalizations.of(context)
                        .gallery_picture_screen_appbar_title)
                .build(context),
            body: RefreshIndicator(
              onRefresh: () async {
                store.dispatch(GalleryPictureViewReset());
                store.dispatch(getGalleryPictureViewRequestMiddleware());
              },
              child: SingleChildScrollView(
                controller: _xcrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: body(context, vm)),
            ),
          );
        });
  }

  Widget body(BuildContext maincontext, _ViewModel vm) {
    // if (vm.status == GalleryStatus.initial) {
    //   return Container();
    // }
    if (vm.showLoading) {
      return Container(
        height: DeviceInfo(context).height,
        child: Center(
          child: CircularProgressIndicator(
            color: MyTheme.storm_grey,
          ),
        ),
      );
    }
    return SizedBox(
      height: DeviceInfo(context).height,
      child: vm.listofdata.isEmpty
          ? Center(child: Text('No Request Found.'))
          : ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              controller: scrollController,
              itemCount: vm.listofdata.length + 1,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 14,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (index == vm.listofdata.length && !vm.noMoreData) {
                  return Container(
                    width: DeviceInfo(context).width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 1, width: 1),
                        CircularProgressIndicator(
                          color: MyTheme.storm_grey,
                        ),
                      ],
                    ),
                  );
                } else if (index == vm.listofdata.length && vm.noMoreData) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text('No more data'),
                    ),
                  );
                }
                return GalleryPictureViewCard(
                  index: index,
                  id: vm.listofdata[index].id,
                  name: vm.listofdata[index].name,
                  image: vm.listofdata[index].photo,
                  status: vm.listofdata[index].status,
                  age: vm.listofdata[index].dateOfBirth,
                );
              },
            ),
    );
  }
}

class _ViewModel {
  var listofdata;
  var status;
  var error;

  @override
  String toString() {
    return '_ViewModel{listofdata: $listofdata, status: $status, error: $error, showLoading: $showLoading, noMoreData: $noMoreData}';
  }

  var showLoading;
  var noMoreData;

  _ViewModel(
      {this.noMoreData,
      this.listofdata,
      this.status,
      this.error,
      this.showLoading});

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      listofdata: store.state.galleryPictureViewState.galleryPictureViewList,
      status: store.state.galleryPictureViewState.galleryStatus,
      error: store.state.galleryPictureViewState.error,
      showLoading: store.state.galleryPictureViewState.showLoading,
      noMoreData: store.state.galleryPictureViewState.noMoreData,
    );
  }
}
