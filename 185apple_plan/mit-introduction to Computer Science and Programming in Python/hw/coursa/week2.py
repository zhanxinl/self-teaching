import random

print("Please think of a number between 0 and 100!")
start=0
end=100
#random.randint(0,100))
ans=int((start+end)/2)

while True: 
    print("Is your secret number "+ str(ans) +"?")
    guess=str(input("Enter 'h' to indicate the guess is too high.Enter 'l' to indicate the guess is too low. Enter 'c' to indicate I guessed correctly. : " ))
    if guess =="h":
        end=ans
        ans=int((start+end)/2)
    elif guess=="l":
        start=ans
        ans=int((start+end)/2)
    elif guess=="c":
        print("Game over. Your secret number was:" + str(ans))
        break

    else:
        print("Sorry, I did not understand your input.")
    
    
      
