# OCR Text Extraction Script

This Bash script is designed to extract text from PNG files using Tesseract OCR. It processes each PNG file in the current directory, extracts text, and organizes the results into an output file.

## Script Overview

The script performs the following actions:

1. **Output Configuration**
   - It configures the output file and folder where extracted text will be stored.
   - Output file: `extracted_text.txt`
   - Output folder: `extracted_text`

2. **Processing PNG Files**
   - It iterates over each `.png` file in the current directory.

3. **Text Extraction**
   - For each PNG file, the script does the following:
     - Generates a random prefix (8 characters long).
     - Extracts the current file name without the extension.
     - Creates a new filename with the random prefix.
     - Uses Tesseract to perform OCR on the PNG file and extracts text.
     - Appends the extracted text to the output file and adds a blank line for separation.
     - Renames the file with the new filename and moves it to the `extracted_text` folder.

4. **Cleanup**
   - After processing all files, it moves the `output_file` to the `extracted_text` folder.

## Usage

1. Ensure that the script is saved as `extract_text.sh`.

2. Make the script executable:
   ```bash
   chmod +x extract_text.sh
   ```

3. Run the script:
   ```bash
   ./extract_text.sh
   ```

## Requirements

- Tesseract OCR should be installed and accessible from the command line.


##
# OCR Service with Docker

This setup allows you to use Docker to create and run a service for Optical Character Recognition (OCR) on PNG files. The service utilizes Tesseract OCR to extract text from images.

## Docker Compose Configuration

### Docker Compose File (docker-compose.yml):

```yaml
version: "3.8"
services:
  ocr:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: ocr
    volumes:
      - .:/ocr
```

- The Docker Compose file defines a service named `ocr`.
- It specifies the build context as the current directory (where the Dockerfile and `screenshot_ocr.sh` script are located).
- The service is named `ocr`.
- It sets up a volume that maps the current directory (`.`) to the `/ocr` directory within the container.

## Dockerfile Configuration

### Dockerfile (Dockerfile):

```Dockerfile
FROM ubuntu:22.04

WORKDIR /ocr

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y tesseract-ocr-eng

COPY screenshot_ocr.sh /usr/local/bin/
COPY *.png ./

RUN chmod +x /usr/local/bin/screenshot_ocr.sh

CMD ["screenshot_ocr.sh"]
```

- The Dockerfile defines the image to be built for the OCR service.
- It sets the working directory to `/ocr` within the container.
- It installs the `tesseract-ocr-eng` package without interactive prompts using the `-y` flag.
- It copies the `screenshot_ocr.sh` script to `/usr/local/bin/` in the container.
- It copies all PNG files from the current directory to the working directory within the container.
- The `screenshot_ocr.sh` script is made executable.
- The `CMD` instruction specifies the command to execute when the container starts, which is the `screenshot_ocr.sh` script.

Make sure that your `screenshot_ocr.sh` script is correctly configured to process the PNG files and store the results, as described in your original script.

## Usage

1. Save the Docker Compose file as `docker-compose.yml` and the Dockerfile as `Dockerfile` in the same directory as your `screenshot_ocr.sh` script and PNG files.

2. Build the Docker image:
   ```bash
   docker-compose build
   ```

3. Run the OCR service:
   ```bash
   docker-compose up
   ```

The service will process the PNG files in the current directory using Tesseract OCR.

## Requirements

- Docker and Docker Compose should be installed on your system.