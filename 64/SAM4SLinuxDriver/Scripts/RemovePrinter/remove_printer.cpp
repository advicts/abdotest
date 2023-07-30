/*
 * remove_printer.cpp
 *
 *  Created on: 30-Jan-2014
 *      Author: siva
 */

#include "remove_printer.h"

using namespace std;

int main() {

	cups_dest_t * printers;

	int nDest;
	ppd_file_t *ppd;

	char buff[MAX_FILE_PATH] = { 0 };
	nDest = cupsGetDests(&printers);

	for (int i = 0; i < nDest; i++) {

		readlink(cupsGetPPD2(CUPS_HTTP_DEFAULT, printers[i].name), buff,
				MAX_FILE_PATH);
		cout << "The content of buff is " << buff << endl;

		ppd = ppdOpenFile(buff);
		if (ppd == NULL) {
			if (NULL != strstr(buff, "SAM4S")) {
				delete_printer(printers[i].name);
				ppdClose(ppd);

			}
		} else {
			cout << "The PCFIlename is " << ppd->pcfilename << endl;
			if (strcmp(ppd->pcfilename, ELLIX30PPD) == 0
					|| strcmp(ppd->pcfilename, ELLIX32PPD) == 0
					|| strcmp(ppd->pcfilename, ELLIX35PPD) == 0
					|| strcmp(ppd->pcfilename, ELLIX40PPD) == 0
					|| strcmp(ppd->pcfilename, ELLIX42PPD) == 0
					|| strcmp(ppd->pcfilename, ELLIX45PPD) == 0
					|| strcmp(ppd->pcfilename, GIANT100PPD) == 0) {
				delete_printer(printers[i].name);
				ppdClose(ppd);
			}

		}
		memset(buff, 0, MAX_FILE_PATH);
	}

	return 0;
}

/*

 Function Name : delete_printer()

 Input: Name of the printer to be delete

 Return Value: Status

 Description: This function will delete the printer.

 */

ipp_status_t delete_printer(const char *name) {
	http_t *http;
	ipp_t *request;
	char uri[1024];

	snprintf(uri, sizeof(uri), "ipp://localhost/printers/%s", name);
	cout << "URI is " << uri << endl;

	http = httpConnectEncrypt(cupsServer(), ippPort(), cupsEncryption());

	request = ippNew();
	request->request.op.operation_id = CUPS_DELETE_PRINTER;
	request->request.op.request_id = 1;

	ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_CHARSET,
			"attributes-charset", NULL, "utf-8");
	ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_LANGUAGE,
			"attributes-natural-language", NULL, "en");
	ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_URI, "printer-uri", NULL,
			uri);
	ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_NAME,
			"requesting-user-name", NULL, cupsUser());

	ippDelete(cupsDoRequest(http, request, "/admin"));

	httpClose(http);

	return (cupsLastError());
}

