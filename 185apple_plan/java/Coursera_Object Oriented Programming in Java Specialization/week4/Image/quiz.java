
/**
 * Write a description of quiz here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
import edu.duke.*;
import java.io.*;

public class quiz {
    
    public ImageResource grayImage(ImageResource inImage){
         for(Pixel p : inImage.pixels()){
             int Red=p.getRed();
             int Green=p.getGreen();
             int Blue=p.getBlue();
             int avg= (Red+Green+Blue)/3;
             p.setRed(avg);
             p.setGreen(avg);
             p.setBlue(avg);
            }
            return inImage;
    }
    
        public ImageResource InvImage(ImageResource inImage){
         for(Pixel p : inImage.pixels()){
             p.setRed(255-p.getRed());
             p.setGreen(255-p.getGreen());
             p.setBlue(255-p.getBlue());
            }
            return inImage;
    }
    
    public void NewFileSavor(){
        //Your program should let the user select multiple image files
        DirectoryResource dr = new  DirectoryResource();
        
        for (File fr: dr.selectedFiles()){
            ImageResource Image= new ImageResource(fr);
            Image=  InvImage(Image);
            String Filename=Image.getFileName();
            String NewFilename= "inv-" +Filename;
            //String NewFilename= "gray-" +Filename;
            Image.setFileName(NewFilename);
            //Image.draw();
            Image.save();
        }
        


//For each image, create a new image that is a grayscale version of the original image
//For each image, save the grayscale image in a new file with the same filename as the original image, 
// but with the word “gray-” in front of the filename.
}

}