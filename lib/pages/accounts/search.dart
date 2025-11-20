import 'package:chopper/chopper.dart' show Response;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/home/accounts/row.dart';

class AccountSearch extends StatefulWidget {
  const AccountSearch({super.key, required this.type});

  final AccountTypeFilter type;

  @override
  State<AccountSearch> createState() => _AccountSearchState();
}

class _AccountSearchState extends State<AccountSearch> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final int _numberOfItemsPerRequest = 50;
  PagingState<int, AccountRead> _pagingState = PagingState<int, AccountRead>();

  late AccountTypeFilter? currentFilter;
  final List<AccountTypeFilter> potentialFilters = <AccountTypeFilter>[
    AccountTypeFilter.asset,
    AccountTypeFilter.expense,
    AccountTypeFilter.revenue,
    AccountTypeFilter.liabilities,
  ];

  bool _searched = false;

  final Logger log = Logger("Pages.Accounts.Search");

  @override
  void initState() {
    super.initState();

    currentFilter = widget.type;
  }

  Future<void> _fetchPage() async {
    if (_pagingState.isLoading) return;

    try {
      final FireflyIii api = context.read<FireflyService>().api;

      final int pageKey = (_pagingState.keys?.last ?? 0) + 1;
      log.finest(
        "Getting page $pageKey (${_pagingState.pages?.length} pages loaded)",
      );

      late Response<AccountArray> respAccounts;
      if (_searchController.text.isNotEmpty) {
        respAccounts = await api.v1SearchAccountsGet(
          type: currentFilter,
          page: pageKey,
          query: _searchController.text,
          field: AccountSearchFieldFilter.all,
        );
      } else {
        respAccounts = await api.v1AccountsGet(
          type: currentFilter,
          page: pageKey,
        );
      }
      apiThrowErrorIfEmpty(respAccounts, mounted ? context : null);

      final List<AccountRead> accountList = respAccounts.body!.data;
      final bool isLastPage = accountList.length < _numberOfItemsPerRequest;
      if (mounted) {
        setState(() {
          _pagingState = _pagingState.copyWith(
            pages: <List<AccountRead>>[...?_pagingState.pages, accountList],
            keys: <int>[...?_pagingState.keys, pageKey],
            hasNextPage: !isLastPage,
            isLoading: false,
            error: null,
          );
        });
      }
    } catch (e, stackTrace) {
      log.severe("_fetchPage()", e, stackTrace);
      if (mounted) {
        setState(() {
          _pagingState = _pagingState.copyWith(error: e, isLoading: false);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> chips = <Widget>[];
    for (AccountTypeFilter accType in potentialFilters) {
      chips.add(
        AnimatedSize(
          duration: animDurationEmphasized,
          curve: animCurveEmphasized,
          alignment: Alignment.center,
          child: SizedBox(
            height: 40,
            child:
                currentFilter == accType
                    ? FilterChip(
                      label: Text(currentFilter!.friendlyName(context)),
                      onSelected: (bool selected) {
                        log.finest(
                          () => "current chip $currentFilter now $selected",
                        );
                        setState(() {
                          currentFilter = null;
                          if (_searchController.text.isEmpty) {
                            _searched = false;
                            _searchFocusNode.requestFocus();
                          } else {
                            _pagingState = _pagingState.reset();
                          }
                        });
                      },
                      selected: true,
                      visualDensity: const VisualDensity(vertical: -2),
                    )
                    : currentFilter == null
                    ? ActionChip(
                      label: Text(accType.friendlyName(context)),
                      onPressed: () {
                        log.finest(() => "chip $accType selected");
                        setState(() {
                          currentFilter = accType;
                          _searched = true;
                          _pagingState = _pagingState.reset();
                        });
                        FocusScope.of(context).unfocus();
                      },
                      avatar: Icon(accType.icon()),
                      visualDensity: const VisualDensity(vertical: -2),
                    )
                    : const SizedBox.shrink(),
          ),
        ),
      );
      if (currentFilter == null) {
        chips.add(const SizedBox(width: 8));
      }
    }
    if (currentFilter == null) {
      chips.removeLast();
    }

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          decoration: InputDecoration(
            hintText: MaterialLocalizations.of(context).searchFieldLabel,
            border: InputBorder.none,
            suffixIcon:
                _searchController.text.isNotEmpty
                    ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _searchFocusNode.requestFocus();
                        setState(() {
                          _searched = false;
                        });
                      },
                    )
                    : null,
          ),
          autofocus: true,
          onChanged:
              (_) => setState(() {
                _searched = false;
              }),
          onSubmitted:
              (_) => setState(() {
                if (!_searched) {
                  _searched = true;
                  _pagingState = _pagingState.reset();
                }
              }),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40 + 8 + 8,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: chips,
            ),
          ),
          Expanded(
            child:
                _searched
                    ? PagedListView<int, AccountRead>(
                      state: _pagingState,
                      fetchNextPage: _fetchPage,
                      builderDelegate: PagedChildBuilderDelegate<AccountRead>(
                        animateTransitions: true,
                        transitionDuration: animDurationStandard,
                        invisibleItemsThreshold: 10,
                        itemBuilder:
                            (
                              BuildContext context,
                              AccountRead item,
                              int index,
                            ) => accountRowBuilder(
                              context,
                              item,
                              index,
                              () => setState(() {
                                _pagingState = _pagingState.reset();
                              }),
                            ),
                      ),
                    )
                    : const SizedBox.expand(),
          ),
        ],
      ),
    );
  }
}
