import 'package:flutter/material.dart';

/// Widget riutilizzabile che applica il badge "PRO" sopra il child.
/// Esegue onFeatureTap se l'utente è premium, altrimenti chiama onUpgradeRequested
class PremiumBadge extends StatelessWidget {
  final bool isPremium;
  final Widget child;
  final VoidCallback? onFeatureTap;
  final VoidCallback? onUpgradeRequested;
  final Alignment badgeAlignment;
  final String badgeText;
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

  void _handleTap(BuildContext context) {
    if (isPremium) {
      onFeatureTap?.call();
    } else {
      onUpgradeRequested?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final showBadge = !isPremium || alwaysShowBadge;

    final interactiveChild = InkWell(
      onTap: () => _handleTap(context),
      borderRadius: BorderRadius.circular(12),
      child: child,
    );

    if (!showBadge) {
      return interactiveChild;
    }

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

  // Piccolo offset per far “uscire” il badge dal bordo pulsante
  Offset _badgeOffsetFor(Alignment alignment) {
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.amber.shade600,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.shade700, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
          color: Colors.brown.shade900,
        ),
      ),
    );
  }
}
