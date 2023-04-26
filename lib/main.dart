import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:training_app/ui/onBoarding/onboarding_screen.dart';
import 'package:training_app/ui/splash_screen.dart';
import 'package:training_app/ui/student/chatbot_screen.dart';
import 'package:training_app/ui/student/search_screen.dart';
import 'package:training_app/ui/training_organization/main_organization_screen.dart';
import 'package:training_app/ui/training_organization/organization_edit_profile.dart';
import 'package:training_app/ui/training_unit/training_main_screen.dart';
import 'package:training_app/ui/training_unit/unit_home_screen.dart';
import 'controllers/shared_preference_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'ui/student/profile/profile_screen.dart';
import 'ui/test.dart';
import 'ui/training_organization/profile_organization.dart';
import 'ui/training_unit/add_new_company.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.int();
  //GoogleMap.init('YOUR_API_KEY');
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<LanguageModel>(
      create: (context) => LanguageModel(const Locale('ar')),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _currentLocale = Locale('ar');

  // void _changeLanguage() {
  //   setState(() {
  //     _currentLocale = _currentLocale == Locale('er') ? Locale('en') : Locale('er');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageModel>(
      create: (_) => LanguageModel(const Locale('ar')),
      child: Builder(builder: (context) {
        return MaterialApp(
          locale: Provider.of<LanguageModel>(context).locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('ar'),
          ],
          title: 'Netrn',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home: ProfileScreen(),
          //  home: AddNewCompany(),
          //  home: AddNewCompany(),
           home: SearchScreen(),
        );
      }),
    );
  }
}

class LanguageModel with ChangeNotifier {
  Locale _locale;

  LanguageModel(this._locale);

  Locale get locale => _locale;

  void changeLanguage(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
