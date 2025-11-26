import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static const supportedLocales = [
    Locale('pl'),
    Locale('en'),
  ];

  static const _values = <String, Map<String, String>>{
    'pl': {
      // Общие
      'app_title': 'Moja aktywność',

      // RecordPage
      'record_new_activity': 'Nowa aktywność',
      'record_duration': 'Czas trwania',
      'record_distance': 'Dystans',
      'record_pace': 'Tempo',
      'record_speed': 'Prędkość',
      'record_start': 'Rozpocznij',
      'record_pause': 'Wstrzymaj',
      'record_resume': 'Kontynuuj',
      'record_finish': 'Zakończ',
      'record_saved':'Aktywnosz zapisana',

      // Bottom nav
      'nav_record': 'Record',
      'nav_history': 'Historia',
      'nav_group': 'Grupa',
      'nav_you': 'Ty',

      // Historia
      'history_title': 'Historia aktywności',
      'history_empty': 'Brak zapisanych aktywności',
      'history_empty_filter': 'Brak aktywności dla wybranego filtra',

      // Filtry
      'filter_all': 'Wszystkie',
      'filter_run': 'Bieg',
      'filter_ride': 'Rower',
      'filter_walk': 'Spacer',

      // Sortowanie
      'sort_title': 'Sortowanie',
      'sort_newest': 'Najnowsze',
      'sort_oldest': 'Najstarsze',
      'sort_longest': 'Najdłuższy dystans',
      'sort_shortest': 'Najkrótszy dystans',

      // YouPage
      'you_title': 'Twoje statystyki',
      'you_subtitle_has_data': 'Podsumowanie zapisanych aktywności',
      'you_subtitle_empty':
      'Brak zapisanych aktywności – rozpocznij pierwszy trening!',
      'you_trainings': 'Treningi',
      'you_distance': 'Dystans',
      'you_distance_sub': 'Suma wszystkich',
      'you_avg_speed': 'Średnia prędkość',
      'you_avg_speed_sub': 'Na podstawie wszystkich treningów',

      // Ranking
      'rating_weekly_title': 'Ranking tygodniowy',
      'rating_weekly_sub':
      'Na podstawie sumarycznego dystansu z ostatnich 7 dni',
      'rating_table_title': 'Tabela wyników',
      'rating_no_data': 'Brak danych do wyświetlenia rankingu',
      'rating_you_weekly': 'Twój dystans w tym tygodniu',

      'joinFree': 'Dołącz za darmo',
      'login':'Login',

      'detail_note': 'Notatka',
      'detail_photo': 'Zdjęcie',

      'auth_create_account': 'Utwórz konto',
      'auth_email': 'Email',
      'auth_password': 'Hasło',
      'auth_repeat_password': 'Powtórz hasło',
      'auth_error_email_required': 'Wpisz swój email',
      'auth_error_email_invalid': 'Nieprawidłowy adres',
      'auth_error_password_required': 'Wpisz hasło',
      'auth_error_password_short': 'Minimum 6 znaków',
      'auth_error_password_repeat_required': 'Powtórz hasło',
      'auth_error_password_mismatch': 'Hasła nie są takie same',
      'auth_signup_success': 'Rejestracja zakończona (mock).',
      'auth_sign_up': 'Załóż konto',
      'auth_already_have_account': 'Masz już konto? ',

      'auth_login_title': 'Logowanie do Strava',
      'auth_forgot_password': 'Zapomniałeś hasła?',
      'auth_login_success': 'Zalogowano (mock).',

      'auth_forgot_title': 'Reset hasła',
      'auth_send_reset': 'Wyślij link resetujący',
      'auth_reset_sent_to': 'Link resetujący wysłany na',

      'profile_saved': 'Profil zapisany',
      'profile_first_name': 'Imię',
      'profile_last_name': 'Nazwisko',
      'profile_required': 'Wymagane',
      'profile_birth_date': 'Data urodzenia',
      'profile_birth_not_set': 'Nie wybrano',
      'profile_gender': 'Płeć',
      'profile_gender_male': 'Mężczyzna',
      'profile_gender_female': 'Kobieta',
      'profile_gender_other': 'Inne',
      'profile_height': 'Wzrost (cm)',
      'profile_weight': 'Waga (kg)',
      'profile_save': 'Zapisz',

      'record_location_disabled': 'Lokalizacja wyłączona w systemie',
      'record_location_denied': 'Brak zgody na użycie lokalizacji',
      'record_location_denied_forever':
      'Dostęp do lokalizacji zablokowany. Zmień uprawnienia w ustawieniach.',
      'record_started': 'Start nagrywania',
      'record_paused': 'Aktywność wstrzymana',
      'record_resumed': 'Aktywność wznowiona',

      'meta_title': 'Szczegóły aktywności',
      'meta_distance': 'Dystans',
      'meta_time': 'Czas',
      'meta_pace': 'Tempo',
      'meta_name_hint': 'Nazwa aktywności',
      'meta_name_required': 'Wpisz nazwę',
      'meta_type': 'Typ aktywności',
      'meta_note_hint': 'Notatka (opcjonalnie)',
      'meta_photo_added': 'Zdjęcie dodane',
      'meta_cancel': 'Anuluj',
      'meta_save': 'Zapisz',
      'activity_default_name': 'Aktywność',

      'slogan': 'Naładuj się motywacją od ludzi o podobnych celach.',
      'auth_disclaimer': 'Rejestrując się, akceptujesz Regulamin i Politykę Prywatności.',
      'total_number': 'Łączna liczba',


    },

    'en': {
      // Общие
      'app_title': 'My activity',

      // RecordPage
      'record_new_activity': 'New activity',
      'record_duration': 'Duration',
      'record_distance': 'Distance',
      'record_pace': 'Pace',
      'record_speed': 'Speed',
      'record_start': 'Start',
      'record_pause': 'Pause',
      'record_resume': 'Resume',
      'record_finish': 'Finish',
      'record_saved':'Record saved',

      // Bottom nav
      'nav_record': 'Record',
      'nav_history': 'History',
      'nav_group': 'Group',
      'nav_you': 'You',

      // History
      'history_title': 'Activity history',
      'history_empty': 'No saved activities',
      'history_empty_filter': 'No activities for selected filter',

      // Filters
      'filter_all': 'All',
      'filter_run': 'Run',
      'filter_ride': 'Ride',
      'filter_walk': 'Walk',

      // Sort
      'sort_title': 'Sorting',
      'sort_newest': 'Newest',
      'sort_oldest': 'Oldest',
      'sort_longest': 'Longest distance',
      'sort_shortest': 'Shortest distance',

      // YouPage
      'you_title': 'Your stats',
      'you_subtitle_has_data': 'Summary of your saved activities',
      'you_subtitle_empty':
      'No saved activities yet – start your first training!',
      'you_trainings': 'Workouts',
      'you_distance': 'Distance',
      'you_distance_sub': 'Total distance',
      'you_avg_speed': 'Average speed',
      'you_avg_speed_sub': 'Based on all workouts',

      // Rating
      'rating_weekly_title': 'Weekly ranking',
      'rating_weekly_sub':
      'Based on total distance from the last 7 days',
      'rating_table_title': 'Leaderboard',
      'rating_no_data': 'No data to show leaderboard',
      'rating_you_weekly': 'Your distance this week',

      "joinFree": "Join for free",
      "login": "Login",

      'detail_note': 'Note',
      'detail_photo': 'Photo',

      'auth_create_account': 'Create account',
      'auth_email': 'Email',
      'auth_password': 'Password',
      'auth_repeat_password': 'Repeat password',
      'auth_error_email_required': 'Enter your email',
      'auth_error_email_invalid': 'Incorrect address',
      'auth_error_password_required': 'Enter password',
      'auth_error_password_short': 'Min 6 characters',
      'auth_error_password_repeat_required': 'Repeat password',
      'auth_error_password_mismatch': 'Passwords do not match',
      'auth_signup_success': 'Registration completed (mock).',
      'auth_sign_up': 'Sign up',
      'auth_already_have_account': 'Already have an account? ',

      'auth_login_title': 'Login to Strava',
      'auth_forgot_password': 'Forgot password?',
      'auth_login_success': 'Logged in (mock).',

      'auth_forgot_title': 'Forgot password',
      'auth_send_reset': 'Send reset link',
      'auth_reset_sent_to': 'Reset link sent to',

      'profile_saved': 'Profile saved',
      'profile_first_name': 'First name',
      'profile_last_name': 'Last name',
      'profile_required': 'Required',
      'profile_birth_date': 'Date of birth',
      'profile_birth_not_set': 'Not selected',
      'profile_gender': 'Gender',
      'profile_gender_male': 'Male',
      'profile_gender_female': 'Female',
      'profile_gender_other': 'Other',
      'profile_height': 'Height (cm)',
      'profile_weight': 'Weight (kg)',
      'profile_save': 'Save',

      'record_location_disabled': 'Location services are disabled',
      'record_location_denied': 'Location permission denied',
      'record_location_denied_forever':
      'Location access is permanently denied. Change permissions in system settings.',
      'record_started': 'Recording started',
      'record_paused': 'Activity paused',
      'record_resumed': 'Activity resumed',

      'meta_title': 'Activity details',
      'meta_distance': 'Distance',
      'meta_time': 'Time',
      'meta_pace': 'Pace',
      'meta_name_hint': 'Activity name',
      'meta_name_required': 'Enter a name',
      'meta_type': 'Activity type',
      'meta_note_hint': 'Note (optional)',
      'meta_photo_added': 'Photo added',
      'meta_cancel': 'Cancel',
      'meta_save': 'Save',
      'activity_default_name': 'Activity',

      'slogan': 'Charge yourself with the motivation of like-minded people.',
      'auth_disclaimer': 'By registering, you agree to the Terms of Service and Privacy Policy.',

      'total_number':'Total number',

    },
  };

  String _t(String key) {
    final lang = _values[locale.languageCode] ?? _values['en']!;
    return lang[key] ?? key;
  }

  String get appTitle => _t('app_title');

  String get recordNewActivity => _t('record_new_activity');
  String get recordDuration => _t('record_duration');
  String get recordDistance => _t('record_distance');
  String get recordPace => _t('record_pace');
  String get recordSpeed => _t('record_speed');
  String get recordStart => _t('record_start');
  String get recordPause => _t('record_pause');
  String get recordResume => _t('record_resume');
  String get recordFinish => _t('record_finish');

  String get recordSaved => _t('record_saved');

  String get navRecord => _t('nav_record');
  String get navHistory => _t('nav_history');
  String get navGroup => _t('nav_group');
  String get navYou => _t('nav_you');

  String get historyTitle => _t('history_title');
  String get historyEmpty => _t('history_empty');
  String get historyEmptyFilter => _t('history_empty_filter');

  String get filterAll => _t('filter_all');
  String get filterRun => _t('filter_run');
  String get filterRide => _t('filter_ride');
  String get filterWalk => _t('filter_walk');

  String get sortTitle => _t('sort_title');
  String get sortNewest => _t('sort_newest');
  String get sortOldest => _t('sort_oldest');
  String get sortLongest => _t('sort_longest');
  String get sortShortest => _t('sort_shortest');

  String get youTitle => _t('you_title');
  String get youSubtitleHasData => _t('you_subtitle_has_data');
  String get youSubtitleEmpty => _t('you_subtitle_empty');
  String get youTrainings => _t('you_trainings');
  String get youDistance => _t('you_distance');
  String get youDistanceSub => _t('you_distance_sub');
  String get youAvgSpeed => _t('you_avg_speed');
  String get youAvgSpeedSub => _t('you_avg_speed_sub');

  String get ratingWeeklyTitle => _t('rating_weekly_title');
  String get ratingWeeklySub => _t('rating_weekly_sub');
  String get ratingTableTitle => _t('rating_table_title');
  String get ratingNoData => _t('rating_no_data');
  String get ratingYouWeekly => _t('rating_you_weekly');

  String get login => _t('login');
  String get joinFree => _t('joinFree');

  String get detailNote => _t('detail_note');
  String get detailPhoto => _t('detail_photo');

  String get authCreateAccount => _t('auth_create_account');
  String get authEmail => _t('auth_email');
  String get authPassword => _t('auth_password');
  String get authRepeatPassword => _t('auth_repeat_password');

  String get authErrorEmailRequired => _t('auth_error_email_required');
  String get authErrorEmailInvalid => _t('auth_error_email_invalid');
  String get authErrorPasswordRequired => _t('auth_error_password_required');
  String get authErrorPasswordShort => _t('auth_error_password_short');
  String get authErrorPasswordRepeatRequired => _t('auth_error_password_repeat_required');
  String get authErrorPasswordMismatch => _t('auth_error_password_mismatch');
  String get authSignupSuccess => _t('auth_signup_success');
  String get authSignUp => _t('auth_sign_up');
  String get authAlreadyHaveAccount => _t('auth_already_have_account');

  String get authLoginTitle => _t('auth_login_title');
  String get authForgotPassword => _t('auth_forgot_password');
  String get authLoginSuccess => _t('auth_login_success');

  String get authForgotTitle => _t('auth_forgot_title');
  String get authSendReset => _t('auth_send_reset');
  String get authResetSentTo => _t('auth_reset_sent_to');
  String get profileSaved => _t('profile_saved');
  String get profileFirstName => _t('profile_first_name');
  String get profileLastName => _t('profile_last_name');
  String get profileRequired => _t('profile_required');

  String get profileBirthDate => _t('profile_birth_date');
  String get profileBirthNotSet => _t('profile_birth_not_set');

  String get profileGender => _t('profile_gender');
  String get profileGenderMale => _t('profile_gender_male');
  String get profileGenderFemale => _t('profile_gender_female');
  String get profileGenderOther => _t('profile_gender_other');

  String get profileHeight => _t('profile_height');
  String get profileWeight => _t('profile_weight');

  String get profileSave => _t('profile_save');

  String get recordLocationDisabled => _t('record_location_disabled');
  String get recordLocationDenied => _t('record_location_denied');
  String get recordLocationDeniedForever => _t('record_location_denied_forever');
  String get recordStarted => _t('record_started');
  String get recordPaused => _t('record_paused');
  String get recordResumed => _t('record_resumed');

  String get metaTitle => _t('meta_title');
  String get metaDistance => _t('meta_distance');
  String get metaTime => _t('meta_time');
  String get metaPace => _t('meta_pace');
  String get metaNameHint => _t('meta_name_hint');
  String get metaNameRequired => _t('meta_name_required');
  String get metaType => _t('meta_type');
  String get metaNoteHint => _t('meta_note_hint');
  String get metaPhotoAdded => _t('meta_photo_added');
  String get metaCancel => _t('meta_cancel');
  String get metaSave => _t('meta_save');
  String get activityDefaultName => _t('activity_default_name');

  String get slogan => _t('slogan');
  String get authDisclaimer => _t('auth_disclaimer');
  String get  totalNumber => _t ('total_number ');



  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    )!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['pl', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
