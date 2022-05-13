t=getTitle() // Assign title of stack window to variable to get back to it from Z project
run("32-bit"); // Convert to 32-bit
run("Z Project...", "projection=[Average Intensity]"); // Make Z project
makeRectangle(0, 0, 25, 500); // Draw rectangle over Z project
getStatistics(area, mean); // Measure mean intensity in rectangle 
selectWindow(t); // Return to stack window
for (i=1; i<=nSlices; i++) { // For loop to iterate through slices of stack
	setSlice(i); // Set slice on loop run
	run("Subtract...", "value="+mean); // Subtract calculated mean from slice 
}
