import 'dart:math';

import 'package:quiver/iterables.dart';

double distance(double x0, double y0, double x1, double y1) {
  return sqrt((x0 - x1) * (x0 - x1) + (y0 - y1) * (y0 - y1));
}

List<List<double>> getRandomEvenCordinates(int want, double width, double height, double minDist) {
  List<double> xs = [Random().nextDouble()];
  List<double> ys = [Random().nextDouble()];
  var found = 1;
  var iter = 1;
  while (found < want && iter < 1e6) {
    var x = width * Random().nextDouble();
    var y = height * Random().nextDouble();
    if (zip([xs, ys]).every((pair) => distance(x, y, pair[0], pair[1]) > minDist)) {
      xs.add(x);
      ys.add(y);
      found++;
    }
    iter++;
  }
  return [xs, ys];
}
