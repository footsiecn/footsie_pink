import 'package:footsie/util/dio_util.dart';

const host = 'https://www.cuipiya.net';

login(data) {
  return NetUtils.post('$host/user/login', data);
}
