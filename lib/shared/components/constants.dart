import 'package:social/modules/login/login_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/network/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(
    key: 'uId',
  ).then((value) {
    if (value) {
      navigateAndFinish(
        context,
        const LoginScreen(),
      );
    }
  });
}

String? uId;
