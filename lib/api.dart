import 'package:footsie/util/dio_util.dart';

const host = 'https://www.boyslove.org';

login(data) {
  return NetUtils.post('$host/user/login', data);
}

register(data) {
  return NetUtils.post('$host/user/register', data);
}

getUsers(uid){
  // https://www.boyslove.org/users?uid=639465a0f75ac4ef5f3a3802
  return NetUtils.get('$host/users?uid=$uid');
}