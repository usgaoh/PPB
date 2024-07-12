class Pertanyaan {
  int? id;
  String? titleController;
  String? nameController;
  String? emailController;
  String? phoneController;
  String? question1Controller;
  String? question2Controller;
  String? question3Controller;

  Pertanyaan({
    this.id,
    this.titleController,
    this.nameController,
    this.emailController,
    this.phoneController,
    this.question1Controller,
    this.question2Controller,
    this.question3Controller,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'titleController': titleController,
      'nameController': nameController,
      'emailController': emailController,
      'phoneController': phoneController,
      'question1Controller': question1Controller,
      'question2Controller': question2Controller,
      'question3Controller': question3Controller,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Pertanyaan.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    titleController = map['titleController'];
    nameController = map['nameController'];
    emailController = map['emailController'];
    phoneController = map['phoneController'];
    question1Controller = map['question1Controller'];
    question2Controller = map['question2Controller'];
    question3Controller = map['question3Controller'];
  }
}
