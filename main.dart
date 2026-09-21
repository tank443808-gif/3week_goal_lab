import 'package:flutter/material.dart';

void main() {
  runApp(const StudyGoalApp());
}

class StudyGoal {
  StudyGoal(this.title);

  final String title;
  bool isCompleted = false;

  void toggle() {
    isCompleted = !isCompleted;
  }
}

class StudyGoalApp extends StatelessWidget {
  const StudyGoalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week 03 · Study Goal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const StudyGoalPage(),
    );
  }
}

class StudyGoalPage extends StatefulWidget {
  const StudyGoalPage({super.key});

  @override
  State<StudyGoalPage> createState() => _StudyGoalPageState();
}

class _StudyGoalPageState extends State<StudyGoalPage> {
  final _goalController = TextEditingController();
  final List<StudyGoal> _goals = [];
  String? _errorText;

  @override
  void dispose() {
    _goalController.dispose();
    super.dispose();
  }

  void _addGoal() {
    final title = _goalController.text.trim();
    if (title.isEmpty) {
      setState(() {
        _errorText = '목표를 입력하세요';
      });
      return;
    }

    if (title.length > 20) {
      setState(() {
        _errorText = '목표는 20자 이내로 입력하세요';
      });
      return;
    }

    setState(() {
      _goals.add(StudyGoal(title));
      _goalController.clear();
      _errorText = null;
    });
  }

  void _toggleGoal(StudyGoal goal) {
    setState(() {
      goal.toggle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Week 03 · Study Goal')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _goalController,
                    maxLength: 20,
                    decoration: InputDecoration(
                      labelText: '학습 목표',
                      hintText: '예: Dart 객체지향',
                      errorText: _errorText,
                      border: const OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addGoal(),
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: _addGoal,
                    child: const Text('추가'),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: _goals.isEmpty
                        ? const Center(child: Text('아직 목표가 없습니다.'))
                        : ListView.builder(
                            itemCount: _goals.length,
                            itemBuilder: (context, index) {
                              final goal = _goals[index];
                              return CheckboxListTile(
                                value: goal.isCompleted,
                                title: Text(
                                  goal.isCompleted
                                      ? '${goal.title} (완료)'
                                      : goal.title,
                                ),
                                onChanged: (_) => _toggleGoal(goal),
                              );
                            },
                          ),
                  ),
                             ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
