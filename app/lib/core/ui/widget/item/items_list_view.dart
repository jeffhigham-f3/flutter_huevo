import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_huevo/core/bloc/value_stream_cubit.dart';
import 'package:flutter_huevo/core/extension/context.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ItemsListView<T, C extends ValueStreamCubit<List<T>>>
    extends StatelessWidget {
  const ItemsListView({
    required this.itemBuilder,
    this.emptyBuilder,
    this.padding = 16,
    this.itemPadding = 16,
    super.key,
  });

  final ItemWidgetBuilder<T> itemBuilder;
  final WidgetBuilder? emptyBuilder;
  final double padding;
  final double itemPadding;

  @override
  Widget build(BuildContext context) {
    final itemsState = context.watch<C>().state;
    switch (itemsState) {
      case ValueInitial<List<T>>():
        return const Center(child: CircularProgressIndicator());
      case ValueError<List<T>>():
        return Center(child: Text(itemsState.error.getText(context)));
      case ValueLoaded<List<T>>():
        final items = itemsState.value;
        if (items.isEmpty) {
          final messageWidget =
              emptyBuilder?.call(context) ?? Text(context.l10n.listIsEmpty);

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: messageWidget,
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.all(padding),
          itemCount: items.length,
          itemBuilder: (context, index) => itemBuilder(context, items[index]),
          separatorBuilder: (context, index) => SizedBox(height: itemPadding),
        );
    }
  }
}
