#include <stdio.h>
#include <stdlib.h>

int main()
{
    // part 1 and 2
    FILE *fp;
    char *line = NULL;
    size_t len = 0;
    ssize_t read;

    int count1 = 0;
    int count2 = 0;

    fp = fopen("day4.txt", "r");
    while ((read = getline(&line, &len, fp)) != -1) {
        // split line into 2 parts with delimiter ","
        char *token1 = strtok(line, ",");
        char *token2 = strtok(NULL, ",");
        // split token1 and token2 into 2 parts with delimiter "-"
        char *part1 = strtok(token1, "-");
        char *part2 = strtok(NULL, "-");
        char *part3 = strtok(token2, "-");
        char *part4 = strtok(NULL, "-");
        // convert part1 through part4 to int
        int num1 = atoi(part1);
        int num2 = atoi(part2);
        int num3 = atoi(part3);
        int num4 = atoi(part4);
        // check if the ranges num1-num2 and num3-num4 overlap
        if (num1 <= num3 && num4 <= num2) {
            count1++;
        } else if (num3 <= num1 && num2 <= num4) {
            count1++;
        }

        if (num1 <= num3 && num2 >= num3) {
            count2++;
        } else if (num3 <= num1 && num4 >= num1) {
            count2++;
        }
    }

    fclose(fp);

    printf("Full overlap: %d\n", count1);
    printf("Partial overlap: %d", count2);

    return 0;
}