import 'package:in_app_purchase/in_app_purchase.dart';
import 'premium_service.dart';

class SubscriptionService {
  final InAppPurchase _iap = InAppPurchase.instance;
  final PremiumService _premiumService = PremiumService();
  
  // ID prodotto (deve corrispondere a quello su App Store/Play Store)
  static const String premiumMonthlyId = 'premium_monthly_199';
  
  Future<void> init() async {
    final available = await _iap.isAvailable();
    if (!available) {
      print('Store non disponibile');
      return;
    }
    
    // Ascolta acquisti
    _iap.purchaseStream.listen(_onPurchaseUpdate);
    
    // Ripristina acquisti precedenti
    await _restorePurchases();
  }
  
  Future<void> purchasePremium() async {
    final ProductDetailsResponse response = await _iap.queryProductDetails({premiumMonthlyId});
    
    if (response.productDetails.isEmpty) {
      print('Prodotto non trovato');
      return;
    }
    
    final ProductDetails productDetails = response.productDetails.first;
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
    
    await _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }
  
  void _onPurchaseUpdate(List<PurchaseDetails> purchases) {
    for (var purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased) {
        _premiumService.setPremium(true);
      }
      
      if (purchase.pendingCompletePurchase) {
        _iap.completePurchase(purchase);
      }
    }
  }
  
  Future<void> _restorePurchases() async {
    await _iap.restorePurchases();
  }
}
