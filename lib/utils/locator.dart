import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingletonAsync<SharedPreferences>(() async {
    final shared = await SharedPreferences.getInstance();
    return shared;
  });

  // locator.registerLazySingleton(() => BlocProvider(
  //   create: (context) => SignInCubit(),
  //   child: SignInPage(),
  // ));
}
