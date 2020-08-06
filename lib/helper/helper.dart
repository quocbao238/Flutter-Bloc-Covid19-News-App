import 'package:intl/intl.dart';

class Helper {
  Helper._();

  static String fomateTimeDataToMyFormat(String dataTime) =>
      DateFormat('dd-MM-yyyy').format(DateTime.parse(dataTime));

  static String convertTimeLastUpdate(String dataTime) =>
      DateFormat('hh:mm dd-MM-yyyy').format(DateTime.parse(dataTime).add(new Duration(hours: 7)));
}
