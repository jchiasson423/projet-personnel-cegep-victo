import 'package:budget_maker_app/utilities/entities/budget_entity.dart';
import 'package:budget_maker_app/utilities/entities/model_entity.dart';
import 'package:budget_maker_app/utilities/entities/project_entity.dart';
import 'package:budget_maker_app/utilities/services/database/account_service.dart';
import 'package:budget_maker_app/utilities/services/database/budget_service.dart';
import 'package:budget_maker_app/utilities/services/database/model_service.dart';
import 'package:budget_maker_app/utilities/services/database/project_service.dart';

/// Service pour les entités
class Services {
  /// Service pour les budgets
  static final BudgetService budgets = BudgetService(fromMap: Budget.fromMap);

  /// Service pour les modèles
  static final ModelService models = ModelService(fromMap: Model.fromMap);

  /// Service pour les projets
  static final ProjectService projects =
      ProjectService(fromMap: Project.fromMap);

  /// Service pour les comptes
  static final AccountService account = AccountService();
}
