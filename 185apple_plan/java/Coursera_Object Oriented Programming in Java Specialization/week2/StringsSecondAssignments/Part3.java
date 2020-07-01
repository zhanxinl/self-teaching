
/**
 * Write a description of Part3 here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Part3 {
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
        //Find the index of the first occurrence of the start codon “ATG”. 
        String startCondon=  new String ("ATG");
        int start_inx=dna.indexOf(startCondon, where);
        //If there is no “ATG”, return the empty string.
        if (start_inx==-1){
            return "";
        }
        //Find the index of the first occurrence of the stop codon “TAA”
        //after the first occurrence of “ATG” 
        //that is a multiple of three away from the “ATG”. 
        int TAA_inx=findStopCodon(dna, start_inx,"TAA");
        int TAG_inx=findStopCodon(dna, start_inx,"TAG");
        int TGA_inx=findStopCodon(dna, start_inx,"TGA");
        
        // min_inx found
        int min_inx=Math.min(TGA_inx, Math.min(TAA_inx,TAG_inx));
        
        if (min_inx==dna.length()){
            return "";
        }
        
        return dna.substring(start_inx,min_inx+3);
    }

        public int  countGenes(String dna){
         // repeatedly find genes 
         //print each one until there are no more genes
         int where=0;
         int count=0;
         while (true){
            String gene=findGene(dna, where);
            
            if (gene==""){
                break;
        }
        count=count+1;
        where= where+ gene.length()+1;
    }
    return count;
}
    public void testCountGenes(){
        int count1=countGenes("ATGTAAGATGCCCTAGT");
        System.out.println("number of genes are "+ count1);
       
        int count2=countGenes("ATGxxTAA");
        System.out.println("number of genes are "+ count2);
        
        int count3=countGenes("xxTAA");
        System.out.println("number of genes are "+ count3);
        
        int count4=countGenes("xxTAAATGTAAyyyyyATGyTATAG");
        System.out.println("number of genes are "+ count4);
    }
}
