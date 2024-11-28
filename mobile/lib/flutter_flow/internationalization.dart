import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['fr', 'en', 'zh_Hans', 'pt', 'ln'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? frText = '',
    String? enText = '',
    String? zh_HansText = '',
    String? ptText = '',
    String? lnText = '',
  }) =>
      [frText, enText, zh_HansText, ptText, lnText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Acceuil
  {
    'm81lnfr2': {
      'fr': 'Lumaka Engineering',
      'en': 'Lumaka Engineering',
      'ln': 'Lumaka Engineering',
      'pt': 'Lumaka Engineering',
      'zh_Hans': 'Lumaka Engineering',
    },
    'b8vehp5h': {
      'fr': 'Lumaka Série X',
      'en': 'Lumaka X Series',
      'ln': 'Lumaka Série X',
      'pt': 'Lumaka Série X',
      'zh_Hans': '卢马卡 X 系列',
    },
    'mqwdyavs': {
      'fr': 'Statut',
      'en': 'Status',
      'ln': 'Statut',
      'pt': 'Status',
      'zh_Hans': '地位',
    },
    'tw8t7w5c': {
      'fr': 'Watt',
      'en': 'Watt',
      'ln': 'Watt',
      'pt': 'Watt',
      'zh_Hans': '瓦',
    },
    'mfa28ftk': {
      'fr': '5Kw',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '12qp0uy5': {
      'fr': 'Batterie',
      'en': 'Battery',
      'ln': 'Batterie',
      'pt': 'Bateria',
      'zh_Hans': '电池',
    },
    'snph9gk6': {
      'fr': '57%',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '5o2lhnxa': {
      'fr': 'Connexion',
      'en': 'Connection',
      'ln': 'Bokangami',
      'pt': 'Conexão',
      'zh_Hans': '联系',
    },
    '7hftj8yx': {
      'fr': 'Forte',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'hnvus06m': {
      'fr': 'Information',
      'en': 'Information',
      'ln': 'Nsango',
      'pt': 'Informação',
      'zh_Hans': '信息',
    },
    'kvosjnul': {
      'fr': 'Energie Total',
      'en': 'Energy Total',
      'ln': ' Énergie Nioso',
      'pt': 'Total de Energia',
      'zh_Hans': '总能量',
    },
    '12lt2m1e': {
      'fr': '58.43\$',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'yhbm1luv': {
      'fr': '5.10\$',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'kir4o0lx': {
      'fr': '/journée',
      'en': '/daytime',
      'ln': '/mokolo',
      'pt': '/dia',
      'zh_Hans': '/白天',
    },
    'e10map25': {
      'fr': 'Consommation ',
      'en': 'Consumption',
      'ln': 'Komela',
      'pt': 'Consumo',
      'zh_Hans': '消耗',
    },
    'eb9sqiof': {
      'fr': '132Kwh',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'vattg0v6': {
      'fr': 'numero',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '3vwpuad2': {
      'fr': 'Ampère',
      'en': 'Ampere',
      'ln': 'Ampère',
      'pt': 'Ampére',
      'zh_Hans': '安培',
    },
    'bp0fi1dy': {
      'fr': '16A',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'lyvnmt57': {
      'fr': 'Voltage',
      'en': 'Voltage',
      'ln': 'Voltage',
      'pt': 'Tensão',
      'zh_Hans': '电压',
    },
    'qk66hdu9': {
      'fr': '230V',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    't0cs03v7': {
      'fr': 'Charge',
      'en': 'Charge',
      'ln': 'Charge',
      'pt': 'Cobrar',
      'zh_Hans': '收费',
    },
    '6um67qg6': {
      'fr': '100%',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'q0fda910': {
      'fr': '300h',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'fp7oy0dw': {
      'fr': 'restant',
      'en': 'remaining',
      'ln': '',
      'pt': 'restante',
      'zh_Hans': '其余的',
    },
    'xzwzfmkg': {
      'fr': 'Température',
      'en': 'Temperature',
      'ln': '',
      'pt': 'Temperatura',
      'zh_Hans': '温度',
    },
    'quieow6y': {
      'fr': '35°C',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'i4i7e464': {
      'fr': 'Jour',
      'en': 'Day',
      'ln': '',
      'pt': 'Dia',
      'zh_Hans': '天',
    },
    'awj09pa7': {
      'fr': 'ensoleillé',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '2ibzkkt1': {
      'fr': 'Etanchéité',
      'en': 'Waterproofing',
      'ln': 'Kokotisa mai te',
      'pt': 'Impermeabilização',
      'zh_Hans': '防水',
    },
    'ena041cf': {
      'fr': '100%',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'latp1tdd': {
      'fr': '0%',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'eqeklvif': {
      'fr': 'de risque',
      'en': 'of risk',
      'ln': 'ya likama',
      'pt': 'de risco',
      'zh_Hans': '的风险',
    },
    '6wdv34rt': {
      'fr': 'Navigation ',
      'en': 'Navigation',
      'ln': 'Navigation ',
      'pt': 'Navegação',
      'zh_Hans': '导航',
    },
    'mu9h2l1x': {
      'fr': 'Fort courant',
      'en': 'Storyteller',
      'ln': 'Mobeti-masolo',
      'pt': 'Contador ',
      'zh_Hans': '讲故事的人',
    },
    'ob937omy': {
      'fr': 'Contrôle à distance des appareiles \nde grande puissance ',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'p257s92i': {
      'fr': 'Paramètre',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'jqcf24yk': {
      'fr': 'Appareil',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'mzdazv08': {
      'fr': 'Ajouter un Conteur ',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'pbr0hr0s': {
      'fr': 'Carte',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'mv2zgihy': {
      'fr': 'Facture',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'zrwbkny6': {
      'fr': 'Aide',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'vti0gm12': {
      'fr': 'Inviter un contact',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'r8ty3foa': {
      'fr': 'Mises à jours',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'fx0hju3h': {
      'fr': 'Abonnez-vous',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'zinzckqi': {
      'fr': 'Se deconnecter',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'aqdpfi3s': {
      'fr': 'Version 1.0 Beta',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'z9v2gw0e': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // ProfilJHH
  {
    'uhwellya': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // Profil
  {
    '4voymshb': {
      'fr': 'Jephte Lumaka ',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'x5ckah9j': {
      'fr': 'jephtelumaka@gmail.com',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'bxu2vn4l': {
      'fr': 'Compte',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'i7hinwso': {
      'fr': 'jephtelumaka@gmail.com',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'zanm3afw': {
      'fr': 'Mot de passe : ********',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '2512p302': {
      'fr': 'Téléphone : ',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '3eagl6sn': {
      'fr': '0827309260',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'l9yq1tly': {
      'fr': 'Modifier l\'adresse e-mail',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'zsolyu1g': {
      'fr': 'Modifier le mot de passe',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'ax8j6r3l': {
      'fr': 'Modifier le numéro de téléphone',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'ua01320e': {
      'fr': 'Paramètres',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '90orghdg': {
      'fr': 'Gérer les accès et appareils',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'nobnlliu': {
      'fr': 'Se déconnecter de tous les appareils',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'dopyl5ks': {
      'fr': 'Suprimer le compte',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'dmc7awtr': {
      'fr': 'Se déconnecter',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'l0vsgp82': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // Graphique
  {
    '9dhrwyk3': {
      'fr': 'Energie Totale',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'vdnetfl5': {
      'fr': 'Totale Enérgie',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'fjvcekeo': {
      'fr': '58.43',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '2fqulz17': {
      'fr': '\$',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'osgarwtl': {
      'fr': 'Jour',
      'en': 'Day',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'dgtgoth5': {
      'fr': 'Semaine',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    's1xp7e1a': {
      'fr': 'Mois',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'knb379c2': {
      'fr': 'Année',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'mui63ga1': {
      'fr': 'Jour',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'vcowr71i': {
      'fr': '25/10/2024',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '8vrxnzhz': {
      'fr': 'Enérgie Total',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'c531auwd': {
      'fr': '58.43',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'obhhkr2p': {
      'fr': '\$',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'a3v5v9yc': {
      'fr': '\$',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'vywnxuw0': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'zy9l7s0n': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // SeConnecter
  {
    'qprckns5': {
      'fr': 'Content de te revoir',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'g71o0k2s': {
      'fr': 'Commençons par remplir le formulaire ci-dessous.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'kdf8jzwx': {
      'fr': 'E-mail',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '3h5dgfp0': {
      'fr': 'Mot de passe',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'buvgji57': {
      'fr': 'Se connecter',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'qwut0nok': {
      'fr': 'OU',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'qugs7edh': {
      'fr': 'Continuer avec Google',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'tlv3wwbs': {
      'fr': 'Vous n\'avez pas de compte ?',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '5zlgiqpl': {
      'fr': 'Inscrivez-vous ici',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'ydm6odhn': {
      'fr': 'Mot de passe oublié',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '7o0fyn73': {
      'fr': 'UserName',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'ykaiwmea': {
      'fr': 'Overall',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'enrkdmno': {
      'fr': '5',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'zxnqpl91': {
      'fr':
          'Nice outdoor courts, solid concrete and good hoops for the neighborhood.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'i83ef1qq': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // creatio
  {
    'fg6eiyu1': {
      'fr': 'Task...',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'y3fy7lp6': {
      'fr': 'Description...',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'lgtclyxo': {
      'fr': 'Add tags',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'rhgtlj0m': {
      'fr': 'Product Design',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'qrsro06t': {
      'fr': 'FlutterFlow',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'gkv0m1lj': {
      'fr': 'UI Design',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'chv48tiu': {
      'fr': 'Web Design',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'mqivulbr': {
      'fr': 'Product Design',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'w6wxky89': {
      'fr': 'Due Date',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '2tn76df5': {
      'fr': 'Get Started',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'vl8bdudj': {
      'fr': 'Create Task',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'vjsn8u6i': {
      'fr': 'Please fill out the form below to continue.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'alpp8ffk': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // date
  {
    'tuxz97tp': {
      'fr': 'Welcome',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'eff7ptrd': {
      'fr': 'Your recent activity is below.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'q8fz0m02': {
      'fr': 'Tasks',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'pznrk66e': {
      'fr': 'Completed',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'y48aggd2': {
      'fr': 'Last 30 Days',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'zeczz1bz': {
      'fr': 'Avg. Grade',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'x3d5ju3f': {
      'fr': 'Tasks',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'pi5r8g6a': {
      'fr': 'A summary of outstanding tasks.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '6pjeusw3': {
      'fr': 'Task Type',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '8uk9epx5': {
      'fr':
          'Task Description here this one is really long and it goes over maybe? And goes to two lines.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'f38chjvl': {
      'fr': 'Due',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '26uv3gtt': {
      'fr': 'Today, 5:30pm',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'nebaphnr': {
      'fr': 'Update',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '6pro6ud4': {
      'fr': '1',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'jlmicjsp': {
      'fr': 'Task Type',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'd9u6j0ck': {
      'fr':
          'Task Description here this one is really long and it goes over maybe? And goes to two lines.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'awoks89i': {
      'fr': 'Due',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'jr1p9h7g': {
      'fr': 'Today, 5:30pm',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'dc17ro2w': {
      'fr': 'Update',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'd4uh76b5': {
      'fr': '1',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'lia2mx9g': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // day
  {
    'g6oy6eqp': {
      'fr': 'Game Preview',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'np5kyt2s': {
      'fr': '6:00pm',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'yddty5mt': {
      'fr': 'At',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'uvmb2o0x': {
      'fr': 'Vivint Arena',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'zv82s2ql': {
      'fr': 'Home Game',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'sxsj3awn': {
      'fr': 'Brooklyn Nets',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '5lyr2qlz': {
      'fr': 'Team Rosters',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'l3nnesvp': {
      'fr': 'Jazz',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'ooi4y8q1': {
      'fr': 'Mike Conley',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'psj5mj3w': {
      'fr': '6\' 3\" Point Guard',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'v98brsyw': {
      'fr': 'Jordan Clarkson',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'yyayifxs': {
      'fr': '6\' 4\" Point Guard',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'g4pl1my5': {
      'fr': 'Rudy Gay',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'y2wyjvl3': {
      'fr': '6\' 3\" Point Guard',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'hov9ockm': {
      'fr': 'Kelly Olynyk',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '4po0x9i4': {
      'fr': '6\' 11\" Power Forward',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'gu73j7lg': {
      'fr': 'Jared Butler',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'gsu87659': {
      'fr': '6\' 5\" Small Forward',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'nhoa5i7l': {
      'fr': 'Nets',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'to188xk9': {
      'fr': 'Mike Conley',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '1ap8kh24': {
      'fr': '6\' 3\" Point Guard',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'jhamkcen': {
      'fr': 'Jordan Clarkson',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'wm78zh8d': {
      'fr': '6\' 4\" Point Guard',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'h3m65m0j': {
      'fr': 'Rudy Gay',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'jiedkb8a': {
      'fr': '6\' 3\" Point Guard',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'ymm72myy': {
      'fr': 'Kelly Olynyk',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'd4yo9ga9': {
      'fr': '6\' 11\" Power Forward',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'mfurr0tg': {
      'fr': 'Jared Butler',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'gaj3p8ej': {
      'fr': '6\' 5\" Small Forward',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'o7el7jpo': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // CreerUnCompte
  {
    '7tvv9q5r': {
      'fr': 'Créer un compte',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '7pkq7sn3': {
      'fr': 'Commençons par remplir le formulaire ci-dessous.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'id2ngbjx': {
      'fr': 'Nom',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'edmetdwj': {
      'fr': 'Prénom',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'drvd26rr': {
      'fr': 'E-mail',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '0ljfpp7n': {
      'fr': 'Mot de passe',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'h4jaqxtw': {
      'fr': 'Confirmez le mot de passe',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'ryah88zt': {
      'fr': 'Créer un compte',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'ac4z19vo': {
      'fr': 'OU',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'ptpu4qo9': {
      'fr': 'Continuer avec Google',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '5ruqpb4n': {
      'fr': 'Vous avez déjà un compte ?',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'ngzvm0xf': {
      'fr': 'Connectez-vous ici',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'd3aq84z4': {
      'fr': 'UserName',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'pbj56d4i': {
      'fr': 'Overall',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'rdq26rj7': {
      'fr': '5',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'wj11ckia': {
      'fr':
          'Nice outdoor courts, solid concrete and good hoops for the neighborhood.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'of72imw2': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // MotDePasseOublie
  {
    '95p1sv5n': {
      'fr': 'Back',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'du1dyy8d': {
      'fr': 'Mot de passe oublié',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'r21tmrd0': {
      'fr':
          'Nous vous enverrons un e-mail avec un lien pour réinitialiser votre mot de passe, veuillez saisir l\'e-mail associé à votre compte ci-dessous.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'v02wpt8z': {
      'fr': 'Votre adresse e-mail...',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'l8f659nr': {
      'fr': 'Entrez votre email...',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'swib8dge': {
      'fr': 'Envoyer le lien',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '10tv38b1': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // SuccesEmail
  {
    'jnzdv5c4': {
      'fr': 'Succès',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'q1462vy0': {
      'fr':
          'Un lien de réinitialisation de mot de passe a été envoyé avec succès à votre adresse e-mail. Veuillez vérifier votre boîte de réception et suivre les instructions pour créer un nouveau mot de passe.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '0r62dlci': {
      'fr': 'Jephte Lumaka',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '38eepxj7': {
      'fr': 'jephtelumaka@gmail.com',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '050cmlgq': {
      'fr': 'Terminer',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'zoqx4qrc': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // EchecEmail
  {
    '0a5w3pvq': {
      'fr': 'Échec',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'tqobak05': {
      'fr':
          'Nous n\'avons pas pu envoyer le lien de réinitialisation de mot de passe à votre adresse e-mail. Veuillez vérifier que l\'adresse saisie est correcte et réessayer. Si le problème persiste, contactez le support.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '4ecgwc1l': {
      'fr': 'Jephte Lumaka',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'i3dxez63': {
      'fr': 'jephtelumaka@gmail.com',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'r1hxs6ir': {
      'fr': 'Recommencer',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'xpw5cd4k': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // dayCopy
  {
    '5e277xe5': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // Facture
  {
    'f0drgsrh': {
      'fr': 'Order #49224222',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '4eermvlx': {
      'fr': 'Below are the details of your order.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'so8c3ks0': {
      'fr': 'Payment Details',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'c4gga50f': {
      'fr': 'Transaction ID',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'k6ilrk8q': {
      'fr': 'TXN123456789',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'cawfga2c': {
      'fr': 'Amount',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'iof9wann': {
      'fr': '\$500.00',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '9g2xhode': {
      'fr': 'Status',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '9jpg2ase': {
      'fr': 'Completed',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '0c2axjkn': {
      'fr': 'Payment Method',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '8d3jds0k': {
      'fr': 'Visa ****1234',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'gve0j6gh': {
      'fr': 'Transaction Breakdown',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'g2petvpy': {
      'fr': 'Subtotal',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'ypi7gtby': {
      'fr': '\$480.00',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'sgjomop6': {
      'fr': 'Tax',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'tiis36m6': {
      'fr': '\$20.00',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'sckyw16z': {
      'fr': 'Total',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '0qr9u6wr': {
      'fr': '\$500.00',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'tho8x2fd': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // ConditionsEtConfidentialite
  {
    'dzaltdv0': {
      'fr': 'Conditions d\'utilisation et Politique de Confidentialité',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'epzpppwj': {
      'fr':
          '1. Introduction\nLumaka Engineering s\'engage à protéger la confidentialité de toutes les informations fournies par les utilisateurs de notre compteur connecté. Cette politique vise à affirmer notre respect total de vos droits à la vie privée.\n\n2. Collecte d\'informations\nNous recueillons des informations personnelles permettant l\'identification, que nous utilisons pour :\n\nÉtablir le profil des utilisateurs.\nAdministrer les comptes de compteur connecté.\nMettre à jour nos bases de données.\nFournir une assistance aux utilisateurs.\n3. Partage des données\nSauf disposition contraire, Lumaka Engineering ne partage pas vos données personnelles avec des tiers non autorisés. Des mesures de protection adéquates sont mises en place pour prévenir tout accès non autorisé et garantir la confidentialité de vos données.\n\n4. Utilisation des services\nEn utilisant notre compteur connecté, vous reconnaissez que certaines de vos données personnelles peuvent être partagées avec des tiers impliqués dans le service, tels que des fournisseurs de services de paiement ou des partenaires technologiques. Vous autorisez Lumaka Engineering à partager vos données personnelles nécessaires à la bonne exécution de ces services.\n\n5. Sécurité des données de paiement\nNous prenons la sécurité de vos données de paiement très au sérieux. Toutes les transactions sont traitées via des protocoles de sécurité avancés pour protéger vos informations financières contre les accès non autorisés. Nous ne stockons pas vos informations de carte de crédit.\n\n6. Vérification d\'identité\nLumaka Engineering se réserve le droit de vérifier vos informations d\'identité via des bases de données publiques ou d\'autres moyens appropriés pour se conformer aux exigences réglementaires.\n\n7. Surveillance et divulgation\nNous avons le droit de surveiller l\'utilisation de votre compte et de divulguer vos données aux autorités compétentes en cas de suspicion de fraude, de blanchiment d\'argent ou d\'autres activités illégales. Toute fraude de la part de l\'utilisateur sera punie conformément à la loi en vigueur.\n\n8. Confidentialité des employés\nLes employés de Lumaka Engineering qui traitent des données personnelles sont tenus de les garder confidentielles. Des mesures disciplinaires peuvent être appliquées en cas de violation de cette politique.\n\n9. Non-responsabilité pour réparations\nLumaka Engineering ne sera pas responsable des dommages ou des pertes résultant des réparations effectuées par des individus non autorisés sur le compteur connecté. Toute intervention non autorisée annulera la garantie.\n\n10. Accès et correction des données\nLes utilisateurs peuvent demander l\'accès et la correction des informations personnelles soumises à Lumaka Engineering. Nous avons mis en place des systèmes pour faciliter cet accès.\n\n11. Modifications de la politique\nCette politique de confidentialité peut être mise à jour périodiquement. Nous informons les utilisateurs de toute modification significative.\n\n12. Droit applicable\nCette politique est régie par les lois en vigueur dans le pays où Lumaka Engineering est établi.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'otgdlzze': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // ReseauxSociaux
  {
    'ho3dwew4': {
      'fr': 'Suivez-nous sur les réseaux sociaux !',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'uipbonik': {
      'fr':
          'Nous adorons interagir avec notre communauté et partager des mises à jour, des nouvelles, et du contenu exclusif. Rejoignez-nous sur nos réseaux sociaux pour rester informé et participer à la conversation :',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'mysuju4t': {
      'fr': 'Site Web',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'q4zkptqo': {
      'fr': 'Linkedin',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'omwt10wa': {
      'fr': 'Instagram',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'z0dyd578': {
      'fr': 'Twitter',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'xkxtg2mg': {
      'fr': 'WhatsApp',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'ylp3i6y3': {
      'fr': 'Facebook',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'z66si7xy': {
      'fr': 'Tik Tok',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '8xsx5713': {
      'fr': 'You Tube',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '1j1okcoj': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // MisesAJours
  {
    'wdqc67ww': {
      'fr': 'Mise à jour de l\'application',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'mbjgelvy': {
      'fr': 'Mise à jour automatique pour \nLumaka',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'toxh1ayq': {
      'fr': 'Téléchargez automatiquement les mises à jour de l\'application.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'sdx6qua4': {
      'fr': 'Autoriser les mises à jour sur n\'importe quel réseau',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'irjrydud': {
      'fr':
          'Téléchargezles mises à jour à l\'aide des données mobiles lorsque le Wi-Fi n\'est pas disponible. Des frais peuvent s\'appliquer.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'yujirffq': {
      'fr': 'Notifications',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '0ijiggnz': {
      'fr': 'Recevez des notifications quand de mises à jour sont disponible ',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'v41g6l49': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // Aide
  {
    '52ktvdhi': {
      'fr': 'Aide',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    't9agvx64': {
      'fr': 'Centre d\'aide',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '1fzx2zim': {
      'fr': 'Conditions et confidentialité',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'vmid2msm': {
      'fr': 'Signalerments du problème',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'crsxgsqx': {
      'fr': 'Info de l\'application',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'xuzjxn1t': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // InfoDeLapplication
  {
    'q426oofh': {
      'fr': 'Lumaka',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'i7m5sema': {
      'fr': 'Version 1.0 Beta',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'mc8ypoxn': {
      'fr': '© 2022-2024 Lumaka Engineering inc',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'mfkib8y6': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // Probleme
  {
    '61l8lvhv': {
      'fr': 'Aide',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'v0pp6utw': {
      'fr': 'Centre d\'aide',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'cpksaxwe': {
      'fr': 'Conditions et confidentialité',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'jx4596rf': {
      'fr': 'Signalerments du problème',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'u9tng5do': {
      'fr': 'Info de l\'application',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '9zb76nf4': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // SignalermentsDuProblme
  {
    'glh2327e': {
      'fr': 'Aide',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'xjylczmd': {
      'fr':
          'Nous sommes là pour vous aider avec votre compteur connecté Lumaka. Pour toute question ou préoccupation, consultez notre FAQ ou contactez-nous directement.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'skx0fj2q': {
      'fr': 'Application',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'r0g0fw23': {
      'fr': 'Mot de passe oublié et difficulté à le réinitialiser.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'gzowpedj': {
      'fr': 'Compte bloqué ou suspendu.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'yjzk71xb': {
      'fr': 'Paramètres de sécurité non acceptés',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '7j2g7dcs': {
      'fr': 'L\'application ne se charge pas.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'fii109xx': {
      'fr': 'Temps de chargement excessifs.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'jmcsg3ud': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'jixkaz8h': {
      'fr': 'Search...',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'cwt3fdi2': {
      'fr': 'Conteur',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '06vmuc0b': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // AjouterUnConteur
  {
    'klacu1qo': {
      'fr': 'Ajouter un Conteur ',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'ap7t3s1o': {
      'fr':
          'Veuillez connecter votre application à votre compteur connecté Lumaka. Cela vous permettra de suivre vos données en temps réel et d\'accéder à toutes les fonctionnalités de l\'application. Suivez les instructions à l\'écran pour établir la connexion.',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '5pjijeca': {
      'fr': 'Saisir',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'xype7yqg': {
      'fr': 'Scanner',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'w9tj207t': {
      'fr': 'Scanner QR',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '867mxs44': {
      'fr': 'Scanner',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'cgrnu2v6': {
      'fr': 'Cancel',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'rhsymt2c': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // Carte
  {
    '9lpdty0z': {
      'fr': 'Hello World',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '9925odna': {
      'fr': 'Hello World',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '7xeex0g5': {
      'fr': 'Hello World',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'psckyucj': {
      'fr': 'Home',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
  // Miscellaneous
  {
    '5fr68m3a': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '1mh4up2a': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'pqidd403': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '79itbfrt': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'odzr04i6': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'ntcy8a0x': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'wcgkbe9j': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'x3brq3l0': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'vlyj4id2': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '7qkxaemd': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'lc1linxn': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '44ztddbr': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'znjxjejx': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'fvf7wtao': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'q5ca98rm': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'zh2an7hc': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    '5dyczhhf': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'i0jlhu1n': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'ib1txykw': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'ula432qv': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'fr0a4ogc': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'gfmgu3if': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'glp33wvl': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'dd6tdyx3': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'qmf85w9e': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
    'cqjxzmje': {
      'fr': '',
      'en': '',
      'ln': '',
      'pt': '',
      'zh_Hans': '',
    },
  },
].reduce((a, b) => a..addAll(b));
