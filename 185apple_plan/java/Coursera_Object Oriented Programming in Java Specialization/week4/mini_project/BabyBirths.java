
/**
 * Write a description of part1 here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
import org.apache.commons.csv. *;
import edu.duke.*;
import java.io.*;
public class BabyBirths {
    public void printName(){
        FileResource fr= new FileResource();
        for (CSVRecord record: fr.getCSVParser(false)){
            int numBirth=Integer.parseInt(record.get(2));
            
            if (numBirth<100){
                System.out.println("Name "+ record.get(0)+
                                   " Gender " + record.get(1)+
                                   " Num Born " + record.get(2));
            }
            
            
    }
    }
    public void totalBirths(FileResource fr){
        int totalBirth=0;
        int girlname=0;
        int boyname=0;
        for( CSVRecord record : fr.getCSVParser(false)){
            int numBorn= Integer.parseInt(record.get(2));
            totalBirth+=numBorn;
            if (record.get(1).equals("F")){
                girlname+=1;
        }
        else{
            boyname+=1;
        } 
    }
    int totalname=boyname+girlname;
    System.out.println("total Birth =" + totalBirth);
    System.out.println("No. girl name =" + girlname);
    System.out.println("No. boy name =" + boyname);
    System.out.println("No. total name =" + totalname);
}

public void testTotalbirths(){
    FileResource fr=new FileResource("../us_babynames/us_babynames_by_year/yob1905.csv");
    totalBirths(fr);
}
    


public int getRank(int year, String name, String gender){
    int rank=-1;
    int count=0;
    FileResource fr= new FileResource("../us_babynames/us_babynames_by_year/yob"+Integer.toString(year)+".csv");
    for( CSVRecord record : fr.getCSVParser(false)){
        if (record.get(1).equals(gender)){
            count+=1;
        if (record.get(0).equals(name) ){
            rank=count;
    }
}
}
return rank;
}

public String getName(int year, int rank, String gender){
    //returns the name of the person or "NO NAME"
    int count=0;
    FileResource fr= new FileResource("../us_babynames/us_babynames_by_year/yob"+Integer.toString(year)+".csv");
    for( CSVRecord record : fr.getCSVParser(false)){
        if (record.get(1).equals(gender)){
            count+=1;
        if (rank==count){
            return (record.get(0));
    }
}
}
return "NO NAME";
}

public void whatIsNameInYear(String name, int year, int Newyear, String gender){
    int rank=getRank( year, name, gender);
    String newName=getName(Newyear, rank, gender);
    System.out.println(name+ " born in " + year +" would be " + newName + " if  born in "+ Newyear);
}

public int yearOfHighestRank(String name, String gender){
    DirectoryResource dr= new DirectoryResource();
    int H_rank=-1;
    int final_year=0;
    for (File f : dr.selectedFiles()){
        int year=Integer.parseInt(f.getName().substring(3,7));
        int rank=getRank( year, name, gender);
        if (rank!=-1 && (H_rank==-1||rank< H_rank) ){
            H_rank=rank;
            final_year=year;
        }
    }
    
    if (H_rank==-1){
        return H_rank;

}
    return final_year;
}

public double getAverageRank(String name, String gender){
    DirectoryResource dr= new DirectoryResource();
    double sum=0;
    int count=0;
    for (File f : dr.selectedFiles()){
        int year=Integer.parseInt(f.getName().substring(3,7));
        int rank=getRank( year, name, gender);
        
        if (rank!=-1){
            sum+=rank;
            count+=1;
        }
    }
    if (count==0){
        return -1.0;
    }
    return sum/count;
}

public int getTotalBirthsRankedHigher(int year, String name, String gender){
    
    //the total number of births of those names
    //with the same gender and same year 
    //who are ranked higher than name
    int totalBirth=0;
    int rank=getRank( year, name, gender);
    System.out.println(rank);
    FileResource fr= new FileResource("../us_babynames/us_babynames_by_year/yob"+Integer.toString(year)+".csv");
    
    for( CSVRecord record : fr.getCSVParser(false)){
        if (record.get(1).equals(gender)){
            int rank_temp=getRank(year,record.get(0),gender);
            if (rank_temp<rank){
                System.out.println(rank_temp);
                //System.out.println(record.get(0));
                //System.out.println(record.get(2));
                int numBirth=Integer.parseInt(record.get(2));
                totalBirth+=numBirth;
                System.out.println(totalBirth);
            }
            else
            {
                break;
        }
 }
 
}
return totalBirth;
}

}
