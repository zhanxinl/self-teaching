import edu.duke.*;
import java.io.File;

public class PerimeterAssignmentRunner {
    public double getPerimeter (Shape s) {
        // Start with totalPerim = 0
        double totalPerim = 0.0;
        // Start wth prevPt = the last point 
        Point prevPt = s.getLastPoint();
        // For each point currPt in the shape,
        for (Point currPt : s.getPoints()) {
            // Find distance from prevPt point to currPt 
            double currDist = prevPt.distance(currPt);
            // Update totalPerim by currDist
            totalPerim = totalPerim + currDist;
            // Update prevPt to be currPt
            prevPt = currPt;
        }
        // totalPerim is the answer
        return totalPerim;
    }

    public int getNumPoints (Shape s) {
        // Start with NumPoint=0
        int NumPoint=0;
        // For iterate each point
        for (Point currPt: s.getPoints()){
            // update NumPoint
            NumPoint=NumPoint+1;
        }
        return NumPoint;
    }

    public double getAverageLength(Shape s) {
        // get TotalPerimeter of s
        double Permin=getPerimeter(s);
        // get Total Num of Points of s
        int NumPoints=getNumPoints(s);
        // Averagelength=Perimeter/No.edge(No.Point)
        double AvgSideLen=Permin/NumPoints;
        
        return AvgSideLen;
    }

    public double getLargestSide(Shape s) {
        //start distance
        double LDist=0.0;
        // Set the last point as preivous point
        Point prevPt=s.getLastPoint();
        // update largest distance as the current to prev if new distance> LDist
        for( Point currPt: s.getPoints()){
            double currDist=prevPt.distance(currPt);
            if(currDist> LDist){
                //update LDist
                LDist=currDist;
            }
            // update curr point to the pervious point
            prevPt=currPt;
        }
        return LDist;
    }

    public double getLargestX(Shape s) {
        // start with the last point
        Point Pt=s.getLastPoint();
        // inital X value
        int LargeX=Pt.getX();
        
        for ( Point currPt : s.getPoints()){
            // new X value
            int currX=currPt.getX();
            
            if (currX> LargeX){
                //update largest X
                LargeX=currX;
        }
        
    }
    return LargeX;
}

    public double getLargestPerimeterMultipleFiles() {
        // Create a  disctionaryresource
        DirectoryResource dr = new DirectoryResource();
        
        double largestPer=0.0;
        for (File f : dr.selectedFiles()){
            FileResource fr=new FileResource(f);
            Shape s = new Shape(fr);
            double Per=getPerimeter(s);
            // select the largest Perimeter by comparsion
            if (Per>largestPer){
                largestPer=Per;
            }
        }
        return largestPer;
    }

    public String getFileWithLargestPerimeter() {
        // create disctionary
        DirectoryResource dr = new DirectoryResource();
        
        double largestPer=0.0;
        File temp = null; 
        for (File f : dr.selectedFiles()){
            FileResource fr=new FileResource(f);
            Shape s = new Shape(fr);
            double Per=getPerimeter(s);
            // select the largest Perimeter by comparsion
            if (Per>largestPer){
                largestPer=Per;
                temp=f;
            }
        }
        return temp.getName();
    }

    public void testPerimeter () {
        FileResource fr = new FileResource();
        Shape s = new Shape(fr);
        double length = getPerimeter(s);
        int numpoint=getNumPoints (s);
        double avgsidelen=getAverageLength(s);
        double longestdist=getLargestSide(s);
        double largestx=getLargestX(s);
        System.out.println("perimeter = " + length);
        System.out.println("average side length = " + avgsidelen);
        System.out.println("largest side length = " + longestdist);
        System.out.println("largest X value = " + largestx);
    }
    
    public void testPerimeterMultipleFiles() {
        // call getLargestPerimeterMultipleFiles
        double largestper=getLargestPerimeterMultipleFiles();
        System.out.println("Largest perimeter is " + largestper);
    }

    public void testFileWithLargestPerimeter() {
        // Put code here
        String Filename=getFileWithLargestPerimeter();
        System.out.println("File name with the largest perimeter is " + Filename);
    }

    // This method creates a triangle that you can use to test your other methods
    public void triangle(){
        Shape triangle = new Shape();
        triangle.addPoint(new Point(0,0));
        triangle.addPoint(new Point(6,0));
        triangle.addPoint(new Point(3,6));
        for (Point p : triangle.getPoints()){
            System.out.println(p);
        }
        double peri = getPerimeter(triangle);
        System.out.println("perimeter = "+peri);
    }

    // This method prints names of all files in a chosen folder that you can use to test your other methods
    public void printFileNames() {
        DirectoryResource dr = new DirectoryResource();
        for (File f : dr.selectedFiles()) {
            System.out.println(f);
        }
    }

    public static void main (String[] args) {
        PerimeterAssignmentRunner pr = new PerimeterAssignmentRunner();
        pr.testPerimeter();
    }
}
