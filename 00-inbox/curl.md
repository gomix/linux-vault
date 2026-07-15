We all know about curl right? Well maybe, but here goes some notes about it and how i use it.

```
; just pass a url and see what happens.
%> curl https://api.lab.example.com:6443
curl: (60) SSL certificate problem: self-signed certificate in certificate chain
More details here: https://curl.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the webpage mentioned above.

; make curl skip the verification step and proceed without checking
%> curl -k https://api.lab.example.com:6443
{
  "kind": "Status",
  "apiVersion": "v1",
  "metadata": {},
  "status": "Failure",
  "message": "forbidden: User \"system:anonymous\" cannot get path \"/\"",
  "reason": "Forbidden",
  "details": {},
  "code": 403
}%>

; i want to know more about the outcome of the query
; show me the response headers
%> curl -k -i https://api.lab.example.com:6443
HTTP/2 403 
audit-id: 840245fb-6039-4eb4-96e2-cb4d9bcecc5f
cache-control: no-cache, private
content-type: application/json
strict-transport-security: max-age=31536000; includeSubDomains; preload
x-content-type-options: nosniff
x-kubernetes-pf-flowschema-uid: 37a216c1-c8e7-4500-a0ac-037d56d8377e
x-kubernetes-pf-prioritylevel-uid: 843f1433-a572-4814-a43e-9167faa6183c
content-length: 217
date: Wed, 15 Jul 2026 08:41:14 GMT

{
  "kind": "Status",
  "apiVersion": "v1",
  "metadata": {},
  "status": "Failure",
  "message": "forbidden: User \"system:anonymous\" cannot get path \"/\"",
  "reason": "Forbidden",
  "details": {},
  "code": 403
}%>

; now i want to see the communication details
%> curl -k -v https://api.lab.example.com:6443
* Host api.lab.example.com:6443 was resolved.
* IPv6: (none)                                                                    
* IPv4: 3.66.111.259, 52.29.22.26, 52.58.127.254   
*   Trying 3.66.111.59:6443...                                                    
* ALPN: curl offers h2,http/1.1                                                   
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.3 (IN), TLS change cipher, Change cipher spec (1):
* TLSv1.3 (IN), TLS handshake, Encrypted Extensions (8):
* TLSv1.3 (IN), TLS handshake, Request CERT (13):          
* TLSv1.3 (IN), TLS handshake, Certificate (11): 
* TLSv1.3 (IN), TLS handshake, CERT verify (15):
* TLSv1.3 (IN), TLS handshake, Finished (20):                                
* TLSv1.3 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.3 (OUT), TLS handshake, Certificate (11):
* TLSv1.3 (OUT), TLS handshake, Finished (20):
* SSL connection using TLSv1.3 / TLS_AES_128_GCM_SHA256 / x25519 / RSASSA-PSS
* ALPN: server accepted h2              
* Server certificate:                                                             
*  subject: CN=api.lab.example.com                                                                                                                      
*  start date: Jul 14 08:02:50 2026 GMT                                                                                                                             
*  expire date: Aug 13 08:02:51 2026 GMT                                                                                                                            
*  issuer: OU=openshift; CN=kube-apiserver-lb-signer                  
*  SSL certificate verify result: self-signed certificate in certificate chain (19), continuing anyway.
*   Certificate level 0: Public key type RSA (2048/112 Bits/secBits), signed using sha256WithRSAEncryption
*   Certificate level 1: Public key type RSA (2048/112 Bits/secBits), signed using sha256WithRSAEncryption
* Connected to api.lab.example.com (3.66.111.59) port 6443
* using HTTP/2                                                                    
* [HTTP/2] [1] OPENED stream for https://api.lab.example.com:6443/
* [HTTP/2] [1] [:method: GET]           
* [HTTP/2] [1] [:scheme: https]
* [HTTP/2] [1] [:authority: api.lab.example.com:6443]
* [HTTP/2] [1] [:path: /]                                                         
* [HTTP/2] [1] [user-agent: curl/8.15.0]
* [HTTP/2] [1] [accept: */*]
> GET / HTTP/2
> Host: api.lab.example.com:6443
> User-Agent: curl/8.15.0                                                         
> Accept: */*                                                                     
>            
* Request completely sent off                                                     
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* received GOAWAY, error=0, last_stream=1 
< HTTP/2 403                                                                      
< audit-id: 416c483a-757a-4c46-8ff7-97b08f5ffc21
< cache-control: no-cache, private                                                
< content-type: application/json                                                  
< strict-transport-security: max-age=31536000; includeSubDomains; preload
< x-content-type-options: nosniff    
< x-kubernetes-pf-flowschema-uid: 37a216c1-c8e7-4500-a0ac-037d56d8377e
< x-kubernetes-pf-prioritylevel-uid: 843f1433-a572-4814-a43e-9167faa6183c
< content-length: 217
< date: Wed, 15 Jul 2026 08:49:25 GMT
<                                                                                              
{                                                                                 
  "kind": "Status",  
  "apiVersion": "v1",                
  "metadata": {},
  "status": "Failure",
  "message": "forbidden: User \"system:anonymous\" cannot get path \"/\"",        
  "reason": "Forbidden",
  "details": {}, 
  "code": 403         
* shutting down connection #0                                                     
}%>

; i want to see it all
%> curl --trace - https://api.lab.example.com.com:6443
== Info: Host api.lab.example.com.com:6443 was resolved.                  
== Info: IPv6: (none)                                                             
== Info: IPv4: 52.29.22.6, 3.66.111.59, 52.58.127.54                              
== Info:   Trying 52.29.22.6:6443...                                              
== Info: ALPN: curl offers h2,http/1.1                                            
=> Send SSL data, 5 bytes (0x5)                                                   
0000: 16 03 01 06 36                                  ....6           
== Info: TLSv1.3 (OUT), TLS handshake, Client hello (1):                          
=> Send SSL data, 1590 bytes (0x636)                                              
0000: 01 00 06 32 03 03 5b 46 32 90 67 22 64 7e 3b e7 ...2..[F2.g"d~;.            
0010: 81 2a 56 68 cb 9f bb 6f 14 3b 64 c9 be 2f bf 1c .*Vh...o.;d../..
0020: c0 f7 ae a0 77 2f 20 00 38 23 e6 79 23 7d e9 0c ....w/ .8#.y#}..            
0030: f7 29 3f 9e ed 3d 56 fe 13 ae a9 70 f5 79 d4 4f .)?..=V....p.y.O
0040: f3 3a f6 f1 bd ad f0 00 46 13 02 13 03 13 01 13 .:......F.......
0050: 04 c0 2c c0 30 cc a9 cc a8 c0 ad c0 2b c0 2f c0 ..,.0.......+./.            
0060: ac c0 23 c0 27 c0 0a c0 14 c0 09 c0 13 00 9d c0 ..#.'...........
0070: 9d 00 9c c0 9c 00 3d 00 3c 00 35 00 2f 00 9f cc ......=.<.5./...
0080: aa c0 9f 00 9e c0 9e 00 6b 00 67 00 39 00 33 01 ........k.g.9.3.
0090: 00 05 a3 ff 01 00 01 00 00 00 00 24 00 22 00 00 ...........$."..
...
== Info:  CAfile: /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem   
== Info:  CApath: none                                                            
<= Recv SSL data, 5 bytes (0x5)                                                   
0000: 16 03 03 00 7a                                  ....z                   
== Info: TLSv1.3 (IN), TLS handshake, Server hello (2):                  
<= Recv SSL data, 122 bytes (0x7a)  
...
06d0: 00 00                                           ..
=> Send SSL data, 5 bytes (0x5)
0000: 15 03 03 00 02                                  .....
== Info: TLSv1.3 (OUT), TLS alert, unknown CA (560):
=> Send SSL data, 2 bytes (0x2)
0000: 02 30                                           .0
== Info: SSL certificate problem: self-signed certificate in certificate chain
== Info: closing connection #0
curl: (60) SSL certificate problem: self-signed certificate in certificate chain
More details here: https://curl.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the webpage mentioned above.
```