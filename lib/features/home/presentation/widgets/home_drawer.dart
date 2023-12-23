import 'package:flutter/material.dart';
import 'package:khalti_task/services/user_cache_service/domain/providers/current_user_provider.dart';
import 'package:khalti_task/shared/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider).asData?.value;

    return SafeArea(
      bottom: false,
      child: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
              ),
              accountName: Text(
                currentUser?.firstName ?? "User",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              accountEmail: Text(
                currentUser?.email ?? "user@email.com",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              currentAccountPicture: const CircleAvatar(
                child: FlutterLogo(
                  size: 50,
                ),
              ),
              otherAccountsPictures: [
                InkWell(
                  onTap: () async {},
                  child: CircleAvatar(
                    child: Icon(
                      Icons.logout,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    ref.read(appThemeProvider.notifier).toggleTheme();
                  },
                  child: CircleAvatar(
                    child: Icon(
                      Theme.of(context).brightness == Brightness.dark
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
