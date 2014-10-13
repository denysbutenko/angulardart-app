library charge_list;

import 'dart:html';
import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';

@Controller(selector: '[charge-list]', publishAs: 'ctrl')
class ChargeController {
  Storage localStorage = window.localStorage;
  List<Charge> charges;
  int amount;
  String comment;
  DateTime date = new DateTime.now();

  ChargeController() {
    charges = _loadData();
  }

  void addCharge() {
    DateTime new_date = new DateTime.now();
    var ob = {
        'amount' : amount, 'comment' : comment, 'date' : new_date.toString()
    };
    charges.add(new Charge.fromMap(ob));
    saveChargesInLocalStore(charges);

    amount = null;
    comment = '';
  }

  int getTotal() {
    int total = 0;
    for (var charge in charges) {
      total += charge.amount;
    }
    return total;
  }

  List<Charge> _loadData() {
    List<Charge> charges = new List();
    if (window.localStorage.containsKey('charges')) {
      String json = window.localStorage['charges'];
      List list = JSON.decode(json);
      for (Map ob in list) {
        Charge charge = new Charge.fromMap(ob);
        charges.add(charge);
      }
    }
    return charges;
  }

  Map _toEncodable(Charge charge) {
    return {
        'amount' : charge.amount, 'comment' : charge.comment, 'date' : charge.date
    };
  }

  void saveChargesInLocalStore(List<Charge> charges) {
    String json = JSON.encode(charges, toEncodable: _toEncodable);
    print(json);
    window.localStorage['charges'] = json;
  }

}

class Charge {
  int amount;
  String comment;
  DateTime date;

  factory Charge.fromMap(Map map) {
    return new Charge._internal(map['amount'], map['comment'], map['date']);
  }

  Charge._internal(this.amount, this.comment, this.date);

  Charge(this.amount, this.comment, this.date);
}

class ChargeModule extends Module {
  ChargeModule() {
    bind(ChargeController);
  }
}

void main() {
  applicationFactory().addModule(new ChargeModule()).run();
}