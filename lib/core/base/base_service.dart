import 'package:logger/logger.dart';

import '../logger.dart';

class BaseService {
  Logger log;

  BaseService({String title}) {
    this.log = getLogger(
      className: title ?? this.runtimeType.toString(),
    );
  }
}
