import '../database/account.dart';
import '../database/method.dart';
import '../pages/home.dart';

class CurrentUserApplication {
  static Future<Account> get currentUserApplication async =>
      await getUser(currentUser.id);
}
