import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/Providers/todo_list_provider.dart';
import 'package:todo_list/home_page.dart';

class EditableTitle extends ConsumerStatefulWidget {
  const EditableTitle({super.key});

  @override
  ConsumerState<EditableTitle> createState() => _EditableTitleState();
}

class _EditableTitleState extends ConsumerState<EditableTitle> {
  late final TextEditingController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: ref.read(titleProvider));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final trimmedText = _controller.text.trim();
    if (trimmedText.isEmpty) {
      _controller.text = ref.read(titleProvider);
    } else {
      ref.read(titleProvider.notifier).state = _controller.text;
    }
    ref.read(isTitleEditingProvider.notifier).state = false;
  }

  void _startEditing() {
    final notifier = ref.read(todoListProvider.notifier);
    final currentlyEditingId = ref.read(editingIdProvider);

    if (currentlyEditingId != null) {
      notifier.saveAndCleanup(currentlyEditingId);
      ref.read(editingIdProvider.notifier).state = null;
    }

    ref.read(isTitleEditingProvider.notifier).state = true;
  }

  @override
  Widget build(BuildContext context) {
    final title = ref.watch(titleProvider);
    final isEditing = ref.watch(isTitleEditingProvider);
    if (!_isInitialized) {
      _controller.text = title;
      _isInitialized = true;
    }

    if (!isEditing && _controller.text != title) {
      _controller.text = title;
    }
    if (isEditing) {
      return TextField(
        controller: _controller,
        autocorrect: true,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.titleLarge,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onSubmitted: (_) => _submit(),
        onTapOutside: (_) => _submit(),
      );
    } else {
      return GestureDetector(onTap: _startEditing, child: Text(title));
    }
  }
}
