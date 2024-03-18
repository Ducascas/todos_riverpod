// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_todo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$editTodoNotifierHash() => r'8d358406e126df36bc854ab77abe25a6554d3395';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$EditTodoNotifier
    extends BuildlessAutoDisposeNotifier<EditTodoState> {
  late final Todo? initialTodo;

  EditTodoState build(
    Todo? initialTodo,
  );
}

/// See also [EditTodoNotifier].
@ProviderFor(EditTodoNotifier)
const editTodoNotifierProvider = EditTodoNotifierFamily();

/// See also [EditTodoNotifier].
class EditTodoNotifierFamily extends Family<EditTodoState> {
  /// See also [EditTodoNotifier].
  const EditTodoNotifierFamily();

  /// See also [EditTodoNotifier].
  EditTodoNotifierProvider call(
    Todo? initialTodo,
  ) {
    return EditTodoNotifierProvider(
      initialTodo,
    );
  }

  @override
  EditTodoNotifierProvider getProviderOverride(
    covariant EditTodoNotifierProvider provider,
  ) {
    return call(
      provider.initialTodo,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'editTodoNotifierProvider';
}

/// See also [EditTodoNotifier].
class EditTodoNotifierProvider
    extends AutoDisposeNotifierProviderImpl<EditTodoNotifier, EditTodoState> {
  /// See also [EditTodoNotifier].
  EditTodoNotifierProvider(
    Todo? initialTodo,
  ) : this._internal(
          () => EditTodoNotifier()..initialTodo = initialTodo,
          from: editTodoNotifierProvider,
          name: r'editTodoNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editTodoNotifierHash,
          dependencies: EditTodoNotifierFamily._dependencies,
          allTransitiveDependencies:
              EditTodoNotifierFamily._allTransitiveDependencies,
          initialTodo: initialTodo,
        );

  EditTodoNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.initialTodo,
  }) : super.internal();

  final Todo? initialTodo;

  @override
  EditTodoState runNotifierBuild(
    covariant EditTodoNotifier notifier,
  ) {
    return notifier.build(
      initialTodo,
    );
  }

  @override
  Override overrideWith(EditTodoNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: EditTodoNotifierProvider._internal(
        () => create()..initialTodo = initialTodo,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        initialTodo: initialTodo,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<EditTodoNotifier, EditTodoState>
      createElement() {
    return _EditTodoNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditTodoNotifierProvider &&
        other.initialTodo == initialTodo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, initialTodo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EditTodoNotifierRef on AutoDisposeNotifierProviderRef<EditTodoState> {
  /// The parameter `initialTodo` of this provider.
  Todo? get initialTodo;
}

class _EditTodoNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<EditTodoNotifier, EditTodoState>
    with EditTodoNotifierRef {
  _EditTodoNotifierProviderElement(super.provider);

  @override
  Todo? get initialTodo => (origin as EditTodoNotifierProvider).initialTodo;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
