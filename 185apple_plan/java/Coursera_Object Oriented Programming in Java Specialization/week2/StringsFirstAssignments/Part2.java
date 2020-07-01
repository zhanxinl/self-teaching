import edu.duke.*;

/**
 * Write a description of Part1 here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Part2 {
    public String  findSimpleGene(String dna, String startCodon, String stopCodon)   {
        String result="";
        
        // change all letter to uppercase
        String upper_dna=dna.toUpperCase();
        startCodon=startCodon.toUpperCase();
        stopCodon=stopCodon.toUpperCase();

        // start condon index
        int start_inx=upper_dna.indexOf(startCodon);
        
        // if no start condon
        if (start_inx ==-1){
            return result;   
        }
        // end condon index
        int end_inx=upper_dna.indexOf(stopCodon,start_inx+3);
        // if no end condon
         if (end_inx ==-1){
            return result;   
        }
        //  a multiple of 3
        if ((end_inx-start_inx)%3==0){
            // result returns the upper/lower cases cased by dna(orginal)
        result= dna.substring(start_inx,end_inx+3);
    }
        return result;
}

public void testSimpleGene() {
        // create 5 different string
        String startCodon= new String ("ATG");
        String stopCodon= new String ("TAA");
        String Gene1=findSimpleGene(new String ("GCTAA"),startCodon,stopCodon); //no “ATG”,
        String Gene2=findSimpleGene(new String ("GCATGGGG"),startCodon,stopCodon);//no “TAA”
        String Gene3=findSimpleGene(new String ("GCGTGAG"),startCodon, stopCodon); // no "ATG" or "TAA"
        String Gene4=findSimpleGene(new String ("GAATGAATTAA"),startCodon,stopCodon); // multiple of 3
        String Gene5=findSimpleGene(new String ("GAATGATTAA"),startCodon, stopCodon); // not 3
        String Gene6=findSimpleGene(new String ("AAATGCCCTAACTAGATTAAGAAACC"),startCodon,stopCodon); // lower letter
        System.out.println("String 1 is GCTAA and Gene 1 is " + Gene1);
        System.out.println("String 2 is GCATGGGG and Gene 2 is " + Gene2);
        System.out.println("String 3 is GCGTGAG and Gene 3 is " + Gene3);
        System.out.println("String 4 is GAATGAATTAA and Gene 4 is " + Gene4);
        System.out.println("String 5 is GAATGATTAA and Gene 5 is " + Gene5);
        System.out.println("String 6 is gatgctataat and Gene 6 is " + Gene6);
    }
}
