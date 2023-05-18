class SignInState {
  bool isLogin;
  bool isCustomLogin;
  bool isPhoneOrEmail;
  var phoneNumber;
  bool isObscure;

  SignInState({
    this.isLogin,
    this.isPhoneOrEmail,
    this.isObscure,
    this.isCustomLogin,
  });

  SignInState.initialState()
      : isPhoneOrEmail = false,
        isObscure = true,
        isCustomLogin = false,
        isLogin = false;
}
