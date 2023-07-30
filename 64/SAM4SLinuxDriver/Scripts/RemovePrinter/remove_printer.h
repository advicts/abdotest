/*
 * remove_printer.h
 *
 *  Created on: 30-Jan-2014
 *      Author: siva
 */

#ifndef REMOVE_PRINTER_H_
#define REMOVE_PRINTER_H_

#include <stdio.h>
#include <string.h>
#include <iostream>
#include <stdlib.h>
#include <cups/cups.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>

#include <cups/ipp.h>
#include <cups/ppd.h>
#include <regex.h>

#define MAX_PRINTER_COUNT 1024
#define MAX_FILE_PATH 1024

// PPD file names

#define ELLIX30PPD "SAM4s-ELLIX30.PPD"
#define ELLIX32PPD "SAM4s-ELLIX32.PPD"
#define ELLIX35PPD "SAM4s-ELLIX35.PPD"
#define ELLIX40PPD "SAM4s-ELLIX40.PPD"
#define ELLIX42PPD "SAM4s-ELLIX42.PPD"
#define ELLIX45PPD "SAM4s-ELLIX45.PPD"
#define GIANT100PPD "SAM4s-GIANT100.PPD"

ipp_status_t delete_printer(const char *name);


#endif /* REMOVE_PRINTER_H_ */
