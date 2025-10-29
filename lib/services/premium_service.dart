import 'package:shared_preferences/shared_preferences.dart';

class PremiumService {
  static const String _premiumKey = 'is_premium_user';
  
  // Singleton
  static final PremiumService _instance = PremiumService._internal();
  factory PremiumService() => _instance;
  PremiumService._internal();
  
  bool _isPremium = false;
  
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isPremium = prefs.getBool(_premiumKey) ?? false;
  }
  
  bool get isPremium => _isPremium;
  
  Future<void> setPremium(bool value) async {
    _isPremium = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_premiumKey, value);
  }
  
  // Verifica se feature è disponibile
  bool canAccessFeature(PremiumFeature feature) {
    if (_isPremium) return true;
    return feature.isFreeFeature;
  }
  
  // Limiti versione free
  int getMaxRecurringTransactions() => _isPremium ? 999 : 3;
  int getMaxCustomCategories() => _isPremium ? 999 : 3;
  int getMaxProjectionMonths() => _isPremium ? 120 : 1;
}

enum PremiumFeature {
  recurringTransactions,
  advancedStatistics,
  unlimitedCategories,
  cloudBackup,
  pdfExport,
  multipleScenarios,
  customThemes,
}

extension PremiumFeatureExtension on PremiumFeature {
  bool get isFreeFeature {
    switch (this) {
      case PremiumFeature.recurringTransactions:
        return false; // limitato a 3
      default:
        return false;
    }
  }
}
