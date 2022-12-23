---
title: "How to setup Apache to proxy and renegotiate an SSL connection"
date: 2018-10-02T19:02:32+02:00
---

I have no clue how to call this, but it solved a problem we had at a customer earlier this year. The problem: An ancient version of Java running SOA Suite 11g not being up to spec to speak the newes SSL ciphers. To make a longer story short - We put a proxy in the middle and configured that to upgrade the connection.

Here is the file:

```
# Configures outbound connection in Apache
# Location: /etc/httpd/conf.d/proxy.conf

<VirtualHost *:443 >
    ServerAdmin bas@homecooked.nl
    DocumentRoot /var/www
    ServerName proxy.homecooked.nl

    ## SSL config - server side
    # Enable SSL / TLS
    SSLEngine on

    # PEM encoded certificate
    SSLCertificateFile "/etc/pki/tls/certs/server-cert.pem"

    # PEM encoded private key
    SSLCertificateKeyFile "/etc/pki/tls/private/server-key.pem"

    # SSL protocols enabled and disabled, only use TLSv1.2
    SSLProtocol all -TLSv1.1 -TLSv1 -SSLv2 -SSLv3

    # Ciphers enabled and disabled
    # You probably want to check if this is relevant at the time you read this!
    SSLCipherSuite ALL:+HIGH:!ADH:!EXP:!SSLv2:!SSLv3:!MEDIUM:!LOW:!NULL:!aNULL

    # Server dictates cipher preference
    SSLHonorCipherOrder on

    ## Inbound client validation
    # File with certificate authorities we trust
    SSLCACertificateFile "/etc/pki/tls/certs/rabo-certs.crt"

    # Require client certificate
    SSLVerifyClient require

    # Maximum depth of CA Certificate in verification chain
    SSLVerifyDepth 10

    # Enable SSL for Proxy reguests
    # TODO: Investigate if this is ok!
    SSLProxyEngine on
    SSLProxyVerify none
    SSLProxyCheckPeerCN off
    SSLProxyCheckPeerName off
    SSLProxyCheckPeerExpire off

    # Points to client cert + Chain
    # Contains the keys the proxy uses to authenticate to the third party
    SSLProxyMachineCertificateFile "/etc/pki/tls/private/crmi_ktn_outbound_keys.key"

    ## Logging
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
    ErrorLog "/var/log/httpd/proxy_error.log"
    CustomLog "/var/log/httpd/proxy_access.log" combined

    <Location /proxy_location>
        ProxyPass "https://some-endpoint.homecooked.nl"
        ProxyPassReverse "https://some-endpoint.homecooked.nl"

        # Only accept the environment specific certificate!
        # Should match incoming client common name
        SSLRequire (%{SSL_CLIENT_S_DN_CN} eq "client-certificate.homecooked.nl")

        Order allow,deny
        Allow from all

    </Location>

</VirtualHost>
```
Regarding SSLProxyMachineCertificateFile, and this took me some time to find out, you need to concatenate the key and the certificate together, without any new line. If you want to add another certificate to this file, just put in exactly one newline.

This caused a lot of headaches at my desk. I hope someone finds this usefull!
