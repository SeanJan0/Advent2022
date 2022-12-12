import 'dart:io';

void main() {
  // part 1

  var monkeys = generateMonkeys();

  for (var i = 0; i < 20; i++) {
    for (Monkey monke in monkeys) {
      while (monke.items.length > 0) {
        var item = monke.items.removeAt(0);
        item = monke.calcWorry(item) ~/ 3;
        if (item % monke.test == 0) {
          monke.pass.items.add(item);
        } else {
          monke.fail.items.add(item);
        }
        monke.activity++;
      }
    }
  }

  var activies = monkeys.map((e) => e.activity).toList();
  activies.sort(((a, b) => b.compareTo(a)));
  print(activies[0] * activies[1]);

  // part 2

  monkeys = generateMonkeys();
  var monkeyTests = monkeys.map((e) => e.test).toList();
  var lcm = monkeyTests.reduce((a, b) => a * b);

  for (var i = 0; i < 10000; i++) {
    for (Monkey monke in monkeys) {
      while (monke.items.length > 0) {
        var item = monke.items.removeAt(0) % lcm;
        item = monke.calcWorry(item);
        if (item % monke.test == 0) {
          monke.pass.items.add(item);
        } else {
          monke.fail.items.add(item);
        }
        monke.activity++;
      }
    }
  }

  activies = monkeys.map((e) => e.activity).toList();
  activies.sort(((a, b) => b.compareTo(a)));
  print(activies[0] * activies[1]);
}

List<Monkey> generateMonkeys() {
  var input = File('day11/day11.txt').readAsStringSync().split('\r\n\r\n');

  var monkeys = List.generate(input.length, (index) => Monkey());

  for (var i = 0; i < input.length; i++) {
    var line = input[i].split('\r\n');

    var itemsRaw = line[1].split(': ')[1].split(',');
    var items = itemsRaw.map((e) => int.parse(e)).toList();

    var operation = line[2].split('= ')[1].split(' ');

    var test = int.parse(line[3].split(' ').last);
    var passIndex = int.parse(line[4].split(' ').last);
    var failIndex = int.parse(line[5].split(' ').last);

    monkeys[i].items = items;
    monkeys[i].operation = operation;
    monkeys[i].test = test;
    monkeys[i].pass = monkeys[passIndex];
    monkeys[i].fail = monkeys[failIndex];
  }

  return monkeys;
}

class Monkey {
  late List<int> items;
  late List<String> operation;
  late int test;
  late Monkey pass;
  late Monkey fail;
  int activity = 0;

  int calcWorry(var item) {
    var first = 0;
    var second = 0;

    if (this.operation[0] == 'old') {
      first = item;
    } else {
      first = int.parse(this.operation[0]);
    }

    if (this.operation[2] == 'old') {
      second = item;
    } else {
      second = int.parse(this.operation[2]);
    }

    var result = 0;
    if (this.operation[1] == '+') {
      result = first + second;
    } else {
      result = first * second;
    }

    return result;
  }
}
