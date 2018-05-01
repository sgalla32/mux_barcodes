This script is used to append barcodes to your demultiplexed GBS data, if needed to run in Tassel5 or similar. 

In order to run this code, run "mux_barcodes.pl file_with_barcodes drectory_with_fastq_files".

A file with the barcodes can be made in GBSX with the following command:
java -jar "location_of_GBS_Releases/GBSX_v1.0.jar" --BarcodeGenerator -b 96 -e EcoT22I > 96barcodes.txt
