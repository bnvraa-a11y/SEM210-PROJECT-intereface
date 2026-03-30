import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A1A2E), brightness: Brightness.dark), scaffoldBackgroundColor: const Color(0xFF1A1A2E), useMaterial3: true),
  home: const TodoScreen()));

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});
  @override State<TodoScreen> createState() => _S();
}

class _S extends State<TodoScreen> {
  final _todos = <Map<String, dynamic>>[
    {'title': 'Complete Flutter project', 'done': false},
    {'title': 'Review code changes', 'done': true},
    {'title': 'Write unit tests', 'done': false},
    {'title': 'Deploy to production', 'done': false},
    {'title': 'Update documentation', 'done': true},
  ];
  final _ctrl = TextEditingController();

  void _add() { final t = _ctrl.text.trim(); if (t.isEmpty) return; setState(() => _todos.add({'title': t, 'done': false})); _ctrl.clear(); }
  void _toggle(int i) => setState(() => _todos[i]['done'] = !_todos[i]['done']);
  void _del(int i) => setState(() => _todos.removeAt(i));

  Widget _buildItem(int i) {
    final done = _todos[i]['done'] as bool;
    return Dismissible(
      key: ValueKey(i),
      onDismissed: (_) => _del(i),
      background: Container(margin: const EdgeInsets.only(bottom: 10), decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(14)), alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Icon(Icons.delete_outline, color: Colors.white)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(color: const Color(0xFF0F3460), borderRadius: BorderRadius.circular(14), border: Border.all(color: done ? const Color(0xFFE94560).withValues(alpha: 0.4) : Colors.transparent)),
        child: ListTile(
          leading: GestureDetector(onTap: () => _toggle(i), child: AnimatedContainer(duration: const Duration(milliseconds: 200), width: 24, height: 24, decoration: BoxDecoration(shape: BoxShape.circle, color: done ? const Color(0xFFE94560).withValues(alpha: 0.8) : Colors.transparent, border: Border.all(color: const Color(0xFFE94560), width: 2)), child: done ? const Icon(Icons.check, size: 14, color: Colors.white) : null)),
          title: Text(_todos[i]['title'], style: TextStyle(color: done ? const Color(0xFF6B7280) : const Color(0xFFE0E0FF), fontSize: 15, decoration: done ? TextDecoration.lineThrough : null)),
          trailing: IconButton(icon: const Icon(Icons.close_rounded, color: Color(0xFF6B7280), size: 18), onPressed: () => _del(i)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('✦ My Tasks', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22, letterSpacing: 1.2, color: Color(0xFFE0E0FF))), backgroundColor: const Color(0xFF16213E), elevation: 0),
    body: Column(children: [
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: TextField(
            controller: _ctrl, onSubmitted: (_) => _add(),
            style: const TextStyle(color: Color(0xFFE0E0FF)),
            decoration: InputDecoration(hintText: 'Add a new task...', hintStyle: const TextStyle(color: Color(0xFF6B7280)), filled: true, fillColor: const Color(0xFF0F3460), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14)),
          )),
          const SizedBox(width: 10),
          GestureDetector(onTap: _add, child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFFE94560), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.add_rounded, color: Colors.white, size: 26))),
        ]),
      ),
      Expanded(child: _todos.isEmpty
        ? const Center(child: Text('No tasks yet. Add one! 🎯', style: TextStyle(color: Color(0xFF6B7280), fontSize: 16)))
        : ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: _todos.length, itemBuilder: (_, i) => _buildItem(i))),
    ]),
  );
}
