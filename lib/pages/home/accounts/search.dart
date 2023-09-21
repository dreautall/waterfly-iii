import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:chopper/chopper.dart' show Response;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/home/accounts/row.dart';

class AccountSearch extends StatefulWidget {
  const AccountSearch({
    super.key,
    required this.type,
  });

  final AccountTypeFilter type;

  @override
  State<AccountSearch> createState() => _AccountSearchState();
}

class _AccountSearchState extends State<AccountSearch> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final int _numberOfItemsPerRequest = 50;
  final PagingController<int, AccountRead> _pagingController =
      PagingController<int, AccountRead>(
    firstPageKey: 1,
    invisibleItemsThreshold: 10,
  );

  late AccountTypeFilter? currentFilter;
  final List<AccountTypeFilter> potentialFilters = <AccountTypeFilter>[
    AccountTypeFilter.asset,
    AccountTypeFilter.expense,
    AccountTypeFilter.revenue,
    AccountTypeFilter.liabilities
  ];

  String _lastSearch = "";

  final Logger log = Logger("Pages.Accounts.Search");

  @override
  void initState() {
    super.initState();

    currentFilter = widget.type;

    _pagingController.addPageRequestListener((int pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();

    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final FireflyIii api = context.read<FireflyService>().api;
      late Response<AccountArray> respAccounts;
      if (_searchController.text.isNotEmpty) {
        respAccounts = await api.v1SearchAccountsGet(
          type: currentFilter,
          page: pageKey,
          query: _searchController.text,
          field: AccountSearchFieldFilter.all,
        );
        _lastSearch = _searchController.text;
      } else {
        respAccounts = await api.v1AccountsGet(
          type: currentFilter,
          page: pageKey,
        );
      }
      if (!respAccounts.isSuccessful || respAccounts.body == null) {
        if (context.mounted) {
          throw Exception(
            S
                .of(context)
                .errorAPIInvalidResponse(respAccounts.error?.toString() ?? ""),
          );
        } else {
          throw Exception(
            "[nocontext] Invalid API response: ${respAccounts.error}",
          );
        }
      }

      if (mounted) {
        final List<AccountRead> accountList = respAccounts.body!.data;
        final bool isLastPage = accountList.length < _numberOfItemsPerRequest;
        if (isLastPage) {
          _pagingController.appendLastPage(accountList);
        } else {
          final int nextPageKey = pageKey + 1;
          _pagingController.appendPage(accountList, nextPageKey);
        }
      }
    } catch (e, stackTrace) {
      log.severe("_fetchPage($pageKey)", e, stackTrace);
      _pagingController.error = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> chips = <Widget>[];
    if (currentFilter != null) {
      chips.add(
        FilterChip(
          label: Text(currentFilter!.friendlyName(context)),
          onSelected: (bool selected) {
            log.finest(() => "current chip $currentFilter now $selected");
            setState(() {
              currentFilter = null;
            });
            _pagingController.refresh();
          },
          selected: true,
          visualDensity: const VisualDensity(vertical: -2),
        ),
      );
    } else {
      for (AccountTypeFilter accType in potentialFilters) {
        chips.add(
          ActionChip(
            label: Text(accType.friendlyName(context)),
            onPressed: () {
              log.finest(() => "chip $accType selected");
              setState(() {
                currentFilter = accType;
              });
              _pagingController.refresh();
            },
            avatar: Icon(accType.icon()),
            visualDensity: const VisualDensity(vertical: -2),
          ),
        );
        chips.add(const SizedBox(width: 8));
      }
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
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      if (_lastSearch.isNotEmpty) {
                        _pagingController.refresh();
                      }

                      _searchFocusNode.requestFocus();
                      setState(() {
                        _lastSearch = "";
                      });
                    })
                : null,
          ),
          autofocus: true,
          onChanged: (_) => setState(() {}),
          onSubmitted: (_) => _pagingController.refresh(),
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
            child: PagedListView<int, AccountRead>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<AccountRead>(
                itemBuilder: accountRowBuilder,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
