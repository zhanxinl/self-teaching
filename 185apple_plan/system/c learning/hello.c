#include <stdio.h>
/* print Fahrenheit-Celsius table
// for fahr = 0, 20, ..., 300 */
// int main()
// {
// float fahr, celsius;
// int lower, upper, step;
// lower = 0; /* lower limit of temperature table */
// upper = 300; /* upper limit */
// step = 20; /* step size */
// fahr = lower;
// while (fahr <= upper) {
// celsius = 5 * (fahr-32) / 9;
// printf("%.2f\t %6.2f\n", fahr, celsius);
// fahr = fahr + step;
// }
// return 0;
// }



// int main()
// {
// int fahr;
// for (fahr = 0; fahr <= 300; fahr = fahr + 20)
// printf("%3d %6.1f\n", fahr, (5.0/9.0)*(fahr-32));
// return 0;
// }

// #define LOWER 0 /* lower limit of table */
// #define UPPER 300 /* upper limit */
// #define STEP 20 /* step size */
// /* print Fahrenheit-Celsius table */
// int main()
// {
// int fahr;
// for (fahr = LOWER; fahr <= UPPER; fahr = fahr + STEP)
// printf("%3d %6.1f\n", fahr, (5.0/9.0)*(fahr-32));
// return 0;
// }

//1.5.1 File Copying

/* copy input to output; 1st version */
// int main()
// {
// int c;
// c = getchar();
// while (c != EOF) {
// putchar(c);
// c = getchar();
// }
// return 0;
// }

/* copy input to output; 2nd version */
// int main()
// {
// int c;
// while ((c = getchar()) != EOF)
// putchar(c);
// return 0;
// }


// int main()
// {
// long nc;
// nc = 0;
// while (getchar() != EOF){
// ++nc;
// }
// printf("%ld\n", nc);
// return 0;
// }

int main()
{
double nc;
for (nc = 0; getchar() != EOF; ++nc)
;
printf("%.0f\n", nc);
return 0;
}