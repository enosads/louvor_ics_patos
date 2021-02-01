import 'package:url_launcher/url_launcher.dart';

class  UrlLaunch {
  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }else{
      print('erro');
    }
  }
}
