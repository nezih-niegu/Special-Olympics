import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './screens/sports_screen.dart';
import './providers/sport_provider.dart';
import './screens/sport_screen.dart';
import './screens/manual_screen.dart';
import './providers/auth_provider.dart';
import './screens/state_screen.dart';
import './providers/state.provider.dart';
import './screens/coaches_screen.dart';
import './providers/coach_provider.dart';
import './screens/gallery_screen.dart';
import './providers/picture_provider.dart';
import './screens/create_user_screen.dart';
import './providers/user_provider.dart';
import './screens/login_screen.dart';
import './screens/manuals_screen.dart';
import './screens/user_screen.dart';
import './screens/edit_user_password_screen.dart';
import './screens/clubs_screen.dart';
import './providers/municipality_provider.dart';
import './providers/club_provider.dart';
import './screens/club_screen.dart';
import './screens/sessions_screen.dart';
import './providers/session_provider.dart';
import './screens/create_club_screen.dart';
import './screens/galleries_screen.dart';
import './screens/tabs_screen.dart';
import './providers/gallery_provider.dart';
import './providers/event_provider.dart';
import './screens/event_screen.dart';
import './screens/community_screen.dart';
import './screens/activities_screen.dart';
import './providers/activity_provider.dart';
import './screens/activity_screen.dart';
import './screens/volunteer_request_screen.dart';
import './providers/participant_provider.dart';
import './screens/testimonials_screen.dart';
import './providers/testimonial_porvider.dart';
import './screens/testimonial_screen.dart';
import './screens/athlete_request_screen.dart';
import './screens/programs_screen.dart';
import './providers/program_provider.dart';
import './screens/program_screen.dart';
import './screens/testimonial_categories_screen.dart';
import './screens/partner_request_screen.dart';
import './screens/family_request_screen.dart';
import './screens/volunteers_screen.dart';
import './screens/professional_request_screen.dart';
import './screens/coach_request_screen.dart';
import './screens/about_us_screen.dart';
import './screens/clubs_info_screen.dart';

void main(){
    // SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.portraitUp,
    //     DeviceOrientation.portraitDown
    // ]);

    runApp(SpecialOlympicsApp());
}

class SpecialOlympicsApp extends StatelessWidget{
    @override
    Widget build(BuildContext context){
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
        return MultiProvider(
            providers: [
                ChangeNotifierProvider.value(value: UserProvider()),
                ChangeNotifierProxyProvider<UserProvider, AuthProvider>(builder: (context, userProvider, _){
                    return AuthProvider(userProvider);
                }),
                ChangeNotifierProvider.value(value: SportProvider()),
                ChangeNotifierProvider.value(value: StateProvider()),
                ChangeNotifierProvider.value(value: CoachProvider()),
                ChangeNotifierProvider.value(value: PictureProvider()),
                ChangeNotifierProvider.value(value: MunicipalityProvider()),
                ChangeNotifierProvider.value(value: ClubProvider()),
                ChangeNotifierProvider.value(value: SessionProvider()),
                ChangeNotifierProvider.value(value: GalleryProvider()),
                ChangeNotifierProvider.value(value: EventProvider()),
                ChangeNotifierProvider.value(value: ActivityProvider()),
                ChangeNotifierProvider.value(value: ParticipantProvider()),
                ChangeNotifierProvider.value(value: TestimonialProvider()),
                ChangeNotifierProvider.value(value: ProgramProvider())
            ],
            child: Consumer<AuthProvider>(builder: (context, authProvider, _){
                return MaterialApp(
                    title: 'Special Olympics',
                    theme: ThemeData(
                        primarySwatch: Colors.red,
                        accentColor: Colors.grey.shade800,
                        textTheme: ThemeData.light().textTheme.copyWith(
                            headline1: TextStyle(
                                fontFamily: 'Ubuntu'
                            ),
                            headline2: TextStyle(
                                fontFamily: 'Ubuntu'
                            ),
                            headline3: TextStyle(
                                fontFamily: 'Ubuntu'
                            ),
                            headline4: TextStyle(
                                fontFamily: 'Ubuntu'
                            ),
                            headline5: TextStyle(
                                fontFamily: 'Ubuntu'
                            ),
                            overline: TextStyle(
                                fontFamily: 'Ubuntu'
                            ),
                            headline6: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                            subtitle1: TextStyle(
                                fontFamily: 'Ubuntu'
                            ),
                            subtitle2: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                            bodyText1: TextStyle(
                                fontFamily: 'Ubuntu'
                            ),
                            bodyText2: TextStyle(
                                fontFamily: 'Ubuntu',
                                color: Colors.grey.shade800,
                                fontSize: 20
                            ),
                            caption: TextStyle(
                                fontFamily: 'Ubuntu',
                                color: Colors.white,
                                fontSize: 18
                            ),
                            button: TextStyle(
                                fontFamily: 'Ubuntu',
                                color: Colors.white
                            )
                        )
                    ),
                    home: authProvider.isStateSet() ? TabsScreen() : FutureBuilder(
                        future: authProvider.tryAutoLogin(),
                        builder: (context, snapshot){
                            return snapshot.connectionState == ConnectionState.waiting ? Center(child: CircularProgressIndicator()) : StateScreen();
                        }
                    ),
                    routes: {
                        TabsScreen.routeName: (context) =>  TabsScreen(),
                        HomeScreen.routeName: (context) => HomeScreen(),
                        SportsScreen.routeName: (context) => SportsScreen(),
                        SportScreen.routeName: (context) => SportScreen(),
                        ManualScreen.routeName: (context) => ManualScreen(),
                        StateScreen.routeName: (context) => StateScreen(),
                        CoachesScreen.routeName: (context) => CoachesScreen(),
                        GalleryScreen.routeName: (context) => GalleryScreen(),
                        CreateUserScreen.routeName: (context) => CreateUserScreen(),
                        LoginScreen.routeName: (context) => LoginScreen(),
                        ManualsScreen.routeName: (context) => ManualsScreen(),
                        UserScreen.routeName: (context) => UserScreen(),
                        EditUserPasswordScreen.routeName: (context) => EditUserPasswordScreen(),
                        ClubsScreen.routeName: (context) => ClubsScreen(),
                        ClubScreen.routeName: (context) => ClubScreen(),
                        SessionsScreen.routeName: (context) => SessionsScreen(),
                        CreateClubScreen.routeName: (context) => CreateClubScreen(),
                        GalleriesScreen.routeName: (context) => GalleriesScreen(),
                        EventScreen.routeName: (context) => EventScreen(),
                        CommunityScreen.routeName: (context) => CommunityScreen(),
                        ActivitiesScreen.routeName: (context) => ActivitiesScreen(),
                        ActivityScreen.routeName: (context) =>  ActivityScreen(),
                        VolunteerRequestScreen.routeName: (context) => VolunteerRequestScreen(),
                        TestimonialsScreen.routeName: (context) => TestimonialsScreen(),
                        TestimonialScreen.routeName: (context) => TestimonialScreen(),
                        AthleteRequestScreen.routeName: (context) => AthleteRequestScreen(),
                        ProgramsScreen.routeName: (context) => ProgramsScreen(),
                        ProgramScreen.routeName: (context) => ProgramScreen(),
                        TestimonialCategoriesScreen.routeName: (context) => TestimonialCategoriesScreen(),
                        PartnerRequestScreen.routeName: (context) => PartnerRequestScreen(),
                        FamilyRequestScreen.routeName: (context) => FamilyRequestScreen(),
                        VolunteersScreen.routeName: (context) => VolunteersScreen(),
                        ProfessionalRequestScreen.routeName: (context) => ProfessionalRequestScreen(),
                        CoachRequestScreen.routeName: (context) => CoachRequestScreen(),
                        AboutUsScreen.routeName: (context) => AboutUsScreen(),
                        ClubsInfoScreen.routeName: (context) => ClubsInfoScreen()
                    }
                );
            })
        );
    }
}