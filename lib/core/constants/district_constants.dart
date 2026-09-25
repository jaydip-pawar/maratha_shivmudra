import 'package:maratha_shivmudra/core/constants/geo_constants.dart';

export 'package:maratha_shivmudra/core/constants/geo_constants.dart';

abstract class DistrictConstants {
  static List<DistrictInfo> get districts => GeoConstants.defaultState.districts;

  static String getCode(String? rawDistrict) {
    if (rawDistrict == null || rawDistrict.trim().isEmpty) return 'PUN';
    final normalized = rawDistrict.trim().toLowerCase();

    // Check across all states in India
    for (final state in GeoConstants.states) {
      for (final d in state.districts) {
        if (d.nameEn.toLowerCase() == normalized ||
            d.nameMr == rawDistrict.trim() ||
            d.code.toLowerCase() == normalized ||
            d.code.toLowerCase().endsWith(normalized)) {
          return d.code;
        }
      }
    }

    // Historical legacy aliases
    if (normalized.contains('aurangabad') || normalized.contains('औरंगाबाद')) {
      return 'CSN';
    }
    if (normalized.contains('ahmednagar') || normalized.contains('अहमदनगर')) {
      return 'AHI';
    }
    if (normalized.contains('osmanabad') || normalized.contains('उस्मानाबाद')) {
      return 'DHA';
    }
    if (normalized == 'mumbai' || normalized == 'मुंबई') {
      return 'MMC';
    }
    if (normalized.contains('belgaum') || normalized.contains('बेळगाव')) {
      return 'KA-BEL';
    }
    if (normalized.contains('surat') || normalized.contains('सुरत')) {
      return 'GJ-SUR';
    }

    return 'PUN';
  }

  static DistrictInfo getByCode(String code) {
    return GeoConstants.getDistrictByCode(code);
  }

  static String getNameEn(String? rawDistrict) {
    final code = getCode(rawDistrict);
    return getByCode(code).nameEn;
  }

  static String getNameMr(String? rawDistrict) {
    final code = getCode(rawDistrict);
    return getByCode(code).nameMr;
  }
}
