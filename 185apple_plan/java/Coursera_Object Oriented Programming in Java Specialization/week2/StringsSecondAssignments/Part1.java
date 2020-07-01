
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

        public void  printAllGenes(String dna){
         // repeatedly find genes 
         //print each one until there are no more genes
         int where=0;
         while (true){
            String gene=findGene(dna, where);
            
            if (gene==""){
                break;
        }
        System.out.println("gene "+ gene);
        where= where+ gene.length()+1;
    }
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
}
