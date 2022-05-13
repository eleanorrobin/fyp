t=getTitle(); // Get file name for naming mask when exporting and resetting name after reverting images to stack 

// Create a mask with threshold 300 from the third slice
setSlice(3); // Select third slice (always brightest)
setThreshold(300.0000, 1000000000000000000000000000000.0000);
run("Create Mask");
run("Erode"); // Reduce inclusion x2 to remove artefacts
run("Erode");
run("Dilate"); // Expand inclusion x4 for remaining non-artefacts
run("Dilate");
run("Dilate"); 
run("Dilate"); 
run("Fill Holes"); // Fill holes in mask (to ensure nuclei etc. are not excluded) 

// Save mask
path = "<path>"+t+"_Mask"; // Set folder to save mask to, with original file name (t) + suffix
save(path);

// In order to apply mask within ImageJ we need to set pixel values of 255 to 1 and of 0 to NaN
// This is done using the follwing:
run("32-bit"); // Convert to float to allow NaN value
setThreshold(1.0000, 1000000000000000000000000000000.0000); // Select inclusion pixels (value = 255)
run("NaN Background"); // Set unselected (exclusion) pixels to value NaN
run("Divide...", "value=255"); // Divide by 255 to make inclusion pixels =1 (doesn't affect NaN pixels)

// Apply mask to each slice of stack 
imageCalculator("Multiply stack", t,"mask");

// Close mask window so that it isn't saved with outputs
selectWindow("mask"); 
close();