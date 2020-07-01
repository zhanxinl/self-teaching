import edu.duke.*;
/**
 * Write a description of Part1 here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Part1 {
    
    public int  findStopCodon(String dna, int startIndex, String stopCodon)   {
        // returns the index of the first occurrence of stopCodon that 
        // appears past startIndex and is a multiple of 3 away from startIndex
        
        // inital end index 
        int end_inx=dna.indexOf(stopCodon,startIndex+3);
        
        while (end_inx!=-1){
           // valid index: a multiple of 3
           if ((end_inx-startIndex)%3==0){
               return end_inx;
        }
        end_inx=dna.indexOf(stopCodon,end_inx+1);
        }
        // If there is no such stopCodon, 
        // this method returns the length of the dna strand
        int len_dna=dna.length();
        return len_dna;
    }
    
    public String findGene(String dna, int where){
        String dna_upper=dna.toUpperCase();
        //Find the index of the first occurrence of the start codon “ATG”. 
        String startCondon=  new String ("ATG");
        int start_inx=dna_upper.indexOf(startCondon, where);
        //If there is no “ATG”, return the empty string.
        if (start_inx==-1){
            return "";
        }
        //Find the index of the first occurrence of the stop codon “TAA”
        //after the first occurrence of “ATG” 
        //that is a multiple of three away from the “ATG”. 
        int TAA_inx=findStopCodon(dna_upper, start_inx,"TAA");
        int TAG_inx=findStopCodon(dna_upper, start_inx,"TAG");
        int TGA_inx=findStopCodon(dna_upper, start_inx,"TGA");
        
        // min_inx found
        int min_inx=Math.min(TGA_inx, Math.min(TAA_inx,TAG_inx));
        
        if (min_inx==dna.length()){
            return "";
        }
        
        return dna.substring(start_inx,min_inx+3);
    }

    public StorageResource  getAllGenes(String dna){
         // repeatedly find genes 
         //print each one until there are no more genes
         
         StorageResource store = new StorageResource();
         int where=0;
         while (true){
            String gene=findGene(dna, where);
            
            if (gene.isEmpty()){
                break;
            }
            store.add(gene);
            where= dna.indexOf(gene,where)+ gene.length();
    }
        return store;
    }
    public float cgRatio(String dna){
        //returns the ratio of C’s and G’s in dna 
        //as a fraction of the entire strand of DNA
        dna=dna.toUpperCase();
        int currindx=0;
        //count number of C and G
        int count=0;
        
        // find index of all C and G 
        while (currindx!=-1){
            // first C's index
            int C_inx=dna.indexOf("C", currindx);
            //G index
            int G_inx=dna.indexOf("G", currindx);
            
            // find smaller one
            if(C_inx!=-1 && C_inx<G_inx){
                currindx=C_inx;
        }
            else{
                currindx=G_inx;
            }
            //System.out.println(currindx);
            if (currindx !=-1){
                count=count+1;
                currindx=currindx+1;
            }
            
        }

        //number of char in DNA string
        int total=dna.length();

        // counts/DNA length

        return ((float)count) /total;
    }
    public int timescondon(String dna, String condon){
        dna=dna.toUpperCase();
        int inx=0;
        int count=0;
        while (inx!=-1){
            inx=dna.indexOf(condon, inx);
            
            if (inx!=-1){
                count=count+1;
                inx=inx+3;

        }
    }
    return count;
}

public void testTimescondon(){
    URLResource ur = new URLResource("https://users.cs.duke.edu/~rodger/GRch38dnapart.fa");
        // FileResource fr = new FileResource("");
    String dna = ur.asString();
    
    int count=timescondon(dna, "CTG");
    System.out.println( "No. condon " + count);
    
}
    
    public void processGenes(StorageResource sr){
        int count_long=0;
        int count_ratio=0;
        int longest=0;
       for (String s : sr.data()) {
           
           // update longest length
             if (s.length()>longest){
                longest=s.length();
            }
           
             if (s.length()>60){
                 // print all the Strings in sr that are longer than 9 characters
                 System.out.println("String longer than 60 " + s);
                 count_long=count_long+1;
            }
            
            float ratio_s=cgRatio(s);
            
            if (ratio_s>0.35){
                System.out.println(s + " 's C-G-ratio is higher than 0.35. ");
                count_ratio=count_ratio+1;
            }
            

       //print the Strings in sr whose C-G-ratio is higher than 0.35
       //print the number of strings in sr whose C-G-ratio is higher than 0.35
       //print the length of the longest gene in sr
    }
     System.out.println("longest " + longest);
     System.out.println("No.String longer than 60" + count_long);
     System.out.println("No.C-G-ratio is higher than 0.35 " + count_ratio);
}
        
        
    public void testFindStopCodon(){
        String stopCodon1= new String("TAA");
        String stopCodon2= new String("TAG");
        int startIndex= 2;
        //                       012  5  8  11 14
        String dna1= new String("xxATGyyyyyyTAATAG");
        String dna2= new String("xxATGyyyyyTAA");
        String dna3= new String("xxATGyyyyy");
        
        int stopindex1=findStopCodon(dna1,startIndex,stopCodon1); //11
        int stopindex2=findStopCodon(dna2,startIndex,stopCodon1); // 13
        int stopindex3=findStopCodon(dna1,startIndex,stopCodon2); //14
        int stopindex4=findStopCodon(dna3,startIndex,stopCodon2); //10
        System.out.println("dna data is "+ dna1 + " stopCondon is "+ stopCodon1+ " stopindex1 is " + stopindex1);
        System.out.println("dna data is "+ dna2 + " stopCondon is "+ stopCodon1+ " stopindex2 is " + stopindex2);
        System.out.println("dna data is "+ dna1 + " stopCondon is "+ stopCodon2+ " stopindex3 is " + stopindex3);
        System.out.println("dna data is "+ dna3 + " stopCondon is "+ stopCodon2+ " stopindex4 is " + stopindex4);
    }
    

    public void testFindGene(){
        
        
        //1. no ATG
        String dna1= new String("xxyyyyyyTAATAG");
        String gene1=findGene(dna1,0); 
        System.out.println("dna data is "+ dna1 + " gene is "+ gene1);
        //2. have ATG and one stopcondon
        String dna2= new String("xxATGyyyTAA");
        String gene2=findGene(dna2,0); 
        System.out.println("dna data is "+ dna2 + " gene is "+ gene2);
        
        //3. have ATG and several stopcondon
        String dna3= new String("xxATGyyyTAGTGATAA");
        String gene3=findGene(dna3,0); 
        System.out.println("dna data is "+ dna3 + " gene is "+ gene3);
        
        //4. have ATG and no stopcondon
        String dna4= new String("xxATGyyy");
        String gene4=findGene(dna4,0); 
        System.out.println("dna data is "+ dna4 + " gene is "+ gene4);
        
        //5. no gene 
        String dna5= new String("xxATGyyTAA");
        String gene5=findGene(dna5,0); 
        System.out.println("dna data is "+ dna5 + " gene is "+ gene5);
    }
    
    
    public void testGetAllGenes(){
        StorageResource stroe1=getAllGenes("xxatgyyyTAA");
        
        for (String s : stroe1.data()) {
             System.out.println("all gene in dna1 data is "+ s);
            }
        
    //2. haveseveral ATG and several stopcondon
        StorageResource stroe2=getAllGenes("xxATGyyyTAGATGxxxTGAxATGxTAA");
        
        for (String s : stroe2.data()) {
             System.out.println("all gene in dna2 data is "+ s);
            }

     //3. no gene
        StorageResource stroe3=getAllGenes("xxatgyTAAAAA");
        
        for (String s : stroe3.data()) {
             System.out.println("all gene in dna3 data is "+ s);
            }
        


    }
    
    
    public void testProcessGenes(){
        //String dna="ATGCCATAGxxxATGxxxTAAATGyyyTGATGCCATAGxxxATGxxxyyyTAAATGyyyzzzTGAATGCCATAGATGCCATAGATGCCATAGATGCCATAAATGCCATAAATGCCACCCCC";
        URLResource ur = new URLResource("https://users.cs.duke.edu/~rodger/GRch38dnapart.fa");
        // FileResource fr = new FileResource("");
        String dna = ur.asString();
        //System.out.println(dna);
        StorageResource sr=getAllGenes(dna);
        
        int count=0;
        for (String s : sr.data()) {
            count=count+1;
            }

        System.out.println(" No. dna " + count );
        
        processGenes(sr);
    
    }
        
   public void testCgRatio( ){
        double r1=cgRatio("ATGCCATAG");
        System.out.println("the ratio is  "+ r1);
        
    }
}
