import 'package:shaparak/data/model/variant.dart';
import 'package:shaparak/data/model/variant_type.dart';

class ProductVariant {
  VariantType variantType;
  List<Variant> variantList;

  ProductVariant(this.variantType, this.variantList);
}
