import 'package:flutter/material.dart';
import 'package:budget_app/widgets/paywall_dialog.dart';

/// Widget riutilizzabile che applica un badge "PRO" sopra un child
/// e gestisce automaticamente tap/paywall in base allo stato premium.
/// 
/// Uso tipico:
/// PremiumBadge(
///   isPremium: PremiumService().isPremium,
///   onFeatureTap: _openAdvancedFeature, // chiamato solo se premium
///   onUpgradeRequested: _goToPremiumPage, // apri pagina di upgrade
///   child: ElevatedButton(onPressed: null, child: Text('Funzionalità')),
/// )
class PremiumBadge extends StatelessWidget {
  final bool isPremium;

  // Child da decorare con badge PRO (se non premium).
  final Widget child;

  // Chiamato quando l’utente tocca il child e ha premium attivo.
  final VoidCallback? onFeatureTap;

  // Chiamato quando l’utente tenta di usare la feature ma non è premium.
  // Se non lo fornisci, verrà mostrato un semplice dialog di paywall interno.
  final VoidCallback? onUpgradeRequested;

  // Posizionamento del badge “PRO”.
  final Alignment badgeAlignment;

  // Testo del badge (default: "PRO").
  final String badgeText;

  // Se true, disegna sempre il badge anche se premium (utile per branding).
  final bool alwaysShowBadge;

  const PremiumBadge({
    Key? key,
    required this.isPremium,
    required this.child,
    this.onFeatureTap,
    this.onUpgradeRequested,
    this.badgeAlignment = Alignment.topRight,
    this.badgeText = 'PRO',
    this.alwaysShowBadge = false,
  }) : super(key: key);

  void _defaultShowPaywall(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock, size: 56, color: Theme.of(ctx).colorScheme.primary),
                  const SizedBox(height: 12),
                  const Text(
                    'Funzionalità Premium',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Questa funzione è disponibile nella versione Premium.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(ctx).textTheme.bodyMedium?.color?.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _PaywallPoint(text: 'Transazioni ricorrenti illimitate'),
                      _PaywallPoint(text: 'Proiezioni future avanzgate'),
                      _PaywallPoint(text: 'Statistiche dettagliate e export'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    
                    },
                    icon: const Icon(Icons.star),
                    label: const Text('Scopri Premium'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Forse più tardi'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleTap(BuildContext context) {
    if (isPremium) {
      onFeatureTap?.call();
    } else {
      if (onUpgradeRequested != null) {
        onUpgradeRequested!.call();
      } else {
        _defaultShowPaywall(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final showBadge = (!isPremium) || (alwaysShowBadge);

    // Avvolge il child per intercettare il tap; se il child ha già onPressed,
    // si preferisce centralizzare qui la logica premium.
    final interactiveChild = InkWell(
      onTap: () => _handleTap(context),
      borderRadius: BorderRadius.circular(12),
      child: child,
    );

    if (!showBadge) {
      // Nessun badge: ritorna solo il child tappabile che chiama onFeatureTap.
      return interactiveChild;
    }

    // Disegna badge sopra al child con Stack + Align.
    return Stack(
      clipBehavior: Clip.none,
      children: [
        interactiveChild,
        Align(
          alignment: badgeAlignment,
          child: Transform.translate(
            offset: _badgeOffsetFor(badgeAlignment),
            child: _ProBadge(text: badgeText),
          ),
        ),
      ],
    );
  }

  // Sposta leggermente il badge fuori dal bordo per un look migliore.
  Offset _badgeOffsetFor(Alignment alignment) {
    const double dx = 10;
    const double dy = 10;
    if (alignment == Alignment.topRight) return const Offset(8, -8);
    if (alignment == Alignment.topLeft) return const Offset(-8, -8);
    if (alignment == Alignment.bottomRight) return const Offset(8, 8);
    if (alignment == Alignment.bottomLeft) return const Offset(-8, 8);
    return const Offset(0, 0);
  }
}

class _ProBadge extends StatelessWidget {
  final String text;
  const _ProBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    final bg = Colors.amber.shade600;
    final fg = Colors.brown.shade900;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.amber.shade700, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
          color: fg,
        ),
      ),
    );
  }
}

class _PaywallPoint extends StatelessWidget {
  final String text;
  const _PaywallPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 16, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 6),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
