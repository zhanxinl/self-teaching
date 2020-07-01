def oddTuples(aTup):
    '''
    aTup: a tuple
    
    returns: tuple, every other element of aTup. 
    '''
    # Your Code Here
    ans=()
    for i in range(len(aTup)):
        if i%2==0:
            ans+=(aTup[i],)
    return ans
