class IpService {
  String createIpAddress(String ip1, String ip2, String ip3, String ip4) {
    return 'http://' + ip1 + '.' + ip2 + '.' + ip3 + '.' + ip4 + '/';
  }

  String cut(String ip, int index) {
    int tmp = 6;
    int begin;
    int end;
    for (int i = 0; i < index; i++) {
      begin = tmp + 1;

      end = ip.indexOf('.', begin + 1);
      if (end < 0) {
        end = ip.indexOf('/', begin);
      } else {
        tmp = end;
      }
    }
    return ip.substring(begin, end);
  }
}
