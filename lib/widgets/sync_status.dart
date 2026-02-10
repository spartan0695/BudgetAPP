import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../providers/auth_provider.dart';
import '../styles.dart';

class SyncStatusWidget extends StatelessWidget {
  const SyncStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final s = appStyles(context);

    return StreamBuilder<List<ConnectivityResult>>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        final connectivityResults = snapshot.data ?? [ConnectivityResult.none];
        final hasInternet = !connectivityResults.contains(ConnectivityResult.none);
        final isLoggedIn = authProvider.isLoggedIn;
        
        final isSynced = isLoggedIn && hasInternet;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: isSynced ? Colors.green.withOpacity(0.15) : Colors.grey.withOpacity(0.15),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSynced ? Colors.green.withOpacity(0.4) : Colors.grey.withOpacity(0.4),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: isSynced ? Colors.green : Colors.grey,
                  shape: BoxShape.circle,
                  boxShadow: isSynced ? [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.5),
                      blurRadius: 6,
                      spreadRadius: 2,
                    )
                  ] : [],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                isSynced ? 'Synced' : 'Not Sync',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isSynced ? Colors.green : Colors.grey,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
