if [[ ! $(grep -F dovecot /etc/postfix/master.cf) ]]; then 
  echo "dovecot   unix  -       n       n       -       -       pipe" >> /etc/postfix/master.cf
  echo "   flags=DRhu user=vmail:vmail argv=/usr/lib/dovecot/dovecot-lda -f ${sender} -d ${recipient}" >>/etc/postfix/master.cf
fi
