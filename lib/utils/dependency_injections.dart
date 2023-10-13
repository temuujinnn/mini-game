// Global locator
import 'package:appwrite/appwrite.dart';

import 'package:get_it/get_it.dart';
import 'package:mini_app/repository/appwrite_repo.dart';

final get = GetIt.I;

// Register all dependencies
Future<void> configure() async {
  try {
    /// Register Appwrite client
    get.registerSingleton<Client>(
      Client()
          .setEndpoint('https://cloud.appwrite.io/v1')
          .setProject('6527c7a0508dfd0262f1')
          .setSelfSigned(status: true),
    );

    /// Register Appwrite account
    get.registerSingleton<Account>(Account(get.get<Client>()));

    /// Register Realtime client
    get.registerSingleton<Realtime>(Realtime(get.get<Client>()));

    /// Database
    get.registerSingleton<Databases>(Databases(get.get<Client>()));

    // / home repository
    get.registerSingleton<AppwriteRepo>(AppwriteRepo());
  } catch (e) {
    print(e);
    rethrow;
  }
}
