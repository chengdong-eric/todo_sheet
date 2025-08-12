import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:todo_list/Providers/todo_list_provider.dart';
import 'package:todo_list/home_page.dart';

class EditableTitle extends ConsumerStatefulWidget {
  const EditableTitle({super.key});

  @override
  ConsumerState<EditableTitle> createState() => _EditableTitleState();
}

class _EditableTitleState extends ConsumerState<EditableTitle> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    // Listen for focus changes to auto-submit when user taps away
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && ref.read(isTitleEditingProvider)) {
        _submit();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final trimmedText = _controller.text.trim();
    if (trimmedText.isEmpty) {
      // If empty, revert to original title
      final originalTitle = ref.read(titleProvider);
      _controller.text = originalTitle;
    } else {
      // Save the new title
      ref.read(titleProvider.notifier).state = trimmedText;
    }
    ref.read(isTitleEditingProvider.notifier).state = false;
  }

  void _startEditing() {
    // Clear any todo that's currently being edited
    final currentlyEditingId = ref.read(editingIdProvider);
    if (currentlyEditingId != null) {
      ref.read(todoListProvider.notifier).saveAndCleanup(currentlyEditingId);
      ref.read(editingIdProvider.notifier).state = null;
    }

    // Start editing the title
    ref.read(isTitleEditingProvider.notifier).state = true;
  }

  @override
  Widget build(BuildContext context) {
    final title = ref.watch(titleProvider);
    final isEditing = ref.watch(isTitleEditingProvider);

    // Initialize controller text once
    if (!_isInitialized) {
      _controller.text = title;
      _isInitialized = true;
    }

    // Sync controller with provider when not editing
    if (!isEditing && _controller.text != title) {
      _controller.text = title;
    }

    if (isEditing) {
      return SizedBox(
        width: 200, // Give it a fixed width so it doesn't collapse
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          autofocus: true,
          style: Theme.of(context).textTheme.headlineSmall,
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            isDense: true,
          ),
          onSubmitted: (_) => _submit(),
        ),
      );
    } else {
      return GestureDetector(
        onTap: _startEditing,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(width: 4),
            SFIcon(SFIcons.sf_square_and_pencil, fontSize: 18),
          ],
        ),
      );
    }
  }
}
