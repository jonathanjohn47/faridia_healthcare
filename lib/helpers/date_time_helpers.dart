extension DateTimeHelpers on DateTime {
  String getDateString() {
    return "${"$day".padLeft(2, '0')}/${"$month".padLeft(2, '0')}/${"$year".padLeft(4, '0')}";
  }

  String getTimeString(){
    return "${"$hour".padLeft(2, '0')}:${"$minute".padLeft(2, '0')}";
  }

  String getTimeStringInAmPm() {
    int hour = this.hour;
    int minute = this.minute;

    String period = (hour >= 12) ? 'PM' : 'AM';

    if (hour > 12) {
      hour -= 12;
    } else if (hour == 0) {
      hour = 12;
    }

    String hourString = (hour < 10) ? '0$hour' : hour.toString();
    String minuteString = (minute < 10) ? '0$minute' : minute.toString();

    return '$hourString:$minuteString $period';
  }

  String getDateStringWithMonthName() {
    Map<int, String> monthNames = {
      1: "January",
      2: "February",
      3: "March",
      4: "April",
      5: "May",
      6: "June",
      7: "July",
      8: "August",
      9: "September",
      10: "October",
      11: "November",
      12: "December"
    };
    return "${"$day".padLeft(2, '0')} ${monthNames[month]} $year";
  }

  String getYear() {
    return "$year";
  }

  String getHowMuchTimeAgo() {
    Duration difference = DateTime.now().difference(this);
    if (difference.inDays > 0) {
      return "${difference.inDays} days ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hours ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} minutes ago";
    } else {
      return "Just now";
    }
  }
}
