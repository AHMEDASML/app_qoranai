import '../../../resources/type_def.dart';

class UpdateMedicinBody with Params {
  String? name;
  String? amount;
  String? times;
  String? date;
  String? instructions;

  UpdateMedicinBody(
      {this.amount, this.date, this.instructions, this.name, this.times});
  @override
  BodyMap getBody() {
    return {
      "name": name,
      "dosage": {"amount": amount},
      "schedule": {
        "times": [times],
        "date": date
      },
      "instructions": instructions,
      "isActive": false
    };
  }
}
