import edu.duke.*;

/**
 * Write a description of Part1 here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Part1 {
    public String  findSimpleGene(String dna)   {
        String result="";
        String startstr="ATG";
        String endstr="TAA";
        
        // start condon index
        int start_inx=dna.indexOf(startstr);
        
        // if no start condon
        if (start_inx ==-1){
            return result;   
        }
        // end condon index
        int end_inx=dna.indexOf(endstr,start_inx+3);
        // if no end condon
         if (end_inx ==-1){
            return result;   
        }
        //  a multiple of 3
        if ((end_inx-start_inx)%3==0){
        result= dna.substring(start_inx,end_inx+3);
    }
        return result;
}

public void testSimpleGene() {
        // create 5 different string
        String Gene1=findSimpleGene(new String ("GCTAA")); //no “ATG”,
        String Gene2=findSimpleGene(new String ("GCATGGGG"));//no “TAA”
        String Gene3=findSimpleGene(new String ("GCGTGAG")); // no "ATG" or "TAA"
        String Gene4=findSimpleGene(new String ("GAATGAATTAA")); // multiple of 3
        String Gene5=findSimpleGene(new String ("GAATGATTAA")); // not 3
        System.out.println("String 1 is GCTAA and Gene 1 is " + Gene1);
        System.out.println("String 2 is GCATGGGG and Gene 2 is " + Gene2);
        System.out.println("String 3 is GCGTGAG and Gene 3 is " + Gene3);
        System.out.println("String 4 is GAATGAATTAA and Gene 4 is " + Gene4);
        System.out.println("String 5 is GAATGATTAA and Gene 5 is " + Gene5);
    }
}

