import edu.duke.*;
/**
 * Write a description of Part4 here.
 * 
 * @author Xinlu Zhan g
 * @version 4/29/2020
 * Part 4: Finding Web Links
 */
public class Part4 {
    public void ReadYoutube( ){
        
        URLResource ur = new URLResource("http://www.dukelearntoprogram.com/course2/data/manylinks.html");
        String YTB= new String("youtube.com");
        int len_Y=YTB.length();
        for (String word : ur.words()) {
            // converage word to lower case 
            String word_low=word.toLowerCase();
            // or each word, check to see if “youtube.com” is in it
            int inx=word_low.indexOf(YTB);
            // if web in word
            if (inx !=-1){
                //find the double quote to the left and right 
                //of the occurrence of “youtube.com” to identify the beginning and end of the URL.
                
                // nearest left double quote
                int L_qu_inx=word_low.lastIndexOf("\"",inx);
                 // nearest right double quote
                int R_qu_inx=word_low.indexOf("\"",inx+len_Y);
                
                // extract fitted substring from words 
                String web= word.substring(L_qu_inx,R_qu_inx+1);
                //print substring out
                System.out.println(web);
            }
        }
    }
}
