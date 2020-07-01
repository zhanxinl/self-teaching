
/**
 * Write a description of export here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
import org.apache.commons.csv. *;
import edu.duke.*;

public class export {
    public CSVParser tester(){
        FileResource fr = new FileResource();
        CSVParser parser = fr.getCSVParser();
        return parser;
    }
    
    public String countryinfo(CSVParser parser, String  country){
        for (CSVRecord record: parser){
            if (record.get("Country").equals(country)){
                return (record.get("Country")+ ":" + record.get("Exports")+ ":"
+ record.get("Value (dollars)"));                
        }
        
    }
    return "NOT FOUND";
}

    public void listExportersTwoProducts(CSVParser parser, String exportItem1, String exportItem2){
        for (CSVRecord record: parser){
            if (record.get("Exports").contains(exportItem1) && record.get("Exports").contains(exportItem2)){
                System.out.println(record.get("Country"));                
        }
    }
}

    public int numberOfExporters(CSVParser parser, String exportitem){
        int count=0;
        for (CSVRecord record: parser){
            if (record.get("Exports").contains(exportitem) ){
                count=count+1;              
        }
    }
    return count;
}

    public void bigExporters(CSVParser parser, String dollar){
        for (CSVRecord record: parser){
            if (record.get("Value (dollars)").length()>dollar.length()){
                System.out.println(record.get("Country")+ " "+ record.get("Value (dollars)"));              
        }
    }
}

public void testListExportersTwoProducts(){
    CSVParser parser =tester();
    //String exportItem1="cocoa";
    String exportItem1="cotton";
    
    String exportItem2="flowers";
    //listExportersTwoProducts(parser,exportItem1, exportItem2);
    String dollar="$999,999,999,999";
    //int count=numberOfExporters(parser,exportItem1);
    bigExporters(parser, "$999,999,999,999");
    //System.out.println(count);
    
    
}
}
