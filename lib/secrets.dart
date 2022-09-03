import 'dart:io';

class Secret {
  static const ANDROID_CLIENT_ID =
      "280873140683-jvq8jt75lsj15ut0g29pu5kvs9p903o1.apps.googleusercontent.com";
  static const IOS_CLIENT_ID = "<enter your iOS client secret>";
  static String getId() =>
      Platform.isAndroid ? Secret.ANDROID_CLIENT_ID : Secret.IOS_CLIENT_ID;
}
