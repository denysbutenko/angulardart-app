library charge_list;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';

@Controller(
    selector: '[charge-list]',
    publishAs: 'ctrl'
)
class ChargeController {
  List<Charge> charges;
  int amount;
  String comment;

  ChargeController() {
    charges = _loadData();
  }

  void addCharge() {
    charges.add(new Charge(amount, comment));
    amount = null;
    comment = '';
  }

  List<Charge> _loadData() {
    return [
        new Charge(5, 'Charge #1'),
        new Charge(10, 'Charge #2'),
        new Charge(15, 'Charge #3'),
        new Charge(20, 'Charge #4'),
        new Charge(25, 'Charge #5'),
    ];
  }
}

class Charge {
  int amount;
  String comment;

  Charge(this.amount, this.comment);
}

class ChargeModule extends Module {
  ChargeModule() {
    bind(ChargeController);
  }
}

void main() {
  applicationFactory()
  .addModule(new ChargeModule())
  .run();
}