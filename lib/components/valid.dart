import 'package:project_r/constant/message.dart';

String? validIput(String val, int min, int max) {
  if (val.length > max) {
    return "$messageInputMin $max ";
  }

  if (val.isEmpty) {
    return " $messaageInputEmpty";
  }

  if (val.length < min) {
    return " $messageInputMin  $min";
  }

  return null;
}
