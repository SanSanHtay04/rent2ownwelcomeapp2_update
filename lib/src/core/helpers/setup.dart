import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/core/data/repositories/common_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<SingleChildWidget>> globalProviders() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  final prefsStore = PrefsStore(sharedPrefs);
  final localAuthProvider = LocalAuthProvider(prefsStore);
  ApiClient.initialize(localAuthProvider);

  final commonService = CommonService();
  final miscService = MiscService();

  final authRepo = AuthRepository(api: AuthService(), prefsStore: prefsStore);
  final miscRepo = MiscRepository(api: miscService);
  final commonRepo = CommonRepository(api: commonService);

  return [
    Provider.value(value: prefsStore),
    Provider.value(value: miscService),
    Provider.value(value: commonService),
    Provider.value(value: authRepo),
    Provider.value(value: miscRepo),
    Provider.value(value: commonRepo),
    ChangeNotifierProvider.value(value: localAuthProvider),
    //ChangeNotifierProvider(create: (context)=> LocalAuthProvider(prefsStore )),
  ];
}
