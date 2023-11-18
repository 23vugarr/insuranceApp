import 'package:pasha_insurance/models/data/base/base_data_model.dart';

abstract class BaseMapper<FROM, TO extends BaseDataModel> {
  TO convert(FROM object);
}