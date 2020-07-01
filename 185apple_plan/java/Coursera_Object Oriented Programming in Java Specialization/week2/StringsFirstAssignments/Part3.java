
/**
 * Write a description of Part3 here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Part3 {
    public Boolean twoOccurrences(String stringa, String stringb){
        int len_a=stringa.length();
        int len_b=stringb.length();
        if ((stringb.indexOf(stringa)==-1)){ // no need "(len_a> len_b ) ||" should also return -1
            return false;
        }
        
        int count=0;
        int start_inx=0;
        int end_inx=0;
        // end point does not pass the length and there is a stringa in stringb last time
        while (end_inx<len_b && start_inx!= -1){
            // find stringa in the rest of stringb start from the last end point
            start_inx=stringb.indexOf(stringa, end_inx);
            // if one more stringa is found
            if (start_inx != -1){
                // update new end point, there may be a repeat string s.t. stringa="aa", stringb="aaa"
                end_inx=start_inx+1;
                // update count
                count=count+1;
        }
     }
     // if the count is 2 or more
        if (count >=2){
            return true;
    }
    return false;
}

public String lastPart (String stringa, String stringb){
    
    
    //If stringa does not occur in stringb, then return stringb
    if ((stringb.indexOf(stringa)==-1)){ 
            return stringb;
        }
    //the first occurrence of stringa in stringb
    int start_inx=stringb.indexOf(stringa);
    int end_inx=start_inx+stringa.length();
    
    // returns the part of stringb that follows stringa
    
    return stringb.substring(end_inx);
}

public void testtwoOccurrences() {
    // test1 
    String stringa1= new String("by");
    String stringb1= new String("A story by Abby Long");
    Boolean ans1=twoOccurrences(stringa1,stringb1);
    
    //test2
    String stringa2= new String("a");
    String stringb2= new String("banana");
    Boolean ans2=twoOccurrences(stringa2,stringb2);
    
    //test3
    String stringa3= new String("aa");
    String stringb3= new String("aaa");
    Boolean ans3=twoOccurrences(stringa3,stringb3);
    
    System.out.println(stringa1 +" in " + stringb1 + " is "+ ans1);
    System.out.println(stringa2 +" in " + stringb2 + " is "+ ans2);
    System.out.println(stringa3 +" in " + stringb3 + " is "+ ans3);
}

public void testlastPart() {
    // test1 
    String stringa1= new String("an");
    String stringb1= new String("banana");
    String ans1=lastPart(stringa1,stringb1);
    
    //test2
    String stringa2= new String("zoo");
    String stringb2= new String("forest");
    String ans2=lastPart(stringa2,stringb2);
    
    System.out.println("after" + stringa1 +" in " + stringb1 + " is "+ ans1);
    System.out.println("after " + stringa2 +" in " + stringb2 + " is "+ ans2);
}
}
