import 'dart:convert';

class Document {
  final Map<String, dynamic> _json;

  Document(String data) : _json = jsonDecode(data);

  List<Block> getBlocks() {
    if (_json case {'employees': List employeesJson, 'jobs': List jobsJson}) {
      return [
        for (final employeeJson in employeesJson)
          EmployeeBlock.fromJson(employeeJson),
        for (final jobJson in jobsJson) JobBlock.fromJson(jobJson),
      ];
    } else {
      throw const FormatException("Unexpected JSON format");
    }
  }
}

sealed class Block {
  Block();

  // Factory method for creating blocks
  factory Block.fromJson(Map<String, dynamic> json) {
    return switch (json['type']) {
      'employee' => EmployeeBlock.fromJson(json),
      'job' => JobBlock.fromJson(json),
      _ => throw const FormatException("Unknown block type")
    };
  }
}

class EmployeeBlock extends Block {
  final String name;
  final String description;
  final double reviews;
  final List<String> portfolio;

  EmployeeBlock(this.name, this.description, this.reviews, this.portfolio);

  factory EmployeeBlock.fromJson(Map<String, dynamic> json) {
    return EmployeeBlock(
      json['name'] as String,
      json['description'] as String,
      (json['reviews'] as num).toDouble(),
      List<String>.from(json['portfolio'] as List),
    );
  }
}

class JobBlock extends Block {
  final String title;
  final String description;
  final String employer;
  final double reviews;
  final String location;
  final List<String> photos;

  JobBlock(
    this.title,
    this.description,
    this.employer,
    this.reviews,
    this.location,
    this.photos,
  );

  factory JobBlock.fromJson(Map<String, dynamic> json) {
    return JobBlock(
      json['title'] as String,
      json['description'] as String,
      json['employer'] as String,
      (json['reviews'] as num).toDouble(),
      json['location'] as String,
      List<String>.from(json['photos'] as List),
    );
  }
}

const data = '''{
  "employees": [
    {
      "name": "John Doe",
      "description": "Experienced Carpenter and Painter.",
      "reviews": 4.5,
      "portfolio": ["carpentry.jpg", "painter.jpg"]
    },
    {
      "name": "Jane Smith",
      "description": "Skilled Electrician and Plumber.",
      "reviews": 4.8,
      "portfolio": ["electrician.jpg", "plumber.jpg"]
    }
  ],
  "jobs": [
    {
      "title": "Paint Living Room",
      "description": "Looking for a professional to paint my living room.",
      "employer": "Alice Johnson",
      "reviews": 4.3,
      "location": "123 Main St, Springfield",
      "photos": ["painter.jpg"]
    },
    {
      "title": "Fix Electrical Wiring",
      "description": "Need an electrician to fix wiring in my kitchen.",
      "employer": "Bob Brown",
      "reviews": 4.7,
      "location": "456 Elm St, Metropolis",
      "photos": ["electrician.jpg"]
    },
     {
      "title": "Fix Electrical Wiring",
      "description": "Need an electrician to fix wiring in my kitchen.",
      "employer": "Bob Brown",
      "reviews": 4.7,
      "location": "456 Elm St, Metropolis",
      "photos": ["electrician.jpg"]
    }
  ]
}''';
