import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mindflow/models/habit_model.dart';
// import '../models/habit.dart';

class HabitService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String get uid => _auth.currentUser!.uid;

  CollectionReference get _habitCollection => _firestore
      .collection('users')
      .doc(uid)
      .collection('habits');

  // Adicionar hábito
  Future<void> addHabit(Habit habit) async {
    await _habitCollection.add(habit.toMap());
  }

  // Atualizar hábito
  Future<void> updateHabit(Habit habit) async {
    await _habitCollection.doc(habit.id).update(habit.toMap());
  }

  // Deletar hábito
  Future<void> deleteHabit(String id) async {
    await _habitCollection.doc(id).delete();
  }

  // Ler hábitos (stream)
  Stream<List<Habit>> getHabits() {
    return _habitCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Habit.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
