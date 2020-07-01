
s = 'abcbcd'

max_len=0
max_str=""

if len(s)==0 or len(s)==1:
    max_len=len(s)
    max_str=s
    
else:
    n=1
    start=0
    end=1
    while end<len(s):
        if s[end-1]<=s[end]:
            n+=1
            end+=1
            if n>=max_len:
                max_str=s[start:end]
                max_len=n
        else:
            start=end
            end+=1
            n=1
print(max_str + " and " + str(max_len))
