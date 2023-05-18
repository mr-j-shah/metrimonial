class PublicProfileState {
  bool isFetching;

  var intro;
  var basic;
  var presentaddress;
  var permanentaddress;
  var education;
  var career;
  var physical;
  var language;
  var mothertongue;
  var hobbies;
  var attitude;
  var resi;
  var spiritual;
  var lifestyle;
  var astrologies;
  var families;
  var partner;
  List photogallery = [];
  var profilematch;
  var contact;
  String error;

  var viewContactCheck;

  PublicProfileState.initialState()
      : isFetching = true,
        error = '',
        photogallery = [];

  PublicProfileState({
    this.isFetching,
    this.intro,
    this.basic,
    this.presentaddress,
    this.permanentaddress,
    this.education,
    this.error,
    this.career,
    this.viewContactCheck,
    this.physical,
    this.language,
    this.mothertongue,
    this.hobbies,
    this.attitude,
    this.resi,
    this.spiritual,
    this.lifestyle,
    this.astrologies,
    this.families,
    this.partner,
    this.photogallery,
    this.profilematch,
  });
}
