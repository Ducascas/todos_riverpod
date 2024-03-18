import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

// part 'todo.freezed.dart';
part 'todo.g.dart';

// @freezed
// class Todo with _$Todo {  
//   @Assert('id == null || id.isNotEmpty', 'id must either be null or not empty')
//   const factory Todo({
//     required String title,
//     String? id,
//     @Default('') String description,
//     @Default(false) bool isCompleted,
//   }) = _Todo;

//   factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
// }

@JsonSerializable()
class Todo extends Equatable {

  Todo({
    required this.title,
    String? id,
    this.description = '',
    this.isCompleted = false,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  static Todo fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  @override
  List<Object> get props => [id, title, description, isCompleted];
}
