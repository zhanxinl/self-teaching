def year_paying(balance,annualInterestRate,monthlyPaymentRate):
    monthInterestRate=annualInterestRate/12
    for i in range(1,13):
        min_monthPay=balance*monthlyPaymentRate
        monUnPay=balance-min_monthPay
        balance=monUnPay+monthInterestRate*monUnPay
        print('Month ' + str(i) +' Remaining balance: '+ str(round(balance,2)))
        
    return round(balance,2)


# Paste your code into this box

def min_pay(balance, annualInterestRate):
    monthInterestRate=annualInterestRate/12
    upper_pay=balance*((1+monthInterestRate)**12)
    lower_pay=balance/12

    while True:
        payment=(upper_pay+lower_pay)/2
        var_bal=balance
        
        for i in range(12):
            var_bal-=payment
            rate=var_bal*monthInterestRate
            var_bal+=+rate
            
        var_bal=round(var_bal,2)
        if var_bal==0:
            break
        elif var_bal<0:
            upper_pay=payment
        elif var_bal>0:
            lower_pay=payment
    return round(payment,2)

balance=3329
annualInterestRate=0.2
