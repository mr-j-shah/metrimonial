class GalleryImageState {
  bool isLoading;
  bool isFetching;
  String error;
  List galleryImageList = [];

  GalleryImageState({
    this.isFetching,
    this.error,
    this.galleryImageList,
    this.isLoading,
  });

  GalleryImageState.initialState()
      : isFetching = true,
        galleryImageList = [],
        error = '',
        isLoading = false;
}
