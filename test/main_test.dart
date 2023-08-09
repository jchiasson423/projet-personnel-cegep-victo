import 'package:budget_maker_app/utilities/entities/budget_entity.dart';
import 'package:budget_maker_app/utilities/entities/model_entity.dart';
import 'package:budget_maker_app/utilities/entities/project_entity.dart';
import 'package:budget_maker_app/utilities/models/money_entry_model.dart';
import 'package:budget_maker_app/utilities/models/project_entry_model.dart';
import 'package:test/test.dart';

/// Tests unitaires
void main() {
  test(
    'testModel',
    () {
      testModel();
    },
  );
  test(
    'testProject',
    () {
      testProject();
    },
  );
  test(
    'testBudget',
    () {
      testBudget();
    },
  );
}

void testModel() {
  var test = Model(
    name: 'test',
    userId: 'test',
    id: 'test',
    incomes: [
      MoneyEntry(name: 'test', amount: 246.9),
    ],
    expenses: [
      MoneyEntry(name: 'test', amount: 123.45),
    ],
    projectEntries: [
      ProjectEntry(projectId: 'test', amount: 123.45),
    ],
  );

  expect(test.total, 0);

  var json = test.toJson();

  var newTest = Model.fromJson(json);

  expect(newTest, test);
}

void testProject() {
  var date1 = DateTime.now().add(const Duration(days: 15));
  var date2 = DateTime.now().add(const Duration(days: 30));

  var test = Project(
    id: 'test',
    name: 'test',
    objective: 123.45,
    currentAmount: 0,
    objectiveDate: date2,
    entries: [
      ProjectEntry(
        projectId: 'test',
        amount: 123.45,
        realAmount: 123.45,
        entryDate: date1,
      ),
      ProjectEntry(
        projectId: 'test',
        amount: 123.45,
        realAmount: 123.45,
        entryDate: date2,
      ),
    ],
  );

  expect(test.accomplishmentDate, date1);
  expect(test.accomplishedAtDate, true);
  expect(test.amountAtDate, 123.45);

  var json = test.toJson();

  var newTest = Project.fromJson(json);

  test.entries = [];

  expect(newTest, test);
}

void testBudget() {
  var test = Budget(
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 30)),
    userId: 'test',
    id: 'test',
    incomes: [
      MoneyEntry(name: 'test', amount: 246.9, receivedAmount: 123.45),
    ],
    expenses: [
      MoneyEntry(name: 'test', amount: 123.45, receivedAmount: 123.45),
    ],
    projectEntries: [
      ProjectEntry(projectId: 'test', amount: 123.45, realAmount: 123.45),
    ],
  );

  expect(test.total, 0);

  expect(test.realAccountAmout(0), 123.45);

  var json = test.toJson();

  var newTest = Budget.fromJson(json);

  expect(newTest, test);
}
