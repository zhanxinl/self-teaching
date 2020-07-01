
/**
 * Write a description of Assignment here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */

import org.apache.commons.csv. *;
import edu.duke.*;
import java.io.*; 
public class Assignment {
    public CSVRecord coldestHourInFile(CSVParser parser){
        CSVRecord ColdestRow=null;
        for (CSVRecord CurRow : parser){
            if ( ColdestRow==null){
                ColdestRow=CurRow;
            }

            // temp comparsion
            double coldestT=Double.parseDouble(ColdestRow.get("TemperatureF"));
            double curT=Double.parseDouble(CurRow.get("TemperatureF"));
                
            if (curT!=-9999 && coldestT>curT ){
                ColdestRow=CurRow;
                }
                
        }
        return ColdestRow;
}

public String fileWithColdestTemperature(){
    DirectoryResource dr= new DirectoryResource();
    String ColdestfileName=null;
    CSVRecord Coldest=null;
    double coldestT = 0.0;
    for (File f : dr.selectedFiles()){
        FileResource fr= new FileResource(f);
        CSVParser parser = fr.getCSVParser();
        if (Coldest==null){
             Coldest=coldestHourInFile(parser);
             ColdestfileName=f.getName();
             coldestT=Double.parseDouble(Coldest.get("TemperatureF"));
        }
        
        else{
            CSVRecord Cur=coldestHourInFile(parser);
            double curT=Double.parseDouble(Cur.get("TemperatureF"));
            if (curT!=-9999 && coldestT>curT ){
                 Coldest=Cur;
                 ColdestfileName=f.getName();
                 coldestT=Double.parseDouble(Coldest.get("TemperatureF"));
                }
             
            }

    }
    //return a string that is the name of the file from selected files 
    //that has the coldest temperature
    
    return ColdestfileName;
}

public double averageTemperatureInFile(CSVParser parser){
    // avg=(sum/n)
    double sum=0;
    int count=0;
    for (CSVRecord CurRow : parser){
        double currT= Double.parseDouble(CurRow.get("TemperatureF"));
        
        if (currT!=-9999){
            sum=sum+currT;
            count=count+1;
        }
    }
    //returns a double that represents the average temperature in the file
    return sum/count;
}


public CSVRecord lowestHumidityInFile(CSVParser  parser){
    CSVRecord lowestHRow=null;
    for (CSVRecord CurRow : parser){
            // assign lowestH CSV record and check "N/A"
            if ( lowestHRow==null && CurRow.get("Humidity")!="N/A"){
                lowestHRow=CurRow;
            }
            else if(CurRow.get("Humidity").equals("N/A")==false){
                double lowestH=Double.parseDouble(lowestHRow.get("Humidity"));
                double curH=Double.parseDouble(CurRow.get("Humidity"));
                
                if (lowestH>curH ){
                lowestHRow=CurRow;
                }
            }
        //returns the CSVRecord that has the lowest humidity
    }
    return lowestHRow;
}

public CSVRecord lowestHumidityInManyFiles(){
    DirectoryResource dr= new DirectoryResource();
    double lowest_H=99999;
    CSVRecord lowstH_csv=null;
    for (File f : dr.selectedFiles()){
        FileResource fr= new FileResource(f);
        System.out.println(f.getName());
        CSVParser parser = fr.getCSVParser();
        CSVRecord cur_csv=lowestHumidityInFile(parser); // the lowestH record in current file
        
        double cur_H=Double.parseDouble(cur_csv.get("Humidity"));
        if (cur_H<lowest_H){
            lowest_H=cur_H;
            lowstH_csv=cur_csv;
        }
    }
//returns a CSVRecord that has the lowest humidity over all the files
    return lowstH_csv;
}
public double averageTemperatureWithHighHumidityInFile(CSVParser parser, int value){
        double sum=0;
        int count=0;
    for (CSVRecord CurRow : parser){
        if (CurRow.get("Humidity")!="NA"){
        double currT= Double.parseDouble(CurRow.get("TemperatureF"));
        
        if (currT!=-999 && Double.parseDouble(CurRow.get("Humidity"))>value){
            sum=sum+currT;
            count=count+1;
        }
    }
}
    if (count!=0){
        return sum/count;
    } 
    return sum;
}

public void testColdestHourInFile(){
        FileResource fr = new FileResource();
        CSVParser parser = fr.getCSVParser();
        
        CSVRecord Coldest=coldestHourInFile(parser);
        System.out.println(Coldest.get("TemperatureF"));
        
}



public void testFileWithColdestTemperature(){
    String ColdestfileName=fileWithColdestTemperature();
    System.out.println(ColdestfileName);
    FileResource coldf= new FileResource("../nc_weather/"+ ColdestfileName.substring(8,12)+ "/"+ColdestfileName);
    CSVParser parser = coldf.getCSVParser();
    double temp=Double.parseDouble(coldestHourInFile(parser).get("TemperatureF"));
    System.out.println("Coldest temperature on that day was " + temp);
    System.out.println("All the Temperatures on the coldest day were:");
    CSVParser parser2 = coldf.getCSVParser();
    for (CSVRecord record:parser2){
        System.out.println(record.get("DateUTC") + " "+ record.get("TimeEST") + " " + record.get("TemperatureF"));
       }
}

public void testLowestHumidityInFile(){
    FileResource fr = new FileResource();
    CSVParser parser = fr.getCSVParser();
    CSVRecord csv = lowestHumidityInFile(parser);
    System.out.println("Lowest Humidity was " + csv.get("Humidity") + " at " + csv.get("DateUTC"));
}

public void testLowestHumidityInManyFiles(){
    CSVRecord csv=lowestHumidityInManyFiles();
    System.out.println("Lowest Humidity was " + csv.get("Humidity") + " at " + csv.get("DateUTC"));
}

public void testAverageTemperatureInFile() {
    FileResource fr = new FileResource();
    CSVParser parser = fr.getCSVParser();
    double avg=averageTemperatureInFile(parser);
    System.out.println("Average temperature in file is " + avg);
}

public void testAverageTemperatureWithHighHumidityInFile(){
    FileResource fr = new FileResource();
    CSVParser parser = fr.getCSVParser();
    double avg=averageTemperatureWithHighHumidityInFile(parser,80);
    
    if (avg==0){
        System.out.println("No temperatures with that humidity");
    }
    else{
        System.out.println("Average Temp when high Humidity is " + avg);
    }
    
}
}