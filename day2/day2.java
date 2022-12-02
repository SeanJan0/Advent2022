import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.ArrayList;

public class day2 {
    public static void main(String[] args) throws FileNotFoundException {
        // part 1
        File file = new File("day2.txt");
        Scanner sc = new Scanner(file);
        ArrayList<String> games = new ArrayList<String>();
        while (sc.hasNextLine()) {
            String line = sc.nextLine();
            games.add(line);
        }
        sc.close();

        int points = 0;
        for (String game : games) {
            int opponent = (int) game.charAt(0) - 64;
            int you = ((int) game.charAt(2)) - 87;
            points += you;
            int determine = Math.abs(you - opponent);
            if (determine == 0) {
                points += 3;
            } else if (determine == 1) {
                points += (you > opponent) ? 6 : 0;
            } else {
                points += (you > opponent) ? 0 : 6;
            }
        }
        System.out.println(points);

        // part 2

        points = 0;
        for (String game : games) {
            int opponent = (int) game.charAt(0) - 64;
            char target = game.charAt(2);
            if (target == 'X') {
                int point = (opponent - 1);
                if (point == 0) {
                    point = 3;
                }
                points += 0 + point;
            } else if (target == 'Y') {
                points += 3 + opponent;
            } else {
                int point = (opponent + 1);
                if (point == 4) {
                    point = 1;
                }
                points += 6 + point;
            }
        }

        System.out.println(points);
    }
}