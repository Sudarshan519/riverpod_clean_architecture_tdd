// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_task/features/home/presentation/providers/home_state_provider.dart';
import 'package:khalti_task/features/home/presentation/providers/state/home_state.dart';
import 'package:khalti_task/features/home/presentation/widgets/home_drawer.dart';

///
@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  ///
  const HomeScreen({super.key});

  ///
  static const String routeName = 'HomeScreen';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenScreenState();
}

class _HomeScreenScreenState extends ConsumerState<HomeScreen> {
  final scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  bool isSearchActive = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollControllerListener);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void scrollControllerListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      final notifier = ref.read(bankNotifierProvider.notifier);
      if (isSearchActive) {
        notifier.searchBanks(searchController.text);
      } else {
        notifier.fetchBanks();
      }
    }
  }

  void refreshScrollControllerListener() {
    scrollController
      ..removeListener(scrollControllerListener)
      ..addListener(scrollControllerListener);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bankNotifierProvider);

    ref.listen(
      bankNotifierProvider.select((value) => value),
      (BankState? previous, BankState next) {
        //show Snackbar on failure
        if (next.state == BankConcreteState.fetchedAllProducts) {
          if (next.message.isNotEmpty) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(next.message)));
          }
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: isSearchActive
            ? TextField(
                autofocus: true,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  // isDense: true,
                  isCollapsed: true,
                  hintText: 'Search here',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.3),
                    ),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                controller: searchController,
                onChanged: _onSearchChanged,
              )
            : const Text('Banks'),
        actions: [
          IconButton(
            onPressed: () {
              searchController.clear();
              setState(() {
                isSearchActive = !isSearchActive;
              });
              ref.read(bankNotifierProvider.notifier).searchBanks('');
              // ref.read(bankNotifierProvider.notifier).resetState();
              // if (!isSearchActive) {
              //   ref.read(bankNotifierProvider.notifier).fetchProducts();
              // }
              refreshScrollControllerListener();
            },
            icon: Icon(
              isSearchActive ? Icons.clear : Icons.search,
            ),
          ),
        ],
      ),
      drawer: const HomeDrawer(),
      body: state.state == BankConcreteState.loading
          ? const Center(child: CircularProgressIndicator())
          : state.hasData
              ? RefreshIndicator(
                  onRefresh: () async {
                    await ref.read(bankNotifierProvider.notifier).fetchBanks();
                  },
                  child: Column(
                    children: [
                      if (state.banklist.isEmpty) const Text('No banks found'),
                      Expanded(
                        child: Scrollbar(
                          controller: scrollController,
                          child: ListView.separated(
                            separatorBuilder: (_, __) => Divider(
                              height: .1,
                              color: Colors.grey.shade100,
                            ),
                            controller: scrollController,
                            itemCount: state.banklist.length,
                            itemBuilder: (context, index) {
                              final product = state.banklist[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey.shade200,
                                  child: CachedNetworkImage(
                                    imageUrl: product.logo ?? '',
                                    errorWidget: (_, __, ___) => const Icon(
                                      Icons.error_outline,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  product.name ?? '',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                subtitle: Text(
                                  product.address ?? '',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      if (state.state == BankConcreteState.fetchingMore)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.signal_wifi_bad,
                        size: 120,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(bankNotifierProvider.notifier).fetchBanks();
                        },
                        child: Text(
                          'Retry',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontSize: 18,
                                color: const Color.fromARGB(255, 217, 133, 127),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
      // bottomNavigationBar:
      //     _bannerAd != null ? AdWidget(ad: _bannerAd!) : Container(),
    );
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(bankNotifierProvider.notifier).searchBanks(query);
    });
  }
}
