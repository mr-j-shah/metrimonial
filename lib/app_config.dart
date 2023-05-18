var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text = "@ VALIDATE " + this_year;
  static String app_name = "VALIDATE";

  // enter string purchase_code here
  static String purshase_code = '310cbf73-fd79-401d-b443-46e5777afdec';

  // configure this
  static const bool HTTPS = true;

  //configure this

  static const DOMAIN_PATH = "validateu.com";

  // do not configure these below
  static const String API_ENDPATH = "api";
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  static const String BASE_URL = "${RAW_BASE_URL}/${API_ENDPATH}";
}
