import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_huevo/core/extension/context.dart';
import 'package:flutter_huevo/feature/connectivity/bloc/connectivity_cubit.dart';
import 'package:flutter_huevo/feature/explore/ui/widget/explore_card.dart';

class ConnectivityCard extends StatelessWidget {
  const ConnectivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final result = context.watch<ConnectivityCubit>().state;
    final connectivity = result is ConnectedConnectivity
        ? result.connectivity
        : null;

    return ExploreCard(
      title: context.l10n.connectivity,
      content: Text(connectivity?.map((e) => e.name).join(', ') ?? '-'),
    );
  }
}
