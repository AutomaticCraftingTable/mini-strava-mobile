import 'package:go_router/go_router.dart';
import 'package:project_strava/components/main_shell.dart';
import 'package:project_strava/pages/Auth/forgot_password_page.dart';
import 'package:project_strava/pages/Auth/login_in_page.dart';
import 'package:project_strava/pages/Auth/landing_page.dart';
import 'package:project_strava/pages/profile_page.dart';
import '../pages/Auth/sign_up_page.dart';
import 'app_transition.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'landing',
        pageBuilder: (context, state) =>
            AppTransition.fade(state, const LandingPage()),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) =>
            AppTransition.fade(state, const LoginPage()),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        pageBuilder: (context, state) =>
            AppTransition.fade(state, const SignUpPage()),
      ),
      GoRoute(
        path: '/main',
        name: 'main',
        pageBuilder: (context, state) =>
            AppTransition.fade(state, const MainShell()),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        pageBuilder: (context, state) =>
            AppTransition.fade(state, const ProfilePage()),
      ),
      GoRoute(
        path: '/forgot',
        name: 'forgot',
        pageBuilder: (context, state) =>
            AppTransition.fade(state, const ForgotPasswordPage()),
      ),
    ],
  );
}
