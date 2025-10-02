part of 'connectivity_cubit.dart';

@immutable
sealed class ConnectivityState {
  const ConnectivityState();
}

class ConnectivityInitial extends ConnectivityState {
  const ConnectivityInitial();
}

class NoConnectivity extends ConnectivityState {
  const NoConnectivity();
}

class ConnectedConnectivity extends ConnectivityState {
  const ConnectedConnectivity({required this.connectivity});

  final List<ConnectivityResult> connectivity;
}
