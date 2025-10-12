import 'package:flutter/widgets.dart';
import 'package:flutter_base_template/core/l10n/generated/app_localizations.dart';

extension LocalizationX on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this)!;
}
