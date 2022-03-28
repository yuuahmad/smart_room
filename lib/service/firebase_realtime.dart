import 'package:firebase_database/firebase_database.dart';

class Message {
  final String text;
  final DateTime date;

  Message(this.text, this.date);

  Message.fromJson(Map<dynamic, dynamic> json)
      : date = DateTime.parse(json['date'] as String),
        text = json['text'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'date': date.toString(),
        'text': text,
      };
}

class MessageDao {
  final DatabaseReference _messagesRef = FirebaseDatabase.instance.ref().child('messages');

  void saveMessage(Message message) {
    _messagesRef.push().set(message.toJson());
  }

  Query getMessageQuery() {
    return _messagesRef;
  }
}
