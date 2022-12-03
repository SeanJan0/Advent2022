// part 1

string[] text = File.ReadAllLines("day3.txt");  

int totalPriority = 0;

foreach (string l in text) {
    string secondHalf = l.Substring(l.Length / 2);
    for (int i = 0; i < l.Length / 2; i++) {
        if (secondHalf.Contains(l[i])) {
            int priority = 0;
            if (Char.IsUpper(l[i])) {
                priority += (int) l[i] - 38;
            } else {
                priority += (int) l[i] - 96;
            }
            totalPriority += priority;
            break;
        }
    }
}

Console.WriteLine(totalPriority);

// part 2

totalPriority = 0;

for (int i = 0; i < text.Length; i += 3) {
    for (int j = 0; j < text[i].Length; j++) {
        if (text[i + 1].Contains(text[i][j]) && text[i + 2].Contains(text[i][j])) {
            int priority = 0;
            if (Char.IsUpper(text[i][j])) {
                priority += (int) text[i][j] - 38;
            } else {
                priority += (int) text[i][j] - 96;
            }
            totalPriority += priority;
            break;
        }
    }
}

Console.WriteLine(totalPriority);
