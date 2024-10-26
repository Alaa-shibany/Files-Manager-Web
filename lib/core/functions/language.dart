import 'package:intl/intl.dart';

bool isArabic() {
  print('isArabic => ${Intl.getCurrentLocale() == 'ar'}');
  return Intl.getCurrentLocale() == 'ar';
}
