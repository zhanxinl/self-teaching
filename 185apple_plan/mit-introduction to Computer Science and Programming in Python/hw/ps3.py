# Problem 1.
# Write two functions, called countSubStringMatch and countSubStringMatchRecursive that take two arguments. a key string and a target string.
#These functions iteratively and recursively count the number of instances of the key in the target string. You should complete definitions for
#    Targets and keys

target = "atgacatgcacaagtatgcat"
key = "atgc"
##
def countSubStringMatch(key, target):
    if len(key)>len(target):
        return 0

    count=0

    for i in range(0,len(target)-len(key)):
        if key==target[i:i+len(key)]:
            count+=1

    return count

           
def countSubStringMatchRecursive(key, target):
    count=0
    if str.find(target,key)==-1:
        return count

    return 1+countSubStringMatchRecursive(key, target[str.find(target,key)+len(key):])

    

    

    


 
    

# Problem 2. 
# Write the function subStringMatchExact. This function takes two arguments: a target string, and a key string.
# It should return a tuple of the starting points of matches of the key string in the target string, when indexing starts at 0. Complete the definition for

#	def subStringMatchExact(target,key):

#	For example, would return the tuple (5, 15). The file ps3_template.py includes some test strings that you can use to test your function.
#       In particular, we provide two target strings and four key strings.
#       Test your function on each combination of key and target string, as well as other examples that you create. Place your answer in a file named ps3b.py

def subStringMatchExact(target,key):
    ans_tup=()

    if len(key)>len(target):
        return ans_tup

    count=0

    for i in range(0,len(target)-len(key)):
        if key==target[i:i+len(key)]:
            count+=1
            ans_tup=ans_tup+(i,)

    return ans_tup

 
def subStringMatchExact1 (target, key):
	"""This function returns a tuple of the starting position(s) of a key string within a target string"""
	answer_tuple = () # initialize the tuple we will return
	start = 0 # use this initial the starting point for find()
	while str.find(target, key, start) >=0:
		start = str.find(target, key, start)
		answer_tuple += (start,)
		start+=1
	return answer_tuple


# Problem 3.
# Write a function, called constrainedMatchPair which takes three arguments: a tuple representing starting points for the first substring,
# a tuple representing starting points for the second substring, and the length of the first substring.
# The function should return a tuple of all members (call it n) of the first tuple for which there is an element in the second tuple (call it k) such that n+m+1 = k,
# where m is the length of the first substring. Complete the definition

# To test this function, we have provided a function called subStringMatchOneSub,
# which takes two arguments: a target string and a key string.
# This function will return a tuple of all starting points of matches of the key to the target,
# such that at most one element of the key is incorrectly matched to the target.
# This function is provided for you in the file ps3_template.py and invokes the function you are to write. Save your answers in a file named ps3c.py.

# these are some example strings for use in testing your code

#  target strings

def constrainedMatchPair(start_first,start_second,len_first):
    ans_tup=()
    for n in start_first:
        for k in start_second:
            if n+len_first+1==k:
                ans_tup+=(n,)

    return ans_tup
                
    


def subStringMatchOneSub(key,target):
    """search for all locations of key in target, with one substitution"""
    allAnswers = ()
    for miss in range(0,len(key)):
        # miss picks location for missing element
        # key1 and key2 are substrings to match
        key1 = key[:miss]
        key2 = key[miss+1:]
        print ('breaking key',key,'into',key1,key2)
        # match1 and match2 are tuples of locations of start of matches
        # for each substring in target
        match1 = subStringMatchExact(target,key1)
        match2 = subStringMatchExact(target,key2)
        # when we get here, we have two tuples of start points
        # need to filter pairs to decide which are correct
        filtered = constrainedMatchPair(match1,match2,len(key1))
        allAnswers = allAnswers + filtered
        print ('match1',match1)
        print ('match2',match2)
        print ('possible matches for',key1,key2,'start at',filtered)
    return (allAnswers)
        
# Problem 4
# Write a function, called subStringMatchExactlyOneSub which takes two arguments: a target string and a key string.
# This function should return a tuple of all starting points of matches of the key to the target,
# such that at exactly one element of the key is incorrectly matched to the target. Complete the definition.  Save your answers in a file named ps3d.py.


    





