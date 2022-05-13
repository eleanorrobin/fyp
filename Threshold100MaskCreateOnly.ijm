t=getTitle(); // Get file name for naming mask when exporting and resetting name after reverting images to stack 

// Create a mask with threshold 100 from the third slice
setSlice(3); // Select third slice (always brightest)
setThreshold(100.0000, 1000000000000000000000000000000.0000);
run("Create Mask");
run("Dilate"); // Expand inclusion by a few pixels 

// Save mask
path = "<path>"+t+"_Mask"; // Set folder to save mask to, with original file name (t) + suffix
save(path);