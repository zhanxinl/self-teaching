##	Problem 1.
	##	Show that it is possible to buy exactly 50, 51, 52, 53, 54, and 55 McNuggets, by finding solutions to the Diophantine equation. You can solve this in your head, using paper and pencil, or writing a program. However you chose to solve this problem, list the combinations of 6, 9 and 20 packs of McNuggets you need to buy in order to get each of the exact amounts.  Given that it is possible to buy sets of 50, 51, 52, 53, 54 or 55 McNuggets by combinations of 6, 9 and 20 packs, show that it is possible to buy 56, 57,..., 65 McNuggets. In other words, show how, given solutions for 50-55, one can derive solutions for 56-65.  If it is possible to buy x,x+1,...,x+5 sets of McNuggets,for some x,then it is possible to buy any number of McNuggets >= x, given that McNuggets come in 6, 9 and 20 packs.

	##	6a + 9b + 20c = n
	##	6a = n - 9b -20c 
	##	a = n/6 - 3/2b - 10/3c
	
	# 49 = (2*20) + (0*6) + (1*9)  # just curious
	# 50 = (1*20) + (2*6) + (2*9)
	# 51 = (0*20) + (4*6) + (3*9)
	# 52 = (2*20) + (2*6) + (0*9)
	# 53 = (1*20) + (1*6) + (3*9)
	# 54 = (0*20) + (0*6) + (6*9)
	# 55 = (2*20) + (1*6) + (1*9)
##------
	# 56 = (1*20) + (3*6) + (2*9)
	# 57 = (0*20) + (4*6) + (3*9)
	# 58 = (2*20) + (3*6) + (0*9)
	# 59 = (1*20) + (2*6) + (3*9)
	# 60 = (0*20) + (1*6) + (6*9)
	# 61 = (2*20) + (2*6) + (1*9)
	# 62 = (1*20) + (4*6) + (2*9)
	# 63 = (0*20) + (6*6) + (3*9)
	# 64 = (2*20) + (4*6) + (0*9)
	# 65 = (1*20) + (3*6) + (3*9)


def McNugget(n):
    ap=6
    bp=9
    cp=20
    rest=0
    
    for c in range ((n//cp),-1,-1):
        b=0
        a=0
        rest=n-c*cp
        if rest==0:
            print(str(n)+" "+"McNuggets are possible."+ "6a ="+ str(a) + " 9b ="+ str(b) + " 20c ="+ str(c))
            return(True)

        b=rest//bp
        while b>=0:
            rest-=b*bp
            if rest==0:
                print(str(n)+" "+"McNuggets are possible."+ "6a ="+ str(a) + " 9b ="+ str(b) + " 20c ="+ str(c))
                return(True)

            a=rest//ap
            while a>=0:
                rest-=a*ap
                if rest==0:
                    print(str(n)+" "+"McNuggets are possible."+ "6a ="+ str(a) + " 9b ="+ str(b) + " 20c ="+ str(c))
                    return(True)
                rest+=a*ap
                a-=1
            rest+=b*bp
            b-=1
        rest+=c*cp
        
            


#    print(str(n)+" "+"McNuggets are not possible.")
    return (False)
            

#for n in range(49,66):
#    print(McNugget(n))
	
	
#	Problem 2: Explain, in English, why this theorem is true.
## For this type of problem, if you can find a string of sequential numbers that is as long as the smallest counting unit
## then you can count to any subsequent number by adding this smallest counting unit a member of this base sequential series. Wow. 



# Problem 3
#
	#	Write an iterative program that finds the largest number of McNuggets that cannot be bought in exact quantity.
	#       Your program should print the answer in the following format (where the correct number is provided in place of <n>):

#	largest number of McNuggets that cannot be bought in exact quantity:
	#	Hint: your program should follow the outline above.
	#	Hint: think about what information you need to keep track of as you loop through possible ways of buying exactly n McNuggets.
        #       This will guide you in deciding what state variables you will need to utilize.
	#	Save your code for Problem 3 in ps2a.py.



#	Using this theorem, we can write an exhaustive search to find the largest number of McNuggets that cannot be bought in exact quantity.
#       The format of the search should probably follow this outline:
#	Hypothesize possible instances of numbers of McNuggets that cannot be purchased exactly, starting with 1
#For each possible instance, called n,
	#Test if there exists non-negative integers a, b, and c, such that 6a+9b+20c = n. (This can be done by looking at all feasible combinations of a, b, and c) 
	#If not, n cannot be bought in exact quantity, save n
#	When you have found six consecutive values of n that in fact pass the test of having an exact solution,
#       the last answer that was saved (not the last value of n that had a solution) is the correct answer,
#       since you know by the theorem that any amount larger can also be bought in exact quantity

def number_test(test):
    for num in range(test,-1,-1):
        if McNugget(num)==False:
            return num
    return (print("All number could be combined by 6, 9 or 20."))




##	Problem 4.
##	Assume that the variable packages is bound to a tuple of length 3, the values of which specify the sizes of the packages, ordered from smallest to largest.
##      Write a program that uses exhaustive search to find the largest number (less than 200) of McNuggets that cannot be bought in exact quantity.
##      We limit the number to be less than 200 (although this is an arbitrary choice) because in some cases there is no largest value that cannot be bought in exact quantity, and we don't want to search forever. Please use ps2b_template.py to structure your code.
##	Have your code print out its result in the following format:
##	"Given package sizes <x>, <y>, and <z>, the largest number of McNuggets that cannot be bought in exact quantity is: <n>"

##	Test your program on a variety of choices, by changing the value for packages.
##      Include the case (6,9,20), as well as some other test cases of your own choosing.

##	This problem took 4-5 hours over the course of a couple days.

def arb_McNugget(pack,n):
    """
    input: tuple with 3 ints, which represent 3 packing sizes
    output:boolean whether the number could be packed or not
    """
    ap=pack[0]
    bp=pack[1]
    cp=pack[2]
    rest=0

    for c in range ((n//cp),-1,-1):
        b=0
        a=0
        rest=n-c*cp
        if rest==0:
            #print(str(n)+" "+"McNuggets are possible."+ "6a ="+ str(a) + " 9b ="+ str(b) + " 20c ="+ str(c))
            return(True)

        b=rest//bp
        while b>=0:
            rest-=b*bp
            if rest==0:
                #print(str(n)+" "+"McNuggets are possible."+ "6a ="+ str(a) + " 9b ="+ str(b) + " 20c ="+ str(c))
                return(True)

            a=rest//ap
            while a>=0:
                rest-=a*ap
                if rest==0:
                    #print(str(n)+" "+"McNuggets are possible."+ "6a ="+ str(a) + " 9b ="+ str(b) + " 20c ="+ str(c))
                    return(True)
                rest+=a*ap
                a-=1
            rest+=b*bp
            b-=1
        rest+=c*cp
    return (False)


def arb_comb(pack):
    n=200
    for num in range(n,-1,-1):
        if arb_McNugget(pack, num)==False:
            return (print("(Given package sizes" + str(pack[0]) + ", "+ str(pack[1]) + " and "+ str(pack[2]) + ", the largest number of McNuggets that cannot be bought in exact quantity is: "+ str(num)))
