## VM and Bastion  Details
alias dev="ssh 10.183.36.75"
alias gke="ssh 10.183.160.118"
alias hrz="ssh lvs01seh02.lvs.paypal.com"
alias paz="ssh phx01pazseh02.ccg01.phx.paypalinc.com"


# Configuration for Python, PIP, OpenSSL to trust the PayPal Proxy Certificates
export REQUESTS_CA_BUNDLE='/usr/local/etc/openssl/certs/combined_cacerts.pem'
export SSL_CERT_FILE='/usr/local/etc/openssl/certs/combined_cacerts.pem'
export NODE_EXTRA_CA_CERTS='/usr/local/etc/openssl/certs/paypal_proxy_cacerts.pem'


export GONOPROXY="github.paypal.com"
export GONOSUMDB="github.paypal.com"
export GOPRIVATE="github.paypal.com"

[ -s "/Users/adjoseph/.scm_breeze/scm_breeze.sh" ] && source "/Users/adjoseph/.scm_breeze/scm_breeze.sh"