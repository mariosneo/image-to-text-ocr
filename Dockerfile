FROM ubuntu:22.04

WORKDIR ocr

RUN apt-get update && apt-get upgrade -y

RUN apt-get install tesseract-ocr-eng -y

COPY screenshot_ocr.sh /usr/local/bin
COPY *.png ./

RUN chmod +x /usr/local/bin/screenshot_ocr.sh

ENTRYPOINT [ "/bin/bash", "-c", "screenshot_ocr.sh" ]