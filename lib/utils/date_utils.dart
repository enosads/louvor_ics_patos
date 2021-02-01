import 'package:intl/intl.dart';

class DateUtil {
  static final DateFormat d = DateFormat("EEEE, dd 'de' MMMM - HH:mm", 'pt');
  static final DateFormat notificacao =
      DateFormat("EEEE, dd/MM/yyyy - HH:mm", 'pt');
  static final DateFormat formatterDateAndTime =
      DateFormat('dd/MM/yyyy - HH:mm');
  static final DateFormat formatterDate = DateFormat('dd/MM/yyyy');
  static final DateFormat formatterTime = DateFormat('HH:mm');

  static String formatDateTimeDescrito(DateTime date) {
    return d.format(date).toUpperCase();
  }

  static String formatDateTimeNotificacao(DateTime date) {
    return notificacao.format(date).toUpperCase();
  }

  static String formatDate(DateTime date) {
    return formatterDate.format(date);
  }

  static String formatTime(DateTime date) {
    return formatterTime.format(date);
  }

  static String formatDateTime(DateTime date) {
    return formatterDateAndTime.format(date);
  }

  static DateTime parse(String date) {
    return formatterDateAndTime.parse(date);
  }

  static DateTime proximaDiaDaSemana(int diaDaSemana) {
    var date = new DateTime.now();
    while (date.weekday != diaDaSemana) {
      date = date.add(new Duration(days: 1));
    }
    return date;
  }
}
