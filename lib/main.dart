import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/Auth_Screen/WelcomeScreen.dart';
import 'package:project1/Auth_Screen/auth_cubit/auth_cubit.dart';
import 'package:project1/Auth_Screen/loginScreen.dart';
import 'package:project1/Layout_Screen/layoutScreen.dart';
import 'package:project1/Layout_Screen/layout_cubit/layout_cubit.dart';
import 'package:project1/Layout_Screen/new_entery_bloc.dart';
import 'package:project1/Shared/bloc_observer/bloc_observer.dart';
import 'package:project1/Shared/network/local_network.dart';
import 'package:project1/firebase_options.dart';
import 'package:project1/global_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  await CacheNetwork.cacheInit();

  Widget widget;

  var uId = CacheNetwork.GetCacheDate(key: 'uId');

  if (uId != null) {
    widget = Layoutscreen();
  } else {
    widget = WelcomeScreen();
  }

  runApp(MyApp(
    widget,
  ));
}

class MyApp extends StatefulWidget {
  MyApp(Widget widget,);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalBloc? globalBloc;

  @override
  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc!,
      child: Sizer(builder: (context, orintation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AuthCubit()),
            BlocProvider(create: (context) => LayoutCubit()..getUserData()),
          ],
          child: MaterialApp(
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                toolbarHeight: 7.h,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Color(0xffB81736),
                  size: 30,
                ),
              ),
              textTheme: TextTheme(
                headlineMedium: GoogleFonts.aBeeZee(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
                titleSmall: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.black,
                ),
                labelLarge: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              timePickerTheme: TimePickerThemeData(
                  dayPeriodColor: Color(0xffB81736),
                  dialBackgroundColor: Color(0xff281537),
                  dialTextColor: Colors.white),
            ),
            debugShowCheckedModeBanner: false,
            home: widget,
          ),
        );
      }),
    );
  }
}
