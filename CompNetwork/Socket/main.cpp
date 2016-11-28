#define PORT 42002
#include <netdb.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <iostream>
#include <errno.h>
#include <sstream>

int main(int argc, char **argv)
{
    using namespace std;
    int server = socket(AF_INET, SOCK_STREAM, 0);
	if(server == -1) {
  		cerr << "Opening stream socket failed. ERROR:" << errno << endl;
  		return -1;
	}

	struct sockaddr_in server_name;
	server_name.sin_family = AF_INET;
	server_name.sin_addr.s_addr=INADDR_ANY;
	server_name.sin_port = htons(PORT);
	memset(&(server_name.sin_zero),'\0',8);
    int _set=1;
    int iResult = setsockopt(server, SOL_SOCKET, SO_REUSEADDR, (char *) &_set, sizeof(int));
    if (iResult == -1) {
        cerr << "The call of setsockopt failed with error:" << errno << endl;
    } else {
        cerr << "\t\tSet SO_REUSEADDR: ON" << endl;
    }

	if( bind(server, (struct sockaddr *) &server_name, sizeof server_name ) == -1 ) {
    	cerr << "Binding stream socket failed." << endl;
    	return -1;
	}

	{
        struct sockaddr_in server_info;
        socklen_t _length = sizeof(server_info);
        if( getsockname( server, (struct sockaddr *) &server_info, &_length) == -1 ) {
            cerr << "Getting socket failed." << endl;
        }
        cout << "\t------------------------------------------------------" << endl;
        cout << "\t--> IPv4 Address is " << inet_ntoa(server_info.sin_addr) << endl;
        cout << "\t--> Port number is " << ntohs(server_info.sin_port) << endl;
        cout << "\t------------------------------------------------------" << endl;
	}

	if(listen(server,4)==-1) {
		cerr << "Listening failed to start." << endl;
		return -1;
	}
    cout << "\t>> Server is ready to accept incomming calls." << endl;
    string responseMessage1="Please enter the requested domain name for name resolution: ";
    string responseMessage2="INFO: Too long peer request. Maximum length is 200 bytes.";

    while (true) {
        int i = 0;
        string host_name;
        // Blokkol, amíg nincs beérkező hívás.
        struct sockaddr_in caller;
        socklen_t addrlen = sizeof(caller);
        int call = accept(server,(struct sockaddr *) &caller, &addrlen);

        ssize_t bytecontroll=send(call,responseMessage1.c_str(),strlen(responseMessage1.c_str()),0);
        if(bytecontroll==-1) {
            cout << " Send failed with error: " << errno << endl;
            close(call);
        } else if (bytecontroll > 0 && static_cast<size_t>(bytecontroll)==strlen(responseMessage1.c_str())) {
            char* puffer=new char[200];
            memset(puffer, '\0', 200);
            bytecontroll=recv(call, puffer, 200, 0);
            if(bytecontroll==0) {
                cout << "Connection closed by peer." << endl;
                close(call);
            }else if(bytecontroll<0){
                cout << "The recv call failed with error: " << errno << endl;
                close(call);
            } else if (bytecontroll < 200) {
                puffer[bytecontroll]='\0';
                struct hostent *remoteHost;
                struct in_addr addr;
                char **pAlias;
                host_name=puffer;
                if(host_name == "/q") {
                     cout << "Exit was requested by user. " << endl;
                     close(call);
                     break;
                }

                /*** kapcsolat részleteinek megjelenítése KEZDETE ***/
                struct sockaddr_in call_info;
                socklen_t length = sizeof(call_info);
                if( getsockname( call, (struct sockaddr *) &call_info, &length) == -1 ) {
                    cerr << "Getting socket failed." << endl;
                    close(call);
                    continue;
                }

                cout << "\t------------------------------------------------------" << endl;
                cout << "\t--> IPv4 Address is " << inet_ntoa(call_info.sin_addr) << endl;
                cout << "\t--> Port number is " << ntohs(call_info.sin_port) << endl;
                cout << "\t--> Requested domain: " << host_name << endl;
                cout << "\t------------------------------------------------------" << endl;
                /*** kapcsolat részleteinek megjelenítése VÉGE ***/

                remoteHost = gethostbyname(host_name.c_str());
                ostringstream responseTmp;
                if (remoteHost == NULL) {
                    if (h_errno != 0) {
                        if (h_errno == HOST_NOT_FOUND) {
                            responseTmp << "Host not found" << '\n';
                        } else if (h_errno == NO_DATA) {
                            responseTmp << "No data record found" << '\n';
                        } else {
                            responseTmp << "Function failed with error: " << h_errno << '\n';
                        }
                    }
                } else {
                    responseTmp << "Function returned:\n";
                    responseTmp << "\tOfficial name: " << remoteHost->h_name << '\n';
                    for (pAlias = remoteHost->h_aliases; *pAlias != 0; pAlias++) {
                        responseTmp << "\tAlternate name #" << (++i) << ": "<< (*pAlias);
                        responseTmp <<'\n' << remoteHost->h_name << '\n';
                    }
                    responseTmp << "\tAddress type: ";
                    switch (remoteHost->h_addrtype) {
                    case AF_INET:
                        responseTmp << "AF_INET" << '\n';
                        break;
                    default:
                        responseTmp << remoteHost->h_addrtype << '\n';
                        break;
                    }
                    responseTmp << "\tAddress length: " << remoteHost->h_length << '\n';

                    int i = 0;
                    if (remoteHost->h_addrtype == AF_INET)
                    {
                        while (remoteHost->h_addr_list[i] != 0) {
                            addr.s_addr = *(u_long *) remoteHost->h_addr_list[i++];
                            responseTmp << "\tAddress #" << i << ": " << inet_ntoa(addr) << '\n';
                        }
                    }
                }
                int bytecontroll=send(call,responseTmp.str().c_str(),strlen(responseTmp.str().c_str()),0);
                if(bytecontroll == -1) {
                    cerr << "Info has not been send to client, because an error occured: " << errno << endl;
                } else {
                    cout << "Info has been posted to client. Details:" << endl;
                    cout << responseTmp.str();
                    cout << ">--------------------------------------------<";
                }
            } else {
                cerr << "\tToo long request." << endl;
                bytecontroll=send(call,responseMessage2.c_str(),strlen(responseMessage2.c_str()),0);
                if(bytecontroll == -1) {
                    cerr << "Info has not been send to client, because an error occured: " << errno << endl;
                } else {
                    cout << "Info has been posted to client." << endl;
                }
            }
            delete[] puffer;
        }
        close(call);
    }
    close(server);

    
    cout << " << Server is now terminating." << endl;
    return 0;
}
