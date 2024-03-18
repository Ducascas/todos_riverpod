import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  const Logger();

  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value,
      ProviderContainer container) {
    super.didAddProvider(provider, value, container);
    print('didAddProvider ${provider.name} ${value} ${provider.runtimeType}');
  }

  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    super.didUpdateProvider(provider, previousValue, newValue, container);
    print(
        'didUpdateProvider ${provider.name} ${provider.runtimeType} ${previousValue} ${newValue}');
  }
}
