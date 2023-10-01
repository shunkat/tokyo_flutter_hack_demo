import 'dart:math';

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  // 度をラジアンに変換
  lat1 = lat1 * (pi / 180);
  lon1 = lon1 * (pi / 180);
  lat2 = lat2 * (pi / 180);
  lon2 = lon2 * (pi / 180);

  // 地球の半径 (6371km とすることが多い)
  double r = 6371.0;

  double delta =
      acos(sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(lon2 - lon1));

  return r * delta;
}
