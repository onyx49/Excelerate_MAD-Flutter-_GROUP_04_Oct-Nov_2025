import 'dart:convert';
import 'package:flutter/material.dart' hide Feedback;
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:group_04_app/model/jsonmodel.dart';

class FeedbackModel {
  String id;
  String fromUserId;
  String toUserId;
  String programId;
  double rating;
  String comment;
  DateTime createdAt;

  FeedbackModel({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.programId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'].toString(),
      fromUserId: json['fromUserId'].toString(),
      toUserId: json['toUserId'].toString(),
      programId: json['programId'].toString(),
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      comment: json['comment'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fromUserId': fromUserId,
        'toUserId': toUserId,
        'programId': programId,
        'rating': rating,
        'comment': comment,
        'createdAt': createdAt.toIso8601String(),
      };
}

class FeedbackScreen extends StatefulWidget {
  final bool isLearner;
  final String currentUserId;

  const FeedbackScreen({
    super.key,
    required this.isLearner,
    required this.currentUserId,
  });

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _commentController = TextEditingController();
  double _currentRating = 0.0;

  List<Userjsonmodel> _allUsers = [];
  List<FeedbackModel> _allFeedbacks = [];

  String? _selectedUserId;
  bool _loading = true;

  final String usersUrl =
      'https://my-json-server.typicode.com/onyx49/Excelerate_MAD-Flutter-_GROUP_04_Oct-Nov_2025/users';
  final String feedbackUrl =
      'https://my-json-server.typicode.com/onyx49/Excelerate_MAD-Flutter-_GROUP_04_Oct-Nov_2025/feedbacks';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final usersResponse = await http.get(Uri.parse(usersUrl));
      final feedbackResponse = await http.get(Uri.parse(feedbackUrl));

      if (usersResponse.statusCode == 200 && feedbackResponse.statusCode == 200) {
        final List<dynamic> usersData = jsonDecode(usersResponse.body);
        final List<dynamic> feedbackData = jsonDecode(feedbackResponse.body);

        _allUsers =
            usersData.map((e) => Userjsonmodel.fromJson(e)).toList();
        _allFeedbacks =
            feedbackData.map((e) => FeedbackModel.fromJson(e)).toList();

        List<Userjsonmodel> filteredUsers = [];
        if (widget.isLearner) {
          filteredUsers =
              _allUsers.where((u) => u.role == "educator").toList();
        } else {
          filteredUsers =
              _allUsers.where((u) => u.role == "learner").toList();
        }

        setState(() {
          _allUsers = filteredUsers;
          if (filteredUsers.isNotEmpty) {
            _selectedUserId = filteredUsers.first.id.toString();
          }
          _loading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint('Error fetching feedback data: $e');
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _submitFeedback() async {
    if (_currentRating == 0 || _commentController.text.isEmpty) return;

    final newFeedback = FeedbackModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fromUserId: widget.currentUserId,
      toUserId: _selectedUserId!,
      programId: "1", // placeholder
      rating: _currentRating,
      comment: _commentController.text,
      createdAt: DateTime.now(),
    );

    // NOTE: JSONPlaceholder (typicode) is read-only; this will not persist.
    // But you can simulate saving feedback:
    try {
      await http.post(
        Uri.parse(feedbackUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(newFeedback.toJson()),
      );

      setState(() {
        _allFeedbacks.add(newFeedback);
        _commentController.clear();
        _currentRating = 0.0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Feedback submitted successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      debugPrint("Error submitting feedback: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to submit feedback."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final feedbacksForUser = _allFeedbacks
        .where((f) => f.toUserId == _selectedUserId)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F7FB),
      appBar: AppBar(
        title: Text(
          widget.isLearner ? "Provide Feedback" : "View Student Feedback",
          style: const TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
      ),
      body: _allUsers.isEmpty
          ? const Center(child: Text("No users found"))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildUserSelector(),
                  const SizedBox(height: 16),
                  _buildFeedbackList(feedbacksForUser),
                  const SizedBox(height: 20),
                  if (widget.isLearner) _buildFeedbackForm(),
                ],
              ),
            ),
    );
  }

  Widget _buildUserSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        value: _selectedUserId,
        isExpanded: true,
        underline: const SizedBox(),
        items: _allUsers.map((user) {
          return DropdownMenuItem<String>(
            value: user.id.toString(),
            child: Text("${user.email} (${user.role})"),
          );
        }).toList(),
        onChanged: (val) => setState(() => _selectedUserId = val),
      ),
    );
  }

  Widget _buildFeedbackList(List<FeedbackModel> feedbacks) {
    if (feedbacks.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text("No feedback available"),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: feedbacks.length,
        itemBuilder: (context, index) {
          final fb = feedbacks[index];
          final fromUser = _allUsers
              .firstWhere((u) => u.id.toString() == fb.fromUserId,
                  orElse: () => Userjsonmodel(
                      id: 0, email: "Unknown", role: "Unknown"));
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.deepPurple[100],
                      child: Text(fromUser.email![0].toUpperCase()),
                    ),
                    const SizedBox(width: 10),
                    Text(fromUser.email!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                    const Spacer(),
                    _buildStars(fb.rating),
                  ],
                ),
                const SizedBox(height: 8),
                Text(fb.comment,
                    style:
                        const TextStyle(fontSize: 14, color: Colors.black87)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeedbackForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Give Feedback",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              return IconButton(
                icon: Icon(
                  i < _currentRating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () => setState(() => _currentRating = i + 1.0),
              );
            }),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _commentController,
            decoration: InputDecoration(
              labelText: "Your feedback...",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed:
                _currentRating > 0 && _commentController.text.isNotEmpty
                    ? _submitFeedback
                    : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text("Submit Feedback",
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildStars(double rating) {
    return Row(
      children: List.generate(
        5,
        (i) => Icon(
          i < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        ),
      ),
    );
  }
}
