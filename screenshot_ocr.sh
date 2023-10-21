#!/bin/bash

# Navigate to the directory where the screenshots are located

# Output file to append the extracted text
output_file="extracted_text.txt"
output_folder="extracted_text"

mkdir -p "$output_folder"

# Clear the output file if it already exists
# >> "$output_file"

# Iterate over each .jpg file in the directory
for file in *.png; do
    echo "Processing $file"
    # Generate a random prefix (8 characters long)
    random_prefix=$(LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 8)

    # Extract the current file name without the extension
    filename=$(basename "$file" .png)

    # Create the new filename with the random prefix
    new_filename="$random_prefix.png"

    # Perform OCR using Tesseract and extract text
    extracted_text=$(tesseract "$file" - 2>/dev/null)

    # Append the extracted text to the output file
    echo "$extracted_text" >> "$output_file"
    echo "" >> "$output_file"  # Add a blank line for separation

    # Rename the file with the new filename and folder
    mv "$file" "$new_filename"
    mv "$new_filename" "$output_folder"
  
    
done

mv "$output_file" "$output_folder"
echo "Done"