
/**
 * Write a description of Part2 here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Part2 {
 public int howMany(String stringa, String stringb){
        int len_a=stringa.length();
        int len_b=stringb.length();
        if ((stringb.indexOf(stringa)==-1)){ // no need "(len_a> len_b ) ||" should also return -1
            return 0;
        }
        
        int count=0;
        int start_inx=0;
        int end_inx=0;
        // end point does not pass the length and there is a stringa in stringb last time
        while (start_inx!= -1){
            // find stringa in the rest of stringb start from the last end point
            start_inx=stringb.indexOf(stringa, end_inx);
            // if one more stringa is found
            if (start_inx != -1){
                // update new end point, there may be a repeat string s.t. stringa="aa", stringb="aaa"
                end_inx=start_inx+len_a;
                // update count
                count=count+1;
        }
     }
     return count;
    }
    public void testHowMany(){
        int count1=howMany("GAA", "ATGAACGAATTGAATC");
        System.out.println("count is  "+ count1);
        
        int count2=howMany("AA", "ATAAAA");
        System.out.println("count is  "+ count2);
    }
}
