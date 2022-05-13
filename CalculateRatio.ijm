// Usage: Process>Batch>Macro..., set input as folder containing _S.tif files, leave output field blank

// Assign title to variable for writing outputs
t=getTitle(); 

// Assign input image directory to variable for writing outputs 
image_dir = getDirectory("image");

// Set labels of slices to "one" and "two", these will become the window titles after converting to seperate images
Property.setSliceLabel("one", 1); 
Property.setSliceLabel("two", 2);

// Convert slices to seperate images
run("Stack to Images");

// S1-S2
imageCalculator("Subtract create 32-bit", "one", "two");
// S1+S2
imageCalculator("Add create 32-bit", "two","one");
// (S1-S2)/(S1+S2)
imageCalculator("Divide create 32-bit", "Result of one","Result of two");

// Measure mean intensity of result, assigned to var mean
getStatistics(area, mean); 

// Define folder within input director called ratios, check if it exists and create if it doesn't
dir_path = image_dir+"/ratios/";

if (File.exists(dir_path) == 0) {
	File.makeDirectory(dir_path);
}

// Save ratio image in ratios folder
save(dir_path+t+"_ratio");

// Set path for output text file 
text_path = dir_path+"ratios.txt";

// Set string to append to output, concatenating the file name, a tab delimiter, and the mean var
to_append = t+"\t"+mean;

// If-else statement to write output to text file, and create the file (on the first iteration)
if (File.exists(text_path) == 1) { // Tests if file already exists
	File.append(to_append, text_path); // If file already exists, appends output as new line without overwriting
} else { // If file does not exist then...
	file = File.open(text_path); // Create file 
	print(file, to_append); // Appends output to file 
}

