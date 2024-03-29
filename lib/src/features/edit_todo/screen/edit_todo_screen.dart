import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos_riverpod/src/common/common.dart';
import 'package:todos_riverpod/src/features/edit_todo/edit_todo.dart';

class EditTodoPage extends ConsumerWidget {
  const EditTodoPage(this.initialTodo, {super.key});
  final Todo? initialTodo;

  static Route<void> route({Todo? initialTodo}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => EditTodoPage(initialTodo),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      editTodoNotifierProvider(initialTodo).select((state) => state.status),
      ((previous, next) {
        if (previous != next) {
          if (next == EditTodoStatus.success) {
            Navigator.of(context).pop();
          }
        }
      }),
    );
    return EditTodoScreen(initialTodo);
  }
}

class EditTodoScreen extends ConsumerWidget {
  const EditTodoScreen(this.initialTodo, {super.key});
  final Todo? initialTodo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final editTodo = ref.watch(editTodoNotifierProvider(initialTodo));
    final status = editTodo.status;
    final isNewTodo = editTodo.isNewTodo;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewTodo
              ? l10n.editTodoAddAppBarTitle
              : l10n.editTodoEditAppBarTitle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: l10n.editTodoSaveButtonTooltip,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        onPressed: status.isLoadingOrSuccess
            ? null
            : () => ref
                .read(editTodoNotifierProvider(initialTodo).notifier)
                .onSubmitted(),
        child: status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.check_rounded),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _TitleField(initialTodo),
                _DescriptionField(initialTodo)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleField extends ConsumerWidget {
  const _TitleField(this.initialTodo);

  final Todo? initialTodo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final editTodoState = ref.watch(editTodoNotifierProvider(initialTodo));
    final hintText = editTodoState.initialTodo?.title ?? '';

    return TextFormField(
      key: const Key('editTodoView_title_textFormField'),
      initialValue: editTodoState.title,
      decoration: InputDecoration(
          enabled: !editTodoState.status.isLoadingOrSuccess,
          labelText: l10n.editTodoTitleLabel,
          hintText: hintText),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) => ref
          .read(editTodoNotifierProvider(initialTodo).notifier)
          .onTitleChanged(value),
    );
  }
}

class _DescriptionField extends ConsumerWidget {
  const _DescriptionField(this.initialTodo);
  final Todo? initialTodo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final editTodoState = ref.watch(editTodoNotifierProvider(initialTodo));
    final hintText = editTodoState.initialTodo?.description ?? '';

    return TextFormField(
      key: const Key('editTodoView_description_textFormField'),
      initialValue: editTodoState.description,
      decoration: InputDecoration(
        enabled: !editTodoState.status.isLoadingOrSuccess,
        labelText: l10n.editTodoDescriptionLabel,
        hintText: hintText,
      ),
      maxLength: 300,
      maxLines: 7,
      inputFormatters: [
        LengthLimitingTextInputFormatter(300),
      ],
      onChanged: (value) => ref
          .read(editTodoNotifierProvider(initialTodo).notifier)
          .onDescriptionChanged(value),
    );
  }
}
