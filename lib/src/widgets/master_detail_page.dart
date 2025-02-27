import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart' show Scaffold;
import 'package:flutter/widgets.dart';

import '/src/constants/dimens.dart';
import 'back_button.dart';
import 'divider.dart';
import 'header_bar.dart';

// |-- Narrow: Master
// |
// |-- Extended: |
// |             | Selected Item == null: Master + Empty Detail
// |             | Selected Item != null: Master + Detail
// |
// |
// |-- Narrow Master to Extended: |
// |                              | Selected Item == null: Master + Empty Detail
// |                              | Selected Item != null: Master + Detail
// |
// |-- Narrow Detail to Extended: Master + Detail
// |
// |-- Extended to Narrow: |
// |                       | Selected Item == null: Master
// |                       | Selected Item != null: Detail

/// A builder function that returns a widget based on the selected item.
typedef MasterBuilder<T> =
    Widget Function(
      BuildContext context,
      T? selectedItem,
      void Function(T item) onItemSelected,
    );

/// A builder function that returns a widget based on the item.
typedef DetailBuilder<T> = Widget Function(BuildContext context, T item);

///  A builder function that returns a widget based on the item.
typedef HeaderBuilder<T> = Widget? Function(BuildContext context, T item);

/// A builder function that returns a list of widgets based on the item.
typedef TrailingBuilder<T> =
    List<Widget>? Function(BuildContext context, T item);

/// A builder function that returns a widget based on the item.
typedef BottomBuilder<T> =
    PreferredSizeWidget? Function(BuildContext context, T item);

/// A customizable master detail page that follows Infinity's design system.
class IMasterDetailPage<T> extends StatefulWidget {
  /// Creates a new master detail page.
  ///
  /// [masterBuilder] is a function that builds the master page.
  /// [detailBuilder] is a function that builds the detail page.
  /// [items] is a list of items to display in the master page.
  /// [masterLeading] is a widget to display in the master page's leading.
  /// [masterMiddle] is a widget to display in the master page's middle.
  /// [masterTrailing] is a list of widgets to display in the master page's
  /// trailing.
  /// [masterBottom] is a widget to display in the master page's bottom.
  /// [detailHeaderMiddleBuilder] is a function that builds the detail page's
  /// header's middle.
  /// [detailTrailingBuilder] is a function that builds the detail page's
  /// trailing.
  /// [detailBottomBuilder] is a function that builds the detail page's
  /// bottom.
  /// [initialItem] is the initial item to display in the detail page.
  /// [emptyDetailWidget] is a widget to display when the detail page is empty.
  const IMasterDetailPage({
    super.key,
    required this.masterBuilder,
    required this.detailBuilder,
    required this.items,
    this.masterLeading,
    this.masterMiddle,
    this.masterTrailing,
    this.masterBottom,
    this.detailHeaderMiddleBuilder,
    this.detailTrailingBuilder,
    this.detailBottomBuilder,
    this.initialItem,
    this.emptyDetailWidget,
  });

  /// The master page's builder.
  final MasterBuilder<T> masterBuilder;

  /// The detail page's builder.
  final DetailBuilder<T> detailBuilder;

  /// The list of items to display in the master page.
  final List<T> items;

  /// The master page's leading.
  final Widget? masterLeading;

  /// The master page's middle.
  final Widget? masterMiddle;

  /// The master page's trailing.
  final List<Widget>? masterTrailing;

  ///  The master page's bottom.
  final PreferredSizeWidget? masterBottom;

  /// The detail page's header's middle builder.
  final HeaderBuilder<T>? detailHeaderMiddleBuilder;

  /// The detail page's trailing builder.
  final TrailingBuilder<T>? detailTrailingBuilder;

  /// The detail page's bottom builder.
  final BottomBuilder<T>? detailBottomBuilder;

  /// The initial item to display in the detail page.
  final T? initialItem;

  /// The widget to display when the detail page is empty.
  final Widget? emptyDetailWidget;

  @override
  State<IMasterDetailPage<T>> createState() => _IMasterDetailPageState<T>();
}

class _IMasterDetailPageState<T> extends State<IMasterDetailPage<T>> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late T? _selectedItem;
  bool _isExtended = false;

  @override
  void initState() {
    super.initState();
    _selectedItem = null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isExtended = context.isExtended();
    if (_isExtended && _selectedItem == null) {
      _selectedItem = widget.initialItem;
    }
  }

  String _itemToString(final T item) {
    if (item is Enum) {
      return (item as Enum).name;
    }
    return item.toString();
  }

  String _getItemRoute(final T item) {
    return '/${_itemToString(item)}';
  }

  String _getHeroTag(final T item) {
    return 'infinity_master_detail_${_itemToString(item)}';
  }

  void _selectItem(final T item) {
    setState(() => _selectedItem = item);

    if (!_isExtended) {
      _navigatorKey.currentState?.pushNamed(_getItemRoute(item));
    }
  }

  Route<dynamic> _onGenerateRoute(final RouteSettings settings) {
    if (settings.name == '/') {
      return CupertinoPageRoute<void>(
        settings: settings,
        builder: (final BuildContext context) => _buildMasterPage(),
      );
    }

    if (widget.items.isEmpty) {
      return CupertinoPageRoute<void>(
        settings: settings,
        builder: (final BuildContext context) => _buildMasterPage(),
      );
    }

    final String itemPath = settings.name!.substring(1);
    final T? selectedItem = widget.items.firstWhere(
      (final T item) => _itemToString(item) == itemPath,
      orElse: () => widget.items.first,
    );

    if (selectedItem == null) {
      return CupertinoPageRoute<void>(
        settings: settings,
        builder: (final BuildContext context) => _buildMasterPage(),
      );
    }

    return CupertinoPageRoute<void>(
      settings: settings,
      builder: (final BuildContext context) => _buildDetailPage(selectedItem),
    );
  }

  Widget _buildMasterPage() {
    return Scaffold(
      appBar: IHeaderBar(
        leading: widget.masterLeading,
        middle: widget.masterMiddle,
        trailing: widget.masterTrailing,
        bottom: widget.masterBottom,
      ),
      body: widget.masterBuilder(context, _selectedItem, _selectItem),
    );
  }

  Widget _buildDetailPage(final T item) {
    return Scaffold(
      appBar: IHeaderBar(
        leading:
            _isExtended
                ? null
                : IBackButton(
                  onPressed: () {
                    _navigatorKey.currentState?.pop();
                    setState(() => _selectedItem = null);
                  },
                ),
        middle: widget.detailHeaderMiddleBuilder?.call(context, item),
        trailing: widget.detailTrailingBuilder?.call(context, item),
        bottom: widget.detailBottomBuilder?.call(context, item),
      ),
      body: Hero(
        tag: _getHeroTag(item),
        child: widget.detailBuilder(context, item),
      ),
    );
  }

  Widget _buildEmptyDetail() {
    return Scaffold(
      appBar: const IHeaderBar(),
      body: widget.emptyDetailWidget ?? const SizedBox.expand(),
    );
  }

  @override
  Widget build(final BuildContext context) {
    if (_isExtended) {
      return Row(
        children: <Widget>[
          SizedBox(
            width: InfinityDimens.sidebarWidth,
            child: _buildMasterPage(),
          ),
          const IVerticalDivider(),
          Expanded(
            child:
                _selectedItem != null
                    ? _buildDetailPage(_selectedItem as T)
                    : _buildEmptyDetail(),
          ),
        ],
      );
    }

    return WillPopScope(
      onWillPop: () async {
        if (_navigatorKey.currentState?.canPop() ?? false) {
          _navigatorKey.currentState?.pop();
          setState(() => _selectedItem = null);
          return false;
        }
        return true;
      },
      child: Navigator(
        key: _navigatorKey,
        initialRoute:
            _selectedItem != null ? _getItemRoute(_selectedItem as T) : '/',
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }
}
